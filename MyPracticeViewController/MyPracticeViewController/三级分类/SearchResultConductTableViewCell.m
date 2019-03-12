//
//  SearchResultConductTableViewCell.m
//  CJHLogistics
//
//  Created by wbb on 2017/11/16.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "SearchResultConductTableViewCell.h"
#import "SearchResultModel.h"

@interface SearchResultConductTableViewCell ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@end

@implementation SearchResultConductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
-(void)setSearchModel:(SearchResultModel *)searchModel {
    _searchModel = searchModel;
    [self getCellHeight];
    [self.tableView reloadData];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.contentView addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
        }];
    }
    return _tableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListModel *model = _searchModel.list[indexPath.section];
    NSLog(@"-=-=-=%ld",(long)model.cellHeight);
    return model.isFlex?44:0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ListModel *model = _searchModel.list[section];
    if (model.isFlex == NO) {
        return 0;
    }
    return model.goodsList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _searchModel.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    ListModel *model = _searchModel.list[indexPath.section];
    GoodsListModel *listMode = model.goodsList[indexPath.row];
    cell.textLabel.text = listMode.name;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ListModel *model = _searchModel.list[section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor blueColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = view.bounds;
    [button addTarget:self action:@selector(doFlex:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = section + 100;
    [button setTitle:model.name forState:UIControlStateNormal];
    [view addSubview:button];
    return view;
}
- (void)doFlex:(UIButton *)btn {
    
    NSInteger section = btn.tag - 100;
    ListModel *model = _searchModel.list[section];
    model.isFlex = !model.isFlex;
//    [self getCellHeight];
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    if (self.reloadCellHeightBlock) {
        self.reloadCellHeightBlock();
    }

}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)getCellHeight {
    NSInteger height = 0;
    for (ListModel *listModel in _searchModel.list) {
        height = (listModel.isFlex?listModel.goodsList.count:0)*(listModel.isFlex?44:0) + height;
    }
    _searchModel.cellHeight = _searchModel.list.count*40 + height;
}

@end
