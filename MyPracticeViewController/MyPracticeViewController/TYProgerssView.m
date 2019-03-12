//
//  TYProgerssView.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 16/11/10.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "TYProgerssView.h"
@interface TYProgerssView()
{
    UIView *first_view;
    UILabel *progress_lab;
    CAShapeLayer *shapeLayer;
}
@end

@implementation TYProgerssView
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setUI {
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = self.bounds.size.height/2.f;
    
    first_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.bounds.size.height)];
    first_view.layer.cornerRadius = self.bounds.size.height/2.f;
    first_view.clipsToBounds = YES;
    [self addSubview:first_view];
    
//    [self setShapeLayer];
}
- (void)setShapeLayer {
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
//    shapeLayer.frame = self.bounds;
    [self.layer addSublayer:shapeLayer];
    
}
- (void)bezierPath:(double)progress {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width*progress, self.bounds.size.height) cornerRadius:self.bounds.size.height/2.f];
    shapeLayer.path = path.CGPath;
    
}
-(void)setProgress:(double)progress {
    [UIView animateWithDuration:0.5 animations:^{
        first_view.frame = CGRectMake(0, 0, self.bounds.size.width*progress, self.bounds.size.height);
//        [self bezierPath:progress];
    }];
    
}
-(void)setNoChoose_Color:(UIColor *)noChoose_Color {
    self.backgroundColor = noChoose_Color;
    
}
- (void)setPrs_Color:(UIColor *)prs_Color {
    first_view.backgroundColor = prs_Color;
    self.layer.borderColor = prs_Color.CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
