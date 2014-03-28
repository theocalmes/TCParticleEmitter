//
//  TCField.h
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCParticle;

@protocol TCField <NSObject>

- (CGPoint)accelerationOnParticle:(TCParticle *)particle;

@end
