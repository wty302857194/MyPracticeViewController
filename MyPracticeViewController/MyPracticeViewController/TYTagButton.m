//
//  TYTagButton.m
//  MyPracticeViewController
//
//  Created by wbb on 2018/4/8.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "TYTagButton.h"

@implementation TYTagButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setUI];
    }
    return self;
}
- (void)setUI {
    UILabel *numLab = [UILabel labelWithTitle:@"99" color:[UIColor whiteColor] fontSize:15 alignment:NSTextAlignmentCenter];
    numLab.backgroundColor = hexColor(ff4e00);
    numLab.cornerRadius = 10;
    [self addSubview:numLab];
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.centerX.equalTo(self.mas_top);
        make.centerY.equalTo(self.mas_right);
    }];
}
@end
