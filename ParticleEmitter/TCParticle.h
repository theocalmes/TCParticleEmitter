//
//  TCParticle.h
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCParticle : NSObject

@property CGPoint position;
@property CGPoint velocity;
@property CGPoint acceleration;
@property NSTimeInterval lifetime;

- (BOOL)isAlive;
- (void)updatePositionWithTimeDelta:(NSTimeInterval)dt;

@end
