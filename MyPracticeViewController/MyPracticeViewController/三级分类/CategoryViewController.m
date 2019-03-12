//
//  CategoryViewController.m
//  MyPracticeViewController
//
//  Created by wbb on 2017/11/17.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "CategoryViewController.h"
#import "SearchResultConductTableViewCell.h"
#import "SearchResultModel.h"

@interface CategoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation CategoryViewController
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"home.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray *arr = dic[@"phoneList"];
        
        for (int i=0;i<arr.count;i++) {
            NSDictionary *dic = arr[i];
            SearchResultModel *resultModel = [SearchResultModel mj_objectWithKeyValues:dic];
            resultModel.cellHeight = 0;
            resultModel.isFlex = i==0?YES:NO;
            for (ListModel *listModel in resultModel.list) {
                listModel.cellHeight = 44;
                listModel.isFlex = YES;
            }
            [_dataArr addObject:resultModel];
        }
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultModel *resultModel = self.dataArr[indexPath.section];
    NSLog(@"===%ld",(long)resultModel.cellHeight);
    return resultModel.cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SearchResultModel *resultModel = self.dataArr[section];
    return resultModel.isFlex?1:0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    SearchResultConductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SearchResultConductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    SearchResultModel *resultModel = self.dataArr[indexPath.section];
    cell.searchModel = resultModel;

    cell.reloadCellHeightBlock = ^() {
        //这里只是刷新行的话 会有一个动画的问题,(下面一行的区头动画显示有问题不知道怎么回事)
//        [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    };
    
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
    SearchResultModel *resultModel = self.dataArr[section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor redColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = view.bounds;
    [button addTarget:self action:@selector(doFlex:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = section + 100;
    [button setTitle:resultModel.phoneNum forState:UIControlStateNormal];
    [view addSubview:button];
    return view;
}
- (void)doFlex:(UIButton *)btn  {
    NSInteger section = btn.tag - 100;
    SearchResultModel *model = self.dataArr[section];
    model.isFlex = !model.isFlex;
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
