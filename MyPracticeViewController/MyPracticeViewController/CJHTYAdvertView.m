//
//  CJHTYAdvertView.m
//  cjh
//
//  Created by 杨飞 on 16/12/8.
//  Copyright © 2016年 njcjh. All rights reserved.
//

#import "CJHTYAdvertView.h"
@interface CJHTYAdvertView()
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic, strong)BtnTouchBlock  btnTouchBlock;
@property (nonatomic, strong)UIButton *btnTouch;
@end
@implementation CJHTYAdvertView
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        [self addSubview:_webView];
    }
    return _webView;
}
- (id)initWithFrame:(CGRect)frame withBtnTouchBlock:(BtnTouchBlock)btnTouchBlock {
    self =  [super initWithFrame:frame];
    if (self) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
        [self addSubview:self.btnTouch];
        self.btnTouchBlock = btnTouchBlock;
    }
    return self;
}

- (UIButton *)btnTouch {
    if (!_btnTouch) {
//        _btnTouch = [UIButton buttonWithTitle:@"开启1.8" titleColor:hexColor(002a66) font:[UIFont systemFontOfSize:20] target:self action:@selector(btnClick)];
//        _btnTouch.frame = CGRectMake(60, SCREEN_WIDTH-150, SCREENH_HEIGHT-120, 43);
//        _btnTouch.borderColor = hexColor(002a66);
//        _btnTouch.borderWidth = 1;
//        _btnTouch.cornerRadius = 43/2.0;
        
    }
    return _btnTouch;
}
- (void)btnClick {
    [self removeFromSuperview];
    self.btnTouchBlock();
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
