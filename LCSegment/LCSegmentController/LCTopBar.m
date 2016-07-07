//
//  LCTopBar.m
//  LCSegment
//
//  Created by mac1 on 16/7/6.
//  Copyright © 2016年 BNDK. All rights reserved.
//

#import "LCTopBar.h"

@implementation LCTopBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    CGFloat buttonW = (float)self.frame.size.width / _titles.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat indictorH = _indictorHeight == 0 ? 2 : _indictorHeight;
    
    NSLog(@"%f",buttonH);
    for (int i = 0; i < _titles.count; i ++) {
        UIButton *btn = [self viewWithTag:i + 1];
        btn.frame = CGRectMake(buttonW * i, 0, buttonW, buttonH - indictorH);
    }
    
    _indictor.frame = CGRectMake(0, buttonH - indictorH, buttonW, indictorH);
}



-(void)setTitles:(NSArray *)titles
{
    _titles = titles;
    for (int i = 0; i < titles.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.tag = i + 1;
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonAcion:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            self.indictor = [[UIView alloc] init];
            
            _indictor.backgroundColor = [UIColor redColor];
            [self addSubview:_indictor];
        }
    }
}


- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    if(indicatorColor){
        _indicatorColor = indicatorColor;
        _indictor.backgroundColor = indicatorColor;
    }
}


- (void)setIndictorHeight:(CGFloat)indictorHeight
{
    _indictorHeight = indictorHeight;
    [self setNeedsLayout];
}


- (void)setUnSelectedColor:(UIColor *)unSelectedColor
{
    if (unSelectedColor) {
        _unSelectedColor = unSelectedColor;
        for (int i = 0; i < _titles.count; i ++) {
            UIButton *btn = [self viewWithTag:i + 1];
            [btn setTitleColor:unSelectedColor forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor
{
    if (selectedColor) {
        _selectedColor = selectedColor;
        for (int i = 0; i < _titles.count; i ++) {
            UIButton *btn = [self viewWithTag:i + 1];
            [btn setTitleColor:selectedColor forState:UIControlStateSelected];
        }
    }
}

- (void)setItemFontSize:(CGFloat)itemFontSize
{
    if (itemFontSize != 0) {
        _itemFontSize = itemFontSize;
        for (int i = 0; i < _titles.count; i ++) {
            UIButton *btn = [self viewWithTag:i + 1];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:itemFontSize]];
        }
    }
}

- (void)buttonAcion:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(topBarSelectedButton:)]) {
        [self.delegate topBarSelectedButton:button];
    }
}

@end
