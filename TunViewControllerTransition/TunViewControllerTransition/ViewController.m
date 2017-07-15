//
//  ViewController.m
//  TunViewControllerTransition
//
//  Created by 涂育旺 on 2017/7/15.
//  Copyright © 2017年 Qianhai Jiutong. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+TunTransition.h"
#import "CollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取指定视图
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [self animateTransitionFromView:cell.imageView toView:@"imageView"];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *firstVC = [sb instantiateViewControllerWithIdentifier:@"FirstViewController"];
    
    [self.navigationController pushViewController:firstVC animated:YES];
    
    

}

@end
