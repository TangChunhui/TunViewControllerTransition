//
//  FirstViewController.m
//  TunViewControllerTransition
//
//  Created by 涂育旺 on 2017/7/15.
//  Copyright © 2017年 Qianhai Jiutong. All rights reserved.
//

#import "FirstViewController.h"
#import "UIViewController+TunTransition.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.circleTransition) {
        [self animateCircleInverseTransition];
    }else if(self.pageTransition)
    {
        [self animatePageInverseTransition];
    }else
    {
        [self animateInverseTransition];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)push:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SecondViewController *secondVC = [sb instantiateViewControllerWithIdentifier:@"SecondViewController"];
    [self animateSystem];
    [self.navigationController pushViewController:secondVC animated:YES];
}

@end
