//
//  TCPointAdditions.h
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <Foundation/Foundation.h>

CGFloat TCPointMagnitude(CGPoint a);
CGFloat TCPointDotProduct(CGPoint a, CGPoint b);
CGFloat TCPointAngle(CGPoint a);
CGFloat TCDistanceBetweenPoints(CGPoint a, CGPoint b);

CGPoint TCPointNormalize(CGPoint a);
CGPoint TCPointAdd(CGPoint a, CGPoint b);
CGPoint TCPointSub(CGPoint a, CGPoint b);
CGPoint TCPointScale(CGPoint a, CGFloat s);
CGPoint TCPointMultiply(CGPoint a, CGPoint b);
CGPoint TCPointMakeWithAngle(CGFloat angle, CGFloat magnitude);

CGPoint TCRectCenter(CGRect rect);
CGRect TCCenterRect(CGRect rect, CGPoint center);