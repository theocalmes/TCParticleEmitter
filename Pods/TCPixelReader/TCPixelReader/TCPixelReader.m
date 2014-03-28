//
//  TCPixelReader.m
//  TCPixelReader
//
//  Created by Theodore Calmes on 3/21/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <UIKit/UIImage.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreFoundation/CoreFoundation.h>
#import "TCPixelReader.h"

TCMatrixIndex TCMatrixIndexMake(int row, int col) {
    TCMatrixIndex i;

    i.row = row;
    i.col = col;

    return i;
}

TCPixel TCPixelMake(uint8_t r, uint8_t g, uint8_t b, uint8_t a) {
    TCPixel p;

    p.red = r;
    p.green = g;
    p.blue = b;
    p.alpha = a;

    return p;
}

@interface TCPixelReader ()

@property (nonatomic) TCPixel *pixels;
@property (nonatomic) CGSize imageSize;

@end

@implementation TCPixelReader

+ (TCPixelReader *)pixelReaderWithImage:(UIImage *)image
{
    return [[TCPixelReader alloc] initWithImage:image];
}

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (!self) return nil;

    UIImage *png = [UIImage imageWithData:UIImagePNGRepresentation(image)];
    _imageSize = png.size;

    CFDataRef bitmap = CGDataProviderCopyData(CGImageGetDataProvider(png.CGImage));
    uint8_t *bytes = malloc(CFDataGetLength(bitmap));

    CFDataGetBytes(bitmap, CFRangeMake(0, CFDataGetLength(bitmap)), bytes);
    _pixels = (TCPixel *)bytes;

    return self;
}

- (TCPixel)pixelForRow:(NSInteger)row column:(NSInteger)col
{
    NSInteger width = (NSInteger)self.imageSize.width;
    return self.pixels[row * width + col];
}

- (void)mapPixelsWithBlock:(void (^)(TCPixel, TCMatrixIndex))block
{
    int cols = (int)self.imageSize.width;
    int rows = (int)self.imageSize.height;

    for (int row = 0; row < rows; row++)
        for (int col = 0; col < cols; col++)
            block([self pixelForRow:row column:col], TCMatrixIndexMake(row, col));
}

- (CGRect)featureBoundsForPixelsSatisfyingBlock:(bool (^)(TCPixel))block
{
    int cols = (int)self.imageSize.width;
    int rows = (int)self.imageSize.height;

    int MAX_X = 0;
    int MAX_Y = 0;
    int MIN_X = 0;
    int MIN_Y = 0;

    /*** GETS MAX_Y ***/
    for (int i=rows-1; i>=0; --i) {
        for (int j=cols-1; j>=0; --j) {
            if (block([self pixelForRow:i column:j])) {
                MAX_Y = i;
                i=-1;
                break;
            }
        }
    }

    /*** GETS MIN_Y ***/
    for (int i=0; i<rows; ++i) {
        for (int j=0; j<cols; ++j) {
            if (block([self pixelForRow:i column:j])) {
                MIN_Y = i;
                i = rows;
                break;
            }
        }
    }

    /*** GETS MAX_X ***/
    for (int j=cols-1; j>=0; --j) {
        for (int i=rows-1; i>=0; --i) {
            if (block([self pixelForRow:i column:j])) {
                MAX_X = j;
                j = -1;
                break;
            }
        }
    }

    /*** GETS MIN_X ***/
    for (int j=0; j<cols; ++j) {
        for (int i=0; i<rows; ++i) {
            if (block([self pixelForRow:i column:j])) {
                MIN_X = j;
                j = cols;
                break;
            }
        }
    }

    return CGRectMake(MIN_X, MIN_Y, MAX_X - MIN_X, MAX_Y - MIN_Y);
}

@end
