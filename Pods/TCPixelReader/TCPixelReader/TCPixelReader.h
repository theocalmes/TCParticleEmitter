//
//  TCPixelReader.h
//  TCPixelReader
//
//  Created by Theodore Calmes on 3/21/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

typedef struct TCMatrixIndex {
    int row;
    int col;
} TCMatrixIndex;

TCMatrixIndex TCMatrixIndexMake(int row, int col);

typedef struct TCPixel {
    uint8_t red;
    uint8_t green;
    uint8_t blue;
    uint8_t alpha;
} TCPixel;

TCPixel TCPixelMake(uint8_t r, uint8_t g, uint8_t b, uint8_t a);

@interface TCPixelReader : NSObject

/**
 *  Creates a `TCPixelReader` object with the given image.
 *
 *  @param image which you want to read the pixels for.
 *
 *  @return `TCPixelReader` instance.
 */
+ (TCPixelReader *)pixelReaderWithImage:(UIImage *)image;

/**
 *  Designated initializer. Pass in a UIImage.
 *
 *  @param image which you want to read the pixels for.
 *
 *  @return `TCPixelReader` instance.
 */
- (id)initWithImage:(UIImage *)image;

/**
 *  This method lets you access the pixel at a certain location on the image. The image broken into a matrix of pixel values, thus you may access a pixel by its position in the matrix.
 *
 *  @param row equivalent to the y-axis
 *  @param col equivalent to the x-axis
 *
 *  @return a TCPixel for that point in space.
 */
- (TCPixel)pixelForRow:(NSInteger)row column:(NSInteger)column;

/**
 *  Convenience method for enumerating through all the images' pixels.
 *
 *  @param block enumeration block which provides you with the pixel and its index.
 */
- (void)mapPixelsWithBlock:(void(^)(TCPixel, TCMatrixIndex))block;


/**
 *  This method will return the largest bounding box which contains pixel whom pass the block.
 *
 *  @param block return true or false depending on whether the pixel passes your test.
 *
 *  @return the feature's bounding box.
 */
- (CGRect)featureBoundsForPixelsSatisfyingBlock:(bool(^)(TCPixel))block;

@end
