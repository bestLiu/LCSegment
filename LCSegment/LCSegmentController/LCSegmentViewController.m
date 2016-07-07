//
//  LCSegmentViewController.m
//  LCSegment
//
//  Created by mac1 on 16/7/6.
//  Copyright © 2016年 BNDK. All rights reserved.
//

//屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kAnimationDuration 0.3

#import "LCSegmentViewController.h"
#import "LCTopBar.h"

@interface LCSegmentViewController ()<LCTopBarSelectedButtonDelegate>

//正在显示的控制器
@property (nonatomic, weak) UIViewController *showingVc;

//存放除了导航栏以外的View
@property (nonatomic, weak) UIView *contentView;

//用来存放子控制器的view
@property (nonatomic, weak) UIView *vcContentView;

@property (nonatomic, weak) LCTopBar *topBar;

@end

@implementation LCSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    _contentView = contentView;
    
    UIView *vcContentView = [[UIView alloc] init];
    vcContentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:vcContentView];
    _vcContentView = vcContentView;
    
    self.showingVc = self.childViewControllers[0];
    self.showingVc.view.frame = _vcContentView.bounds;
    [_vcContentView addSubview:self.showingVc.view];

    LCTopBar *topBar = [[LCTopBar alloc] init];
    topBar.backgroundColor = self.barBackgroundColor ? self.barBackgroundColor : [UIColor whiteColor];
    topBar.delegate = self;
    topBar.titles = self.titles;
    
    
    //这里判断一下，免得过去遍历影响性能
    if(self.barIndicatorColor){
        topBar.indicatorColor = self.barIndicatorColor;
    }
    if (self.barIndicatorHeight != 0.0) {
        topBar.indictorHeight = self.barIndicatorHeight;
    }
    
    if (self.selectedColor) {
        topBar.selectedColor = self.selectedColor;
    }
    if (self.unSelectedColor) {
        topBar.unSelectedColor = self.unSelectedColor;
    }
    if (self.itemFontSize != 0.0) {
        topBar.itemFontSize = self.itemFontSize;
    }
    
    [contentView addSubview:topBar];
    _topBar = topBar;
    
}


- (void)viewDidLayoutSubviews
{
    CGFloat topBarH = self.barHeight == 0 ? 40.0 : self.barHeight;
    _contentView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    _topBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, topBarH);
    _vcContentView.frame = CGRectMake(0, topBarH, SCREEN_WIDTH, CGRectGetHeight(_contentView.frame) - topBarH);
}



//添加儿子
- (void)setSubViewControllers:(NSArray *)subViewControllers
{
    _subViewControllers = subViewControllers;
    for (UIViewController *controller in subViewControllers) {
        [self addChildViewController:controller];
    }
    
}

#pragma mark - LCTopBarSelectedButtonDelegate

- (void)topBarSelectedButton:(UIButton *)button
{
    for (UIView *subView in _topBar.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            btn.selected = NO;
        }
    }
    //button 选择
    button.selected = YES;
    
    //指示器移动
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
        CGRect rect = _topBar.indictor.frame;
        rect.origin.x = CGRectGetMinX(button.frame);
        _topBar.indictor.frame = rect;
        
    }];
    
    
    
    
    
    //将要显示的控制器的索引
    NSUInteger willIndex = button.tag - 1;
    
    //当前正在显示的控制器的索引
    NSUInteger oldIndex = [self.childViewControllers indexOfObject:self.showingVc];
    
    if (willIndex == oldIndex) {
        return;
    }
    
    
    // 移除其他控制器的view
    [self.showingVc.view removeFromSuperview];
    
    // 添加将要显示的控制器的View
    self.showingVc = self.childViewControllers[willIndex];
    
    //设置要显示的view的尺寸
    self.showingVc.view.frame = _vcContentView.bounds;
    
    //添加到contentView
    [_vcContentView addSubview:self.showingVc.view];
    
    // 动画
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionMoveIn;
    animation.subtype = willIndex < oldIndex ? kCATransitionFromRight : kCATransitionFromLeft;
    animation.duration = kAnimationDuration;
    
    //不需要动画可注释这一行
    [_vcContentView.layer addAnimation:animation forKey:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
