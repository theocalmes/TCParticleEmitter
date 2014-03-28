//
//  TCPressureField.h
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/20/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCField.h"

@interface TCPressureField : NSObject <TCField>

- (id)initWithImage:(UIImage *)image;

@property CGFloat fieldEffectRadius;

@end
