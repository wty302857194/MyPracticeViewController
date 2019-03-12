//
//  ViewController.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 16/9/9.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize firstName = _myFirstName;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _myFirstName = @"张三";    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
