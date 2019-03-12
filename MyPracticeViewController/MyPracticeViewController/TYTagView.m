//
//  TYTagView.m
//  MyPracticeViewController
//
//  Created by wbb on 2018/4/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "TYTagView.h"

@implementation TYTagView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    UIButton *btn = [UIButton buttonWithTitle:@"" titleColor:nil font:[UIFont systemFontOfSize:15] target:self action:@selector(cartBtnClick) backImageName:@""];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.width.equalTo(btn.mas_height);
    }];
    
    UILabel *numLab = [UILabel labelWithTitle:@"99" color:[UIColor whiteColor] fontSize:15 alignment:NSTextAlignmentCenter];
    numLab.backgroundColor = hexColor(ff4e00);
    numLab.cornerRadius = 10;
    [self addSubview:numLab];
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(btn.mas_right);
        make.centerY.mas_equalTo(btn.mas_top);
    }];
}
- (void)cartBtnClick
{
    
}
@end

