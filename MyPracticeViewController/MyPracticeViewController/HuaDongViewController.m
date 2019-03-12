//
//  HuaDongViewController.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 16/9/9.
//  Copyright © 2016年 cjh. All rights reserved.
//
typedef  NS_ENUM(NSInteger,SelectType){
    TIMEENUM = 1,
    JULIENUM,
};
#import "HuaDongViewController.h"

@interface HuaDongViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITableView *m_timetableView,*m_typetableView;
    SelectType selectType;
    NSInteger index;
}
@property (weak, nonatomic) IBOutlet UIView *time_view;
@property (weak, nonatomic) IBOutlet UIView *JuLi_view;
@property (nonatomic,strong)UIView *m_selectedLine;
@end

@implementation HuaDongViewController
- (UIView *)m_selectedLine {
    if (!_m_selectedLine) {
        _m_selectedLine = [[UIView alloc] init];
        _m_selectedLine.backgroundColor = [UIColor purpleColor];
        [_titleView addSubview:_m_selectedLine];
        [_m_selectedLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(38);
            make.width.mas_equalTo(SCREEN_WIDTH/2.0);
            make.height.mas_equalTo(2);
        }];
    }
    return _m_selectedLine;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSubview];
    index = 1;
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(wipeGesture:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    left.numberOfTouchesRequired = 1;
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(wipeGesture:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    right.numberOfTouchesRequired = 1;
    [_content_scrollView addGestureRecognizer:left];
    [_content_scrollView addGestureRecognizer:right];
    
    NSString *str = @"123123123";
    
}
- (void)setSubview {
    _content_scrollView.delegate = self;
    _content_scrollView.contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, SCREENH_HEIGHT);
//    _content_scrollView.directionalLockEnabled = NO;

    UIButton *btn = (UIButton *)[self.view viewWithTag:TIMEENUM];
    [self BtnClickAction:btn];
    //tableview初始化
    m_timetableView = [[UITableView alloc] initWithFrame:self.time_view.bounds style:UITableViewStylePlain];
    m_timetableView.dataSource = self;
    m_timetableView.delegate = self;
    m_timetableView.backgroundColor = [UIColor redColor];
//    m_timetableView.tag = timeTableViewTAG;
    [self.time_view addSubview:m_timetableView];
    m_typetableView = [[UITableView alloc] initWithFrame:self.JuLi_view.bounds style:UITableViewStylePlain];
//    m_typetableView.tag = typeTableViewTAG;
    m_typetableView.dataSource = self;
    m_typetableView.delegate = self;
    m_typetableView.backgroundColor = [UIColor greenColor];
    [self.JuLi_view addSubview:m_typetableView];
    
    [m_timetableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    [m_typetableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    [self.view bringSubviewToFront:self.time_view];
    [self.view bringSubviewToFront:self.JuLi_view];
}
- (IBAction)BtnClickAction:(UIButton *)sender {

    if (selectType == sender.tag) {
        return;
    }
    switch (sender.tag) {
        case TIMEENUM:
        {
            selectType = TIMEENUM;

        }
            break;
        case JULIENUM:
        {
            selectType = JULIENUM;
            
        }
            break;
            
            
        default:
            break;
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [_content_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*(selectType-1), 0)];
        
    } completion:NULL];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.m_selectedLine setCenter:CGPointMake(SCREEN_WIDTH/2.0*(selectType-0.5), self.m_selectedLine.center.y)];
        
    } completion:NULL];
}
- (void)wipeGesture:(UISwipeGestureRecognizer *)sender {
//    NSInteger index = _content_scrollView.contentOffset.x / SCREEN_WIDTH;
     NSLog(@"=======%ld",(long)index);
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (index<2) {
            index++;
        }
        UIButton *btn = (UIButton *)[_titleView viewWithTag:index];
        [self BtnClickAction:btn];
    }else if (sender.direction == UISwipeGestureRecognizerDirectionRight){
        if (index>1) {
            index--;
        }
        UIButton *btn = (UIButton *)[_titleView viewWithTag:index];
        [self BtnClickAction:btn];
    }
}
#pragma mark - scrollviewDelegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark listViewdataSource method and delegate method
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"listviewid";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellid];
    }
    //文本标签
    cell.textLabel.text = [NSString stringWithFormat:@"标签%ld",(long)indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
//当选择下拉列表中的一行时，设置文本框中的值，隐藏下拉列表
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select");
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
