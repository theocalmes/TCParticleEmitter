//
//  TCImagePressureFieldView.h
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/26/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCParticleEmitter;

@interface TCImagePressureFieldView : UIView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image;

@property (nonatomic, strong) TCParticleEmitter *particleEmitter;

- (void)start;

@end
