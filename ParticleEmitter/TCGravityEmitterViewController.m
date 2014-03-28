//
//  TCGravityEmitterViewController.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/26/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCGravityEmitterViewController.h"
#import "TCGravityEmitterView.h"

@interface TCGravityEmitterViewController ()

@end

@implementation TCGravityEmitterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    TCGravityEmitterView *fieldView = [[TCGravityEmitterView alloc] initWithFrame:self.view.bounds];
    [fieldView start];
    [self.view addSubview:fieldView];
}


@end
