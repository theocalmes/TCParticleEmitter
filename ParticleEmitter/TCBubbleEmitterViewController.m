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

@interface TCBubbleEmitterViewController ()

@property (nonatomic, strong) NSMapTable *particleToViewMap;
@property (nonatomic, strong) TCParticleEmitter *emitter;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UIImage *particleImage;

@end

@implementation TCBubbleEmitterViewController

#pragma mark - UIViewController

- (id)init
{
    self = [super init];
    if (self) {
        _particleToViewMap = [NSMapTable strongToStrongObjectsMapTable];
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

- (UIImage *)particleImage
{
    if (!_particleImage) {
        _particleImage = [UIImage imageNamed:@"Circumventure-Sprits"];
    }

    return _particleImage;
}

- (TCParticleEmitter *)emitter
{
    if (!_emitter) {
        _emitter = [[TCParticleEmitter alloc] init];
        _emitter.position = CGPointMake(self.view.center.x, self.view.frame.size.height - 30);
        _emitter.delegate = self;

        TCUnderwaterField *underwaterField = [[TCUnderwaterField alloc] init];
        _emitter.fields = @[underwaterField];
        _emitter.initialVelocity = CGPointMake(0, 3);
        _emitter.birthRate = 0.15;
        _emitter.particleLifeTime = 8;
        _emitter.maxParticles = 200;
        _emitter.velocitySpread = CGPointMake(0, 5);
        _emitter.positionSpread = CGPointMake(7, 4);
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
    for (TCParticle *particle in self.particleToViewMap) {
        CALayer *layer = [self.particleToViewMap objectForKey:particle];
        layer.frame = TCCenterRect(layer.frame, particle.position);
        if (CGRectGetMinX(layer.frame) <= 0 || CGRectGetMaxX(layer.frame) >= CGRectGetWidth(self.view.bounds)) {
            particle.velocity = CGPointMake(-particle.velocity.x, particle.velocity.y);
        } else if (CGRectGetMinY(layer.frame) <= 0 || CGRectGetMaxY(layer.frame) >= CGRectGetHeight(self.view.bounds)) {
            particle.velocity = CGPointMake(particle.velocity.x, -particle.velocity.y);
        }
    }
}

#pragma mark - TCParticleEmitterDelegate

- (void)particleEmitter:(TCParticleEmitter *)emitter didCreateParticle:(TCParticle *)particle
{
    float size = 15 + TCSpread(8.0);
    float minOpacity = 0.4;

    CALayer *layer = [[CALayer alloc] init];
    layer.contents = (__bridge id)([self.particleImage CGImage]);
    layer.opacity = minOpacity + fabsf(TCSpread(1.0 - minOpacity));
    layer.frame = TCCenterRect(CGRectMake(0, 0, size, size), particle.position);

    [self.particleToViewMap setObject:layer forKey:particle];

    [self addShakeAnimationToLayer:layer];

    [self.view.layer addSublayer:layer];
}

- (void)particleEmitter:(TCParticleEmitter *)emitter willDestroyParticle:(TCParticle *)particle
{
    CALayer *layer = [self.particleToViewMap objectForKey:particle];
    [layer removeFromSuperlayer];
    [self.particleToViewMap removeObjectForKey:particle];
}

#pragma mark - User Interaction

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        for (TCParticle *particle in self.particleToViewMap) {
            particle.velocity = TCPointAdd(particle.velocity, TCSpreadPoint(CGPointMake(30, 30)));
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.anyObject locationInView:self.view];
    for (TCParticle *particle in self.particleToViewMap) {
        CALayer *layer = [self.particleToViewMap objectForKey:particle];
        if (CGRectContainsPoint(layer.frame, point)) {
            particle.lifetime = 0;
        }
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
