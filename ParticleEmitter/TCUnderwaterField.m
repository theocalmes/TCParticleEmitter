//
//  TCUnderwaterField.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/21/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCUnderwaterField.h"
#import "TCParticle.h"

@implementation TCUnderwaterField

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fieldStrength = -10;
    }
    return self;
}

#pragma mark - TCField

- (CGPoint)accelerationOnParticle:(TCParticle *)particle
{
    return CGPointMake(0, self.fieldStrength);
}

@end
