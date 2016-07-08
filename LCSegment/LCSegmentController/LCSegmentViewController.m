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

@interface LCSegmentViewController ()<LCTopBarSelectedButtonDelegate, UIScrollViewDelegate>

// 1.0代码---->>>>>>
//正在显示的控制器
@property (nonatomic, weak) UIViewController *showingVc;


//存放除了导航栏以外的View
@property (nonatomic, weak) UIView *contentView;

// 1.0代码---->>>>>>
//用来存放子控制器的view
@property (nonatomic, weak) UIView *vcContentView;

@property (nonatomic, weak) LCTopBar *topBar;

// 2.0代码--->>>>
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation LCSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    _contentView = contentView;
    

    CGFloat topBarH = self.barHeight == 0 ? 40.0 : self.barHeight;
    LCTopBar *topBar = [[LCTopBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topBarH)];
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
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topBarH, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - topBarH)];
    contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count , 0);
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.delegate = self;
    [contentView addSubview:contentScrollView];
     _contentScrollView = contentScrollView;
    
    /* 1.0 ---->>>>
//    UIView *vcContentView = [[UIView alloc] init];
//    vcContentView.backgroundColor = [UIColor whiteColor];
//    [contentView addSubview:vcContentView];
//    _vcContentView = vcContentView;
    
//    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAcion:)];
//    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
//    [vcContentView addGestureRecognizer:rightSwipe];
//    
//    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAcion:)];
//    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
//    [vcContentView addGestureRecognizer:leftSwipe];
    
    
    //默认显示第一个页面
//    self.showingVc = self.childViewControllers[0];
//    self.showingVc.view.frame = _vcContentView.bounds;
//    [_vcContentView addSubview:self.showingVc.view];
   */
    
    // 默认显示第一个页面    2.0---->>>>>>
    [self scrollViewDidEndScrollingAnimation:_contentScrollView];
}


- (void)viewDidLayoutSubviews
{
    // 1.0---->>>>
//    _vcContentView.frame = CGRectMake(0, topBarH, SCREEN_WIDTH, CGRectGetHeight(_contentView.frame) - topBarH);
    
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
    [self moveIndicatorWithButton:button];
    
    //控制器View的移动
    CGPoint offset = _contentScrollView.contentOffset;
    offset.x = (button.tag - 1) * _contentScrollView.frame.size.width;
    [_contentScrollView setContentOffset:offset animated:YES];
}



/*

// 手势  1.0代码--->>>
- (void)swipeAcion:(UISwipeGestureRecognizer *)swipeGesture
{
    //当前正在显示的控制器的索引
    NSUInteger oldIndex = [self.childViewControllers indexOfObject:self.showingVc];
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight) {
      
        if (oldIndex == 0)return;
        NSUInteger newIndex = oldIndex - 1;
        //button 选中改变
        [_topBar setSelectedButtonIndex:newIndex];
        
        //指示器移动
        [self moveIndicatorWithButton:[_topBar getSelectedItem]];
        
        [self moveSubViewWithOldIndex:oldIndex newIndex:newIndex];
        
    }else if(swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft){
        
        if (oldIndex == _subViewControllers.count - 1)return;
        NSUInteger newIndex = oldIndex + 1;
        
        //button 选中改变
        [_topBar setSelectedButtonIndex:newIndex];
        
        //指示器移动
        [self moveIndicatorWithButton:[_topBar getSelectedItem]];
        
        [self moveSubViewWithOldIndex:oldIndex newIndex:newIndex];
    }
}
 */


//移动指示器
- (void)moveIndicatorWithButton:(UIButton *)button
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
        CGRect rect = _topBar.indictor.frame;
        rect.origin.x = CGRectGetMinX(button.frame);
        _topBar.indictor.frame = rect;
    }];
}

// 1.0代码---->>>>>>
// 移动控制器的view
- (void)moveSubViewWithOldIndex:(NSInteger)oldIndex newIndex:(NSInteger)newIndex
{
    //控制器移动
    [self.showingVc.view removeFromSuperview];
    self.showingVc = self.childViewControllers[newIndex];
    self.showingVc.view.frame = _vcContentView.bounds;
    //添加到contentView
    [_vcContentView addSubview:self.showingVc.view];
    
    // 动画
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionMoveIn;
    animation.subtype = newIndex < oldIndex ? kCATransitionFromRight : kCATransitionFromLeft;
    animation.duration = kAnimationDuration;
    
    //不需要动画可注释这一行
    [_vcContentView.layer addAnimation:animation forKey:nil];

}
 

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / width;

    [_topBar setSelectedButtonIndex:index];
    [self moveIndicatorWithButton:[_topBar getSelectedItem]];
    UIViewController *willShowVc = self.childViewControllers[index];
    if ([willShowVc isViewLoaded])
    {
        [willShowVc viewDidAppear:YES];
        return;
    }
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
