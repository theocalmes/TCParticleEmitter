//
//  TCParticle.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCParticle.h"

@interface TCParticle ()

@property NSTimeInterval timeAlive;

@end

@implementation TCParticle

- (id)init
{
    self = [super init];
    if (self) {
        _velocity = CGPointZero;
        _acceleration = CGPointZero;
        _position = CGPointZero;
        _timeAlive = 0;
        _lifetime = 10;
    }
    return self;
}

- (BOOL)isAlive
{
    return self.lifetime - self.timeAlive > 0;
}

- (void)updatePositionWithTimeDelta:(NSTimeInterval)dt
{
    self.velocity = TCPointAdd(self.velocity, TCPointScale(self.acceleration, dt));
    self.position = TCPointAdd(self.position, TCPointScale(self.velocity, dt));
    self.timeAlive += dt;
}

@end
