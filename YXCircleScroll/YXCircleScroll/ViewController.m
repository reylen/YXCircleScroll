//
//  ViewController.m
//  YXCircleScroll
//
//  Created by reylen on 15-1-25.
//  Copyright (c) 2015年 ray. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *imageArray = @[@"1.jpg",@"2.jpg"/*,@"3.jpg",@"4.jpg",@"5.jpg"*/];
    YXCircleScrollView *circleScrollView = [[[YXCircleScrollView alloc]initWithFrame:self.view.bounds dataSource:imageArray] autorelease];
    circleScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:circleScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
