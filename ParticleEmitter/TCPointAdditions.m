//
//  TCPointAdditions.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCPointAdditions.h"

CGFloat TCPointDotProduct(CGPoint a, CGPoint b) {
    return a.x * b.x + a.y * b.y;
}

CGFloat TCPointMagnitude(CGPoint a) {
    return sqrtf(TCPointDotProduct(a, a));
}

CGFloat TCPointAngle(CGPoint a) {
    return atan2f(a.y, a.x);
}

CGFloat TCDistanceBetweenPoints(CGPoint a, CGPoint b) {
    return sqrtf(powf(a.x - b.x, 2) + powf(a.y - b.y, 2));
}

CGPoint TCPointNormalize(CGPoint a) {
    CGFloat magnitude = TCPointMagnitude(a);
    return CGPointMake(a.x / magnitude, a.y / magnitude);
}

CGPoint TCPointAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

CGPoint TCPointSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

CGPoint TCPointScale(CGPoint a, CGFloat s) {
    return CGPointMake(a.x * s, a.y * s);
}

CGPoint TCPointMultiply(CGPoint a, CGPoint b) {
    return CGPointMake(a.x * b.x, a.y * b.y);
}

CGPoint TCPointMakeWithAngle(CGFloat angle, CGFloat magnitude) {
    return CGPointMake(magnitude * cosf(angle), magnitude * sinf(angle));
}

CGPoint TCRectCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect TCCenterRect(CGRect rect, CGPoint center) {
    CGRect r = CGRectMake(center.x - rect.size.width/2.0,
                          center.y - rect.size.height/2.0,
                          rect.size.width,
                          rect.size.height);
    return r;
}

float TCSpread(float spread){
    return spread - drand48() * spread * 2;
}

CGPoint TCSpreadPoint(CGPoint point) {
    return CGPointMake(TCSpread(point.x), TCSpread(point.y));
}

