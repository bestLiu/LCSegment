//
//  TestViewController.m
//  LCSegment
//
//  Created by mac1 on 16/7/6.
//  Copyright © 2016年 BNDK. All rights reserved.
//

#import "TestViewController.h"
#import "TestOneVC.h"
#import "TestTwoVC.h"
#import "TestThreeVC.h"
#import "TestFourViewController.h"


@interface TestViewController ()

@end

@implementation TestViewController


- (instancetype)init
{
    if (self = [super init]) {
        TestOneVC *oneVC = [[TestOneVC alloc] init];
        TestTwoVC *twoVC = [[TestTwoVC alloc] init];
        TestThreeVC *threeVC = [[TestThreeVC alloc] init];
        TestFourViewController *fourVC = [[TestFourViewController alloc] init];
        
        self.subViewControllers = @[oneVC, twoVC, threeVC, fourVC];
        self.titles = @[@"第一个", @"第二个", @"第三个", @"第四个"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"LCSegment 2.0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
