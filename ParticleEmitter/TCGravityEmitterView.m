//
//  TCGravityEmitterView.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/24/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCGravityEmitterView.h"
#import "TCParticle.h"
#import "TCParticleEmitter.h"
#import "TCGravityField.h"

@interface TCGravityEmitterView ()

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation TCGravityEmitterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _particleEmitter = [[TCParticleEmitter alloc] init];
        _particleEmitter.position = self.center;

        TCGravityField *gravityField1 = [[TCGravityField alloc] initWithPosition:CGPointMake(100, 100) mass:500];
        TCGravityField *gravityField2 = [[TCGravityField alloc] initWithPosition:CGPointMake(300, 200) mass:400];
        TCGravityField *gravityField3 = [[TCGravityField alloc] initWithPosition:CGPointMake(200, 400) mass:250];

        _particleEmitter.fields = @[gravityField1, gravityField2, gravityField3];
        _particleEmitter.initialVelocity = CGPointMake(0, -10);
        _particleEmitter.velocitySpread = CGPointMake(3, 3);
        _particleEmitter.positionSpread = CGPointMake(4,4);
        _particleEmitter.birthRate = 0.01;
        _particleEmitter.maxParticles = 3000;

        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];

        self.backgroundColor = [UIColor whiteColor];
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

    [[UIColor blueColor] setFill];
    for (TCGravityField *field in self.particleEmitter.fields) {
        CGContextFillEllipseInRect(ctx, TCCenterRect(CGRectMake(0, 0, 10 * field.mass / 500, 10 * field.mass / 500), field.position));
    }

    [[UIColor redColor] setFill];
    for (TCParticle *particle in self.particleEmitter.particles) {
        CGContextFillEllipseInRect(ctx, TCCenterRect(CGRectMake(0, 0, 3, 3), particle.position));
    }
}

@end