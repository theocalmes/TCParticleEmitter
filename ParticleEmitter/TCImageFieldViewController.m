//
//  TCImageFieldViewController.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/26/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCImageFieldViewController.h"
#import "TCImagePressureFieldView.h"

@interface TCImageFieldViewController ()

@property (strong) UIImage *image;

@end

@implementation TCImageFieldViewController

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (!self) return nil;

    _image = image;

    NSLog(@"image %@", _image);

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:[[UIImageView alloc] initWithImage:self.image]];

    TCImagePressureFieldView *fieldView = [[TCImagePressureFieldView alloc] initWithFrame:self.view.bounds image:self.image];
    [fieldView start];
    [self.view addSubview:fieldView];
}

@end
