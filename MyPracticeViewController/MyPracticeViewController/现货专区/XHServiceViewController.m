//
//  XHServiceViewController.m
//  MyPracticeViewController
//
//  Created by wbb on 2018/3/19.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "XHServiceViewController.h"
#import "XHServiceTableViewCell.h"
#import "XHServiceLeftTableViewCell.h"

static NSInteger const leftCellHeight = 50;
@interface XHServiceViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UILabel *lineLab;
    BOOL _isShowClearView;
    NSInteger _leftSelectCellId;
}
@property (weak, nonatomic) IBOutlet UITableView *leftMenuTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *topMenuScrollView;
@property (weak, nonatomic) IBOutlet UITableView *rightContentTableView;
@property (weak, nonatomic) IBOutlet UIButton *rightChooseBtn;
@property (nonatomic, copy) NSArray *topBtnArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout;

@property (nonatomic, strong) UIView *clearView;
@end

@implementation XHServiceViewController

#pragma mark - 蒙版view
- (UIView *)clearView
{
    if (!_clearView) {
        _clearView = [[UIView alloc] init];
        [self.view addSubview:_clearView];
        [self.view bringSubviewToFront:_clearView];
        [_clearView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_topMenuScrollView.mas_bottom);
            make.left.bottom.right.mas_equalTo(0);
        }];
        
        float btn_width = (kScreenWidth - _leftMenuTableView.width - 40)/3.f;
        
        float  btn_height = btn_width*(70/132.f);
        
        
        NSInteger menuBackView_height = 0;
        if ((_topBtnArr.count+1)%3>0) {
            menuBackView_height = 10+(btn_height + 10)*(1+(_topBtnArr.count+1)/3);
        }else {
            menuBackView_height = 10+(btn_height + 10)*((_topBtnArr.count+1)/3);
        }
        
        UIView *menuBackView = [[UIView alloc] init];
        menuBackView.backgroundColor = [UIColor whiteColor];
        [_clearView addSubview:menuBackView];
        [menuBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_leftMenuTableView.mas_right);
            make.top.right.mas_equalTo(0);
            make.height.mas_equalTo(menuBackView_height);
        }];
        
        
        for (int i = 0; i<_topBtnArr.count+1; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:hexColor(ff4e00) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(clearMenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor whiteColor];
            btn.borderColor = hexColor(ff4e00);
            btn.borderWidth = 1;
            btn.layer.cornerRadius = 3;
            btn.frame = CGRectMake(10+(btn_width+10)*(i%3), 10 +(btn_height+10)*(i/3), btn_width, btn_height);
            btn.tag = 100+i;
            [menuBackView addSubview:btn];
            
            if (i == _topBtnArr.count) {
                [btn setTitle:@"收起" forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
            }else {
                [btn setTitle:_topBtnArr[i] forState:UIControlStateNormal];
            }
        }
    }
    return _clearView;
}
- (void)clearMenuBtnClick:(UIButton *)btn
{
    _isShowClearView = NO;
    self.clearView.hidden = YES;
    if (btn.tag - 100 < _topBtnArr.count) {
        
    }
}
- (IBAction)rightChooseBtnClick:(UIButton *)sender {
    if (!_isShowClearView) {
        _isShowClearView = YES;
        self.clearView.hidden = NO;
    }else {
        _isShowClearView = NO;
        self.clearView.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"现货专区";
    _topBtnArr = @[@"1",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2"];
    _topLayout.constant = 64;
    _leftSelectCellId = 0;
    
    self.leftMenuTableView.estimatedRowHeight = 0;
    self.leftMenuTableView.estimatedSectionHeaderHeight = 0;
    self.leftMenuTableView.estimatedSectionFooterHeight = 0;
    
    [self setTopScrollView];
    [self addBarButtonItem];
}
- (void)addBarButtonItem
{
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(10, 7, 30, 30);
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setImage:[UIImage imageNamed:@"default_head"] forState:UIControlStateNormal];
    
    UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    UIButton *cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cartBtn.frame = CGRectMake(10, 7, 30, 30);
    [cartBtn addTarget:self action:@selector(searchClick)
      forControlEvents:UIControlEventTouchUpInside];
    [cartBtn setBackgroundImage:[UIImage imageNamed:@"default_head"] forState:UIControlStateNormal];
    
    UIBarButtonItem *cartBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cartBtn];
    
    self.navigationItem.rightBarButtonItems = @[searchBarButtonItem,cartBarButtonItem];
}
- (void)searchClick
{
    
}
- (void)setTopScrollView
{
    float btn_width = 80.f;
    float scWidth = kScreenWidth - _leftMenuTableView.width - _rightChooseBtn.width;
    NSInteger btn_count = scWidth/btn_width;
    
    if (_topBtnArr.count<=btn_count) {
        _rightChooseBtn.hidden = YES;
        [_rightChooseBtn removeFromSuperview];
        btn_count = _topBtnArr.count;
    }else {
        _rightChooseBtn.hidden = NO;
    }
    
    for (int i = 0; i<btn_count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_topBtnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:hexColor(323232) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(topMenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = hexColor(fafafa);
        btn.frame = CGRectMake(btn_width*i, 0, btn_width, self.topMenuScrollView.height-0.5);
        self.topMenuScrollView.contentSize = CGSizeMake(btn_width*btn_count, self.topMenuScrollView.height);
        [self.topMenuScrollView addSubview:btn];
        
        if (i == 0) {
            lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.height, btn_width, 0.5)];
            lineLab.backgroundColor = hexColor(ff4e00);
            [_topMenuScrollView addSubview:lineLab];
        }
    }
}
- (void)topMenuBtnClick:(UIButton *)btn
{
    _isShowClearView = NO;
    self.clearView.hidden = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        lineLab.center = CGPointMake(btn.center.x, lineLab.center.y);
    }];
}

#pragma mark - UITableView - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftMenuTableView) {
        return leftCellHeight;
    }
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftMenuTableView) {
        return 20;
    }
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _leftMenuTableView) {
        return 1;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftMenuTableView) {
        static NSString *identifier = @"identifier";
        XHServiceLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XHServiceLeftTableViewCell" owner:nil options:nil] lastObject];
        }
        if (indexPath.row == _leftSelectCellId) {
            cell.lineLab.hidden = NO;
            cell.backgroundColor = hexColor(fafafa);
        }else {
            cell.lineLab.hidden = YES;
            cell.backgroundColor = hexColor(eeeeee);
        }
        return cell;
    }else {
        static NSString *identifier = @"identifier";
        XHServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XHServiceTableViewCell" owner:nil options:nil] lastObject];
        }
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _leftMenuTableView) {
        return 0;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == _leftMenuTableView) {
        return 0;
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _leftMenuTableView) {
        return nil;
    }
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView == _leftMenuTableView) {
        return nil;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _leftMenuTableView) {
        if (indexPath.row == _leftSelectCellId) {
            return;
        }
        [self.leftMenuTableView reloadData];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

        _leftSelectCellId = indexPath.row;
    }else {
        
    }
}
#pragma mark - 请求
- (void)XH_serviceRequestData
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSDictionary *dic = @{};
//    [HttpUtil postWithUrl:@"" withReq:dic successedBlock:^(NSDictionary *succeedResult) {
//        NSLog(@"%@===",succeedResult);
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        if ([succeedResult[@"code"] isEqualToString:@"0000"]) {
//
//        }else {
//            [Global promptMessage:succeedResult[@"msg"] inView:self.view];
//        }
//    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
}
@end
