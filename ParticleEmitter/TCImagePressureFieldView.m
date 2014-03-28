//
//  TCImagePressureFieldView.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/26/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCImagePressureFieldView.h"
#import "TCParticle.h"
#import "TCParticleEmitter.h"
#import "TCPressureField.h"
#import "TCUnderwaterField.h"

@interface TCImagePressureFieldView ()

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation TCImagePressureFieldView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        _particleEmitter = [[TCParticleEmitter alloc] init];
        _particleEmitter.position = self.center;

        TCPressureField *pressureField = [[TCPressureField alloc] initWithImage:image];
        pressureField.fieldEffectRadius = 15;

        TCUnderwaterField *underwaterField = [[TCUnderwaterField alloc] init];
        underwaterField.fieldStrength = -1;

        _particleEmitter.fields = @[pressureField, underwaterField];
        _particleEmitter.initialVelocity = CGPointMake(0, -10);
        _particleEmitter.velocitySpread = CGPointMake(0, 3);
        _particleEmitter.positionSpread = CGPointMake(0, 0);
        _particleEmitter.birthRate = 0.3;
        _particleEmitter.maxParticles = 1000;

        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];

        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}

- (void)start
{
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)update
{
    [self.particleEmitter updateEmitterWithTimeDelta:self.displayLink.duration];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    [[UIColor redColor] setFill];
    for (TCParticle *particle in self.particleEmitter.particles) {
        CGContextFillEllipseInRect(ctx, TCCenterRect(CGRectMake(0, 0, 3, 3), particle.position));
    }
}

@end