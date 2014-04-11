//
//  TCBubbleParticle.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/28/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCBubbleParticle.h"

static CGImageRef _bubbleImageRef;

@implementation TCBubbleParticle

+ (void)initialize
{
    _bubbleImageRef = [[UIImage imageNamed:@"bubble"] CGImage];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.contents = (__bridge id)_bubbleImageRef;
    }

    return self;
}

@end
