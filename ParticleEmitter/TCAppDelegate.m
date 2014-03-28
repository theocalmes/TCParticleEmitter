//
//  TCAppDelegate.m
//  ParticleEmitter
//
//  Created by Theodore Calmes on 3/19/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import "TCAppDelegate.h"
#import "TCBubbleEmitterViewController.h"
#import "TCGravityEmitterViewController.h"
#import "TCImageFieldViewController.h"

@implementation TCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithRed:0 green:73 / 255.0 blue:78 / 255.0 alpha:1.0];

    TCImageFieldViewController *viewController1 = [[TCImageFieldViewController alloc] initWithImage:[UIImage imageNamed:@"underwater_field"]];

    TCBubbleEmitterViewController *viewController2 = [[TCBubbleEmitterViewController alloc] init];

    TCGravityEmitterViewController *viewController3 = [[TCGravityEmitterViewController alloc] init];

    [self.window setRootViewController:viewController3];


    [self.window makeKeyAndVisible];
    return YES;
}

@end
