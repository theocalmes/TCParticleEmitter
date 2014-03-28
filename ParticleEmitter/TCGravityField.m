//
//  TCGravityField.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCGravityField.h"
#import "TCParticle.h"

@implementation TCGravityField

- (id)initWithPosition:(CGPoint)position mass:(float)mass
{
    self = [super init];
    if (self) {
        _position = position;
        _mass = mass;
    }
    return self;
}

#pragma mark - TCField

- (CGPoint)accelerationOnParticle:(TCParticle *)particle
{
    CGPoint distance = TCPointSub(self.position, particle.position);
    float F = self.mass / powf(TCPointDotProduct(distance, distance), 3/2);

    return TCPointScale(distance, F);
}

@end
