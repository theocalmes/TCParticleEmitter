//
//  TCParticleEmitter.h
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCParticle;
@protocol TCParticleEmitterDelegate;

@interface TCParticleEmitter : NSObject

@property (strong) NSArray *fields;
@property (strong, readonly) NSArray *particles;
@property (weak) id<TCParticleEmitterDelegate> delegate;

@property NSUInteger maxParticles;
@property NSTimeInterval birthRate;

@property NSTimeInterval particleLifeTime;
@property NSTimeInterval particleLifeTimeSpread;

@property CGPoint initialVelocity;
@property CGPoint velocitySpread;

@property CGPoint position;
@property CGPoint positionSpread;

- (void)updateEmitterWithTimeDelta:(NSTimeInterval)dt;

@end

@protocol TCParticleEmitterDelegate <NSObject>

- (void)particleEmitter:(TCParticleEmitter *)emitter didCreateParticle:(TCParticle *)particle;
- (void)particleEmitter:(TCParticleEmitter *)emitter willDestroyParticle:(TCParticle *)particle;

@end

float TCSpread(float spread);
CGPoint TCSpreadPoint(CGPoint point);