//
//  SCViewViewController.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 2017/6/21.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "SCViewViewController.h"

@interface SCViewViewController () <UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;

@end

@implementation SCViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addTopView];
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREENH_HEIGHT*2);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;//进行分页
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.tag = 0;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)addTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    topView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:topView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, SCREENH_HEIGHT)];
    bottomView.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:bottomView];
    
    
//    UITableView *tableView =
}
#pragma -- <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@" --== %f",scrollView.contentOffset.y);
        if(scrollView.contentOffset.y<0){
            //            if(self.TopViewScale<1.01){
            //                self.TopViewScale += 0.00015f;
            //                [self.topView.icon_img setTransform:CGAffineTransformScale(self.topView.icon_img.transform, self.TopViewScale, self.TopViewScale)];
            //            }
            scrollView.contentOffset = CGPointMake(0, 0);
        }else{
            self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexColorString:@"ff4e00" alpha:scrollView.contentOffset.y/SCREENH_HEIGHT];//color(0.0,162.0,154.0, scrollView.contentOffset.y/(SCREENH_HEIGHT));
        }
        if(scrollView.contentOffset.y ==    SCREENH_HEIGHT){
            scrollView.scrollEnabled = NO;
        }else if (scrollView.contentOffset.y == -64 && !scrollView.isDragging){
            [UIView animateWithDuration:0.3 animations:^{
                scrollView.contentOffset = CGPointMake(0, 0);
            }];
        }
    
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
