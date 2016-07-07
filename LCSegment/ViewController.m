//
//  ViewController.m
//  LCSegment
//
//  Created by mac1 on 16/7/6.
//  Copyright © 2016年 BNDK. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonAction:(id)sender {
    TestViewController *vc = [[TestViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
