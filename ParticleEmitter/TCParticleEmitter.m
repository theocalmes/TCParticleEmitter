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

@interface TCParticleEmitter ()

@property (strong) NSMutableArray *liveParticles;
@property NSTimeInterval timeSinceLastBirth;

@end

float TCSpread(float spread) {
    return spread - drand48() * spread * 2;
}

CGPoint TCSpreadPoint(CGPoint point) {
    return CGPointMake(TCSpread(point.x), TCSpread(point.y));
}

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
    TCParticle *particle = [[TCParticle alloc] init];
    particle.position = TCPointAdd(self.position, TCSpreadPoint(self.positionSpread));
    particle.velocity = TCPointAdd(self.initialVelocity, TCSpreadPoint(self.velocitySpread));
    particle.lifetime = self.particleLifeTime + TCSpread(self.particleLifeTimeSpread);

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
        self.timeSinceLastBirth = 0;

        if (self.delegate) {
            [self.delegate particleEmitter:self didCreateParticle:newParticle];
        }
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
            if (self.delegate) {
                [self.delegate particleEmitter:self willDestroyParticle:particle];
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
