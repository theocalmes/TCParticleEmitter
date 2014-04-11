//
//  TCParticleEmitter.h
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCParticle, TCParticleEmitter;

@protocol TCParticleEmitterDelegate <NSObject>

- (void)particleEmitter:(TCParticleEmitter *)particleEmitter didEmittParticle:(TCParticle *)particle;
- (void)particleEmitter:(TCParticleEmitter *)particleEmitter willRemoveParticle:(TCParticle *)particle;

@end

@interface TCParticleEmitter : NSObject

@property (strong) NSArray *fields;
@property (strong, readonly) NSArray *particles;
@property (weak) id<TCParticleEmitterDelegate> delegate;

@property NSUInteger maxParticles;
@property NSTimeInterval birthRate;

@property NSTimeInterval particleLifeTime;
@property NSTimeInterval particleLifeTimeSpread;

@property CGFloat minOpacity;
@property CGFloat opacitySpread;

@property CGSize particleSize;
@property CGFloat particleSizeSpread;

@property CGPoint initialVelocity;
@property CGPoint velocitySpread;

@property CGPoint position;
@property CGPoint positionSpread;

@property (strong) CALayer *superLayer;

- (void)updateEmitterWithTimeDelta:(NSTimeInterval)dt;

@end
