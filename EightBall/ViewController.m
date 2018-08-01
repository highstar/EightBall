//
//  ViewController.m
//  EightBall
//
//  Created by Gao Xing on 2018/7/30.
//  Copyright © 2018年 Gao Xing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

static NSString* gAnswers[] = {
    @"\rYES",
    @"\rNO",
    @"\rMAYBE",
    @"I\rDON'T\rKNOW",
    @"TRY\rAGAIN\rSOON",
    @"READ\rTHE\rMANUAL"
};
#define kNumberOfAnswers (sizeof(gAnswers)/sizeof(NSString*))

@interface ViewController()

- (void)orientationChanged:(NSNotification *)notification;

- (void)fadeFortune;
- (void)newFortune;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [UIDevice.currentDevice beginGeneratingDeviceOrientationNotifications];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [UIDevice.currentDevice endGeneratingDeviceOrientationNotifications];
}

- (void)fadeFortune
{
    [UIView animateWithDuration:0.75 animations:^{
        self.answerView.alpha = 0.0;
    }];
}

- (void)newFortune
{
    self.answerView.text = gAnswers[arc4random_uniform(kNumberOfAnswers)];
    
    [UIView animateWithDuration:2.0 animations:^{
        self.answerView.alpha = 1.0;
    }];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
        [self fadeFortune];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
        [self newFortune];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
        [self newFortune];
}

- (void)orientationChanged:(NSNotification *)notification
{
    if (UIDevice.currentDevice.orientation == UIDeviceOrientationFaceUp)
        [self newFortune];
    else
        [self fadeFortune];
}

@end
