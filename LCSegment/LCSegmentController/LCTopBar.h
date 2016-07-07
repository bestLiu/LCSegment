//
//  LCTopBar.h
//  LCSegment
//
//  Created by mac1 on 16/7/6.
//  Copyright © 2016年 BNDK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LCTopBarSelectedButtonDelegate <NSObject>

@optional
- (void)topBarSelectedButton:(UIButton *)button;

@end


@interface LCTopBar : UIView


@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIView *indictor;

@property (nonatomic, assign) CGFloat indictorHeight;

@property (nonatomic, strong) UIColor *indicatorColor;

@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, strong) UIColor *unSelectedColor;

@property (nonatomic, assign) CGFloat itemFontSize;

@property (nonatomic, weak) id<LCTopBarSelectedButtonDelegate> delegate;

@end
