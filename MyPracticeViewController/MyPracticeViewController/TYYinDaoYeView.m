//
//  TYYinDaoYeView.m
//  MyPracticeViewController
//
//  Created by wbb on 2017/8/16.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "TYYinDaoYeView.h"

@interface TYYinDaoYeView ()<UIScrollViewDelegate>
{
    NSArray *_imgsArr;
}

@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation TYYinDaoYeView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;//设置分页
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame imagesArr:(NSArray *)imgArr {
    self = [super initWithFrame:frame];
    if (self) {
        _imgsArr = imgArr;
        [self setUI];
    }
    return self;
    
}
- (void)setUI {
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width*(_imgsArr.count+1), self.height);
    [_imgsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width*idx, 0, self.width, self.height)];
        imgView.image = obj;
        [self.scrollView addSubview:imgView];
    }];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == (_imgsArr.count) *SCREEN_WIDTH) {
        [self removeFromSuperview];
    }
}
@end
