//
//  TCGravityParticle.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/28/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCGravityParticle.h"

@implementation TCGravityParticle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setMasksToBounds:YES];
        [self setBackgroundColor:[[UIColor redColor] CGColor]];
        [self setCornerRadius:25.0f];
    }
    return self;
}

@end
