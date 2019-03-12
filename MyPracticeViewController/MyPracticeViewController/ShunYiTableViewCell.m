//
//  ShunYiTableViewCell.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 16/10/21.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "ShunYiTableViewCell.h"
#import "TYProgerssView.h"
@implementation ShunYiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(TYProgerssView *)progressView {
    if (!_progressView) {
        _progressView = [[TYProgerssView alloc] initWithFrame:CGRectMake(0, 20, 200, 20)];
        [self.contentView addSubview:_progressView];
    }
    return _progressView;
}

-(void)setProgress:(CGFloat)progress {
    self.progressView.progress = progress;
    self.progressView.noChoose_Color = [UIColor redColor];
    self.progressView.prs_Color = [UIColor blueColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
