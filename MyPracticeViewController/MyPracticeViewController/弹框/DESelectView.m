//
//  DESelectView.m
//  MyPracticeViewController
//
//  Created by wbb on 2017/10/23.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "DESelectView.h"

@interface DESelectTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftLab;
@property (nonatomic, strong) UILabel *midLab1;
@property (nonatomic, strong) UILabel *midLab2;
@property (nonatomic, strong) UILabel *rightLab;

@end
@implementation DESelectTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftLab = [[UILabel alloc] init];
        _leftLab.font = [UIFont systemFontOfSize:13];
        _leftLab.textColor = [UIColor blackColor];
        _leftLab.backgroundColor = [UIColor redColor];
        _leftLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_leftLab];
        
        _midLab1 = [[UILabel alloc] init];
        _midLab1.font = [UIFont systemFontOfSize:13];
        _midLab1.textColor = [UIColor blackColor];
        _midLab1.backgroundColor = [UIColor blueColor];
        _midLab1.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_midLab1];
        
        _midLab2 = [[UILabel alloc] init];
        _midLab2.font = [UIFont systemFontOfSize:13];
        _midLab2.textColor = [UIColor blackColor];
        _midLab2.backgroundColor = [UIColor blueColor];
        _midLab2.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_midLab2];
        
        _rightLab = [[UILabel alloc] init];
        _rightLab.font = [UIFont systemFontOfSize:13];
        _rightLab.textColor = [UIColor blackColor];
        _rightLab.backgroundColor = [UIColor purpleColor];
        _rightLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_rightLab];
        
        [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
            make.right.mas_equalTo(_midLab1.mas_left);
            make.width.mas_equalTo(_midLab1.mas_width);
        }];
        [_midLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(_midLab2.mas_left);
            make.left.mas_equalTo(_leftLab.mas_right);
            make.width.mas_equalTo(_midLab2.mas_width);

        }];
        [_midLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(_rightLab.mas_left);
            make.left.mas_equalTo(_midLab1.mas_right);
            make.width.mas_equalTo(_rightLab.mas_width);

        }];
        [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(_midLab2.mas_right);
        }];
    }
    return self;
}
@end



@interface DESelectView ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DESelectView
- (IBAction)cancelBtnClick:(UIButton *)sender {
    self.hidden = YES;
    [self removeFromSuperview];
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[];//[NSArray array];
    }
    return _dataArr;
}

- (void)initDataArray:(NSArray *)arr withSelectViewType:(SelectViewType)selectViewType
{
    if (selectViewType == WEBVIEWTYPE) {
        self.webView.hidden = NO;
        self.tableView.hidden = YES;
        self.titleLab.text = @"活动规则";
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrlString]]];
    }else {
        self.webView.hidden = YES;
        self.tableView.hidden = NO;
        self.titleLab.text = @"购买记录";
        self.dataArr = arr;
        self.tableView.tableFooterView = [UIView new];
        [self.tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    DESelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DESelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.leftLab.text = @"时间";
        cell.midLab1.text = @"名称";
        cell.midLab2.text = @"数量";
        cell.rightLab.text = @"支付记录";
    }else {
        cell.leftLab.text = self.dataArr[indexPath.row];
        cell.midLab1.text = self.dataArr[indexPath.row];
        cell.midLab2.text = self.dataArr[indexPath.row];
        cell.rightLab.text = self.dataArr[indexPath.row];
        
    }
    return cell;
}
#pragma mark - webviewdelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"finish------");
}
@end
