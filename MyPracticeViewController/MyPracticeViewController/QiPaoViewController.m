//
//  QiPaoViewController.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 16/12/1.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "QiPaoViewController.h"
#import "DESelectView.h"
#import "QiPaoTagView.h"

@interface QiPaoViewController (){
    UIButton *btn;
}

@end

@implementation QiPaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self shangShengQiPao];
   __block DESelectView *select_view = [[[NSBundle mainBundle] loadNibNamed:@"DESelectView" owner:nil options:nil] firstObject];
    select_view.frame = self.view.bounds;
    [select_view initDataArray:@[@"1",@"1",@"1",@"1",@"1"] withSelectViewType:TABLEVIEWTYPE];
    [self.view addSubview:select_view];
    
    [self addQiPAoView];
}
- (void)shangShengQiPao {
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnTouchClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(SCREEN_WIDTH/2-25, kScreenHeight-50, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}




- (void)btnTouchClick {
    UIImageView *img_view = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(btn.frame), CGRectGetMinY(btn.frame), 0, 0 )];
    img_view.image = [UIImage imageNamed:@""];
    img_view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:img_view];

    [UIView animateWithDuration:4 animations:^{
        img_view.frame= CGRectMake(arc4random()%(320-50), 0, 50, 50);
        img_view.alpha = 0;
    } completion:^(BOOL finished) {
        [img_view removeFromSuperview];
//        img_view = nil;
    }];
}


- (void)addQiPAoView {
    QiPaoTagView *qiPaoView = [[QiPaoTagView alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    qiPaoView.contentStrBlock = ^(NSString *contentStr) {
        
    };
    [self.view addSubview:qiPaoView];
}

@end
