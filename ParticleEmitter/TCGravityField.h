//
//  TCGravityField.h
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCField.h"

@interface TCGravityField : NSObject <TCField>

@property CGPoint position;
@property float mass;

- (id)initWithPosition:(CGPoint)position mass:(float)mass;

@end
