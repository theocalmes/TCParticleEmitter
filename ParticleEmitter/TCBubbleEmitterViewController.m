//
//  TCEmitterViewController.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/21/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCBubbleEmitterViewController.h"
#import "TCParticleEmitter.h"
#import "TCParticle.h"
#import "TCGravityField.h"
#import "TCUnderwaterField.h"
#import "TCPointAdditions.h"
#import "TCBubbleParticle.h"

@interface TCBubbleEmitterViewController ()

@property (nonatomic, strong) TCParticleEmitter *emitter;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation TCBubbleEmitterViewController

#pragma mark - UIViewController

- (id)init
{
    self = [super init];
    if (self) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

#pragma mark - Getters

- (TCParticleEmitter *)emitter
{
    if (!_emitter) {
        _emitter = [[TCParticleEmitter alloc] init];
        _emitter.particleClass = [TCBubbleParticle class];
        _emitter.superLayer = self.view.layer;
        _emitter.position = CGPointMake(self.view.center.x, self.view.frame.size.height - 30);

        TCUnderwaterField *underwaterField = [[TCUnderwaterField alloc] init];
        _emitter.fields = @[underwaterField];
        _emitter.initialVelocity = CGPointMake(0, 3);
        _emitter.birthRate = 0.001;
        _emitter.particleLifeTime = 8;
        _emitter.maxParticles = 2000;
        _emitter.velocitySpread = CGPointMake(0, 5);
        _emitter.positionSpread = CGPointMake(100, 4);
        _emitter.particleSize = CGSizeMake(12, 12);
        _emitter.particleSizeSpread = 8;
        _emitter.minOpacity = 0.4;
        _emitter.opacitySpread = 0.6;
    }

    return _emitter;
}

#pragma mark - Animations

- (void)addShakeAnimationToLayer:(CALayer *)layer
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];

    CATransform3D t1 = CATransform3DScale (layer.transform, 1, 1, 1);
    CATransform3D t2 = CATransform3DScale (layer.transform, 0.9, 1, 1);
    CATransform3D t3 = CATransform3DScale (layer.transform, 1, 1, 1);
    CATransform3D t4 = CATransform3DScale (layer.transform, 1.0, 0.9, 1.0);
    CATransform3D t5 = CATransform3DScale (layer.transform, 1, 1, 1);;

    NSArray *boundsValues = @[[NSValue valueWithCATransform3D:t1], [NSValue valueWithCATransform3D:t2], [NSValue valueWithCATransform3D:t3], [NSValue valueWithCATransform3D:t4], [NSValue valueWithCATransform3D:t5]];

    [animation setValues:boundsValues];
    NSMutableArray *timingFunctions = [[NSMutableArray alloc] initWithCapacity:animation.values.count];
    for (NSUInteger i = 0; i < animation.values.count; i++) {
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    }
    [animation setTimingFunctions:timingFunctions.copy];
    animation.duration = 0.3;


    [animation setTimingFunctions:timingFunctions];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;

    [layer addAnimation:animation forKey:@"shake"];
}

#pragma mark - Emitter update

- (void)update
{
    [self.emitter updateEmitterWithTimeDelta:self.displayLink.duration];
    for (TCParticle *particle in [self.emitter particles]) {
        if (CGRectGetMinX(particle.frame) <= 0 || CGRectGetMaxX(particle.frame) >= CGRectGetWidth(self.view.bounds)) {
            particle.velocity = CGPointMake(-particle.velocity.x, particle.velocity.y);
        } else if (CGRectGetMinY(particle.frame) <= 0 || CGRectGetMaxY(particle.frame) >= CGRectGetHeight(self.view.bounds)) {
            particle.velocity = CGPointMake(particle.velocity.x, -particle.velocity.y);
        }
    }
}

#pragma mark - User Interaction

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        for (TCParticle *particle in [self.emitter particles]) {
            particle.velocity = TCPointAdd(particle.velocity, TCSpreadPoint(CGPointMake(30, 30)));
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.anyObject locationInView:self.view];
    for (TCParticle *particle in [self.emitter particles]) {
        if (CGRectContainsPoint(particle.frame, point)) {
            particle.lifetime = 0;
        }
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
