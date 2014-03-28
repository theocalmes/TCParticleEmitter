//
//  TCPressureField.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/20/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCPressureField.h"
#import "TCPixelReader.h"
#import "TCParticle.h"

@interface TCPressureField ()

@property (strong) TCPixelReader *pixelReader;

@end

@implementation TCPressureField

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.pixelReader = [[TCPixelReader alloc] initWithImage:image];
    }
    return self;
}

#pragma mark - TCField

- (CGPoint)accelerationOnParticle:(TCParticle *)particle
{
    CGPoint acceleration = CGPointMake(0, 0);
    for (CGFloat r = self.fieldEffectRadius; r > 0; r--) {
        for (CGFloat phi = 0; phi < 2 * M_PI; phi++) {
            CGPoint diff = TCPointMakeWithAngle(phi, r);
            CGPoint pos = TCPointAdd(diff, particle.position);

            TCPixel pixel = [self.pixelReader pixelForRow:round(pos.x) column:round(pos.y)];
            diff = TCPointScale(diff,  -0.8 * pixel.blue / 255.0 * 1 / r);
            acceleration = TCPointAdd(acceleration, diff);
        }
    }

    return acceleration;
}

@end
