//
//  LCSegmentViewController.h
//  LCSegment
//
//  Created by mac1 on 16/7/6.
//  Copyright © 2016年 BNDK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCSegmentViewController : UIViewController

//必须传的参数
@property (nonatomic, strong) NSArray *subViewControllers; // 子控制器
@property (nonatomic, strong) NSArray *titles; //item的title

// 可以不传的参数
@property (nonatomic, strong) UIColor *barBackgroundColor; // bar的背景颜色 （默认白色）
@property (nonatomic, assign) CGFloat barHeight; // bar的高度 （默认 40）
@property (nonatomic, assign) CGFloat barIndicatorHeight; // 指示view的高度 (默认2)
@property (nonatomic, strong) UIColor *barIndicatorColor; // 指示view的颜色 (默认红色)
@property (nonatomic, strong) UIColor *selectedColor; //选中item的颜色 (默认红色)
@property (nonatomic, strong) UIColor *unSelectedColor; //未选中item的颜色 (默认灰色)
@property (nonatomic, assign) CGFloat itemFontSize; //title的字体大小 （默认14）

@end
