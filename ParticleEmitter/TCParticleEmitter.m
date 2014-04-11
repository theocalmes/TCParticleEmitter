//
//  TCParticleEmitter.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCParticleEmitter.h"
#import "TCParticle.h"
#import "TCField.h"
#import "TCPointAdditions.h"

@interface TCParticleEmitter ()

@property (strong) NSMutableArray *liveParticles;
@property NSTimeInterval timeSinceLastBirth;

@end

@implementation TCParticleEmitter

- (id)init
{
    self = [super init];
    if (self) {
        _maxParticles = 300;
        _velocitySpread = CGPointZero;
        _position = CGPointZero;
        _initialVelocity = CGPointMake(-10, 3);
        _liveParticles = [NSMutableArray new];
        _timeSinceLastBirth = 0;
        _birthRate = 1;
        _particleLifeTime = 100;
        _particleLifeTimeSpread = 0;
        _particleClass = [TCParticle class];
    }

    return self;
}

- (void)applyForceFieldToParticle:(TCParticle *)particle
{
    CGPoint newAcceleration = CGPointZero;
    
    for (id<TCField> field in self.fields) {
        CGPoint accelerationFromField = [field accelerationOnParticle:particle];
        newAcceleration = TCPointAdd(newAcceleration, accelerationFromField);
    }

    particle.acceleration = newAcceleration;
}

- (TCParticle *)emittNewParticle
{
    TCParticle *particle = [[self.particleClass alloc] init];

    CGFloat sizeSread = TCSpread(self.particleSizeSpread);
    particle.bounds = CGRectMake(0, 0, self.particleSize.width + sizeSread, self.particleSize.height +  sizeSread);

    particle.opacity = self.minOpacity + TCSpread(self.opacitySpread);
    particle.position = TCPointAdd(self.position, TCSpreadPoint(self.positionSpread));
    particle.velocity = TCPointAdd(self.initialVelocity, TCSpreadPoint(self.velocitySpread));
    particle.lifetime = self.particleLifeTime + TCSpread(self.particleLifeTimeSpread);

    if (self.superLayer) {
        [self.superLayer addSublayer:particle];
    }

    return particle;
}

- (BOOL)shouldSpawnNewParticle
{
    return self.birthRate - self.timeSinceLastBirth < 0 && self.maxParticles > self.liveParticles.count;
}

- (void)updateEmitterWithTimeDelta:(NSTimeInterval)dt
{
    if ([self shouldSpawnNewParticle]) {
        TCParticle *newParticle = [self emittNewParticle];
        [self.liveParticles addObject:newParticle];

        if ([self.delegate respondsToSelector:@selector(particleEmitter:didEmittParticle:)]) {
            [self.delegate particleEmitter:self didEmittParticle:newParticle];
        }
        self.timeSinceLastBirth = 0;
    }
    self.timeSinceLastBirth += dt;

    [self cleanupParticles];

    for (TCParticle *particle in self.liveParticles) {
        [self applyForceFieldToParticle:particle];
    }

    for (TCParticle *particle in self.liveParticles) {
        [particle updatePositionWithTimeDelta:dt];
    }
}

- (void)cleanupParticles
{
    NSMutableArray *deadParticles = [NSMutableArray array];
    for (TCParticle *particle in self.liveParticles) {
        if (![particle isAlive]) {
            [deadParticles addObject:particle];
            if ([self.delegate respondsToSelector:@selector(particleEmitter:willRemoveParticle:)]) {
                [self.delegate particleEmitter:self willRemoveParticle:particle];
            }
            if (self.superLayer) {
                [particle removeFromSuperlayer];
            }
        }
    }

    [self.liveParticles removeObjectsInArray:deadParticles];
}

- (NSArray *)particles
{
    return self.liveParticles.copy;
}

@end
