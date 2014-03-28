//
//  TCGravityEmitterView.h
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/24/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCParticleEmitter;

@interface TCGravityEmitterView : UIView

@property (nonatomic, strong) TCParticleEmitter *particleEmitter;

- (void)start;

@end
