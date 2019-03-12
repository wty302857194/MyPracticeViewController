//
//  TimerViewController.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 17/3/21.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController (){
    int now_time;
}
@property (weak, nonatomic) IBOutlet UILabel *time_lab;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    now_time = 60;

     NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
     [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}
- (void)timerAction {
    now_time--;
    NSLog(@"_timer ==== %d",now_time);
    _time_lab.text = [NSString stringWithFormat:@"倒计时：%d",now_time];
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
