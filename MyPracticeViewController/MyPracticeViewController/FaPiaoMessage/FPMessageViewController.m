//
//  FPMessageViewController.m
//  cjh
//
//  Created by 杨飞 on 17/2/21.
//  Copyright © 2017年 njcjh. All rights reserved.
//

#import "FPMessageViewController.h"
#import "FSTextView.h"
#import "LinkLabel.h"
@interface FPMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    FSTextView *_header_text_view;
    NSArray *shouPiao_titleArr,*shouPiao_placeHoder_titleArr;
    UIButton *dianZi_Btn,*zhiZhi_Btn;
    LinkLabel *tishi_lab;
    UIImageView *img1,*img2,*img3,*img4,*img5;
    BOOL isDZOrZhiZhi,isPersonOrTeam,orMX;
}
@property (weak, nonatomic) IBOutlet UITableView *table_view;
@property (nonatomic, strong)NSArray *sectionHeader_titleArr;
@end

@implementation FPMessageViewController
- (void)goBackNV
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置发票信息";
    shouPiao_titleArr = @[@"收票人手机",@"收票人邮箱"];
    shouPiao_placeHoder_titleArr = @[@"请输入收票人的手机号码",@"请输入收票人的邮箱"];
    UIBarButtonItem *right_bar = [[UIBarButtonItem alloc] initWithTitle:@"发票须知" style:UIBarButtonItemStylePlain target:self action:@selector(FPMustKnow)];
    
    self.navigationItem.rightBarButtonItem = right_bar;
    
    [self tableViewFooterView];
    GO_BACK;
}
- (void)FPMustKnow {
    NSLog(@"发票须知");
}
-(NSArray *)sectionHeader_titleArr {
    if (!_sectionHeader_titleArr) {
        _sectionHeader_titleArr = @[@"发票类型",@"发票抬头",@"收票人信息",@"发票内容"];
    }
    return _sectionHeader_titleArr;
}
- (void)tableViewFooterView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    self.table_view.tableFooterView = view;
    UIButton *_btn = [UIButton buttonWithType:0];
    _btn.backgroundColor=[UIColor colorWithHexString:@"#ff4e00" alpha:1];
    _btn.layer.masksToBounds = YES;
    [_btn setTitle:@"确 定" forState:UIControlStateNormal];
    _btn.layer.cornerRadius = 8;
    [_btn addTarget:self action:@selector(getRequest:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_btn];
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
}
#pragma mark listViewdataSource method and delegate method
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return GetAdaptiveViewRectHeight(273);
            break;
        case 1:
            return GetAdaptiveViewRectHeight(352);
            break;
        case 2:
            return GetAdaptiveViewRectHeight(122);
            break;
        case 3:
            return GetAdaptiveViewRectHeight(205);
            break;
        default:
            break;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = YES;
    if (indexPath.section == 0) {
        dianZi_Btn = [UIButton buttonWithTitle:@"电子发票" titleColor:hexColor(323232) font:[UIFont systemFontOfSize:15] target:self action:@selector(chooseFPTouch:)];
        dianZi_Btn.frame = CGRectMake(10, 10, GetAdaptiveViewRectWidth(324), GetAdaptiveViewRectHeight(111));
        dianZi_Btn.tag = 100;
        dianZi_Btn.borderWidth = 0.5;
        dianZi_Btn.borderColor = hexColor(323232);
        dianZi_Btn.cornerRadius = 3;
        [cell.contentView addSubview:dianZi_Btn];
        img1 = [[UIImageView alloc] init];
        img1.hidden = YES;
        img1.image = [UIImage imageNamed:@"cancelOilTicketYES"];
        [cell.contentView addSubview:img1];
        
        zhiZhi_Btn = [UIButton buttonWithTitle:@"纸质发票" titleColor:hexColor(323232) font:[UIFont systemFontOfSize:15] target:self action:@selector(chooseFPTouch:)];
        zhiZhi_Btn.tag = 101;
        zhiZhi_Btn.borderWidth = 0.5;
        zhiZhi_Btn.borderColor = hexColor(323232);
        zhiZhi_Btn.cornerRadius = 3;
        [cell.contentView addSubview:zhiZhi_Btn];
        img2 = [[UIImageView alloc] init];
        img2.hidden = YES;
        img2.image = [UIImage imageNamed:@"cancelOilTicketYES"];
        [cell.contentView addSubview:img2];
        
//        [dianZi_Btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.mas_equalTo(10);
//            make.width.mas_equalTo(GetAdaptiveViewRectWidth(324));
//            make.height.mas_equalTo(GetAdaptiveViewRectHeight(111));
//        }];
        [zhiZhi_Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dianZi_Btn.mas_top);
            make.width.mas_equalTo(dianZi_Btn.mas_width);
            make.height.mas_equalTo(dianZi_Btn.mas_height);
            make.left.mas_equalTo(dianZi_Btn.mas_right).offset(GetAdaptiveViewRectWidth(73));
        }];
        [img1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(dianZi_Btn.mas_top);
            make.centerX.mas_equalTo(dianZi_Btn.mas_right);
            make.width.height.mas_equalTo(GetAdaptiveViewRectWidth(45));
        }];
        [img2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(zhiZhi_Btn.mas_top);
            make.centerX.mas_equalTo(zhiZhi_Btn.mas_right);
            make.width.height.mas_equalTo(GetAdaptiveViewRectWidth(45));
        }];
        
        
        UIImageView *back_imgView = [[UIImageView alloc] init];
        back_imgView.image = [UIImage imageNamed:@"FP_back_imgView"];
        [cell.contentView addSubview:back_imgView];
        
        
        
        tishi_lab = [[LinkLabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(dianZi_Btn.frame)+10, 100, 20)];
        tishi_lab.textColor = hexColor(1fc9c0);
        
        tishi_lab.font = [UIFont systemFontOfSize:12.f];
        tishi_lab.text = @"什么是电子发票？";
        tishi_lab.shouldUnderline = YES;
        tishi_lab.shouldFullActive = YES;
        tishi_lab.userInteractionEnabled = YES;
        [tishi_lab addTarget:self action:@selector(whatIsFaPiao)];
        [cell.contentView addSubview:tishi_lab];
        
        UIImageView *tiShi_img = [[UIImageView alloc] init];
        tiShi_img.image = [UIImage imageNamed:@"what_fp_img"];
        [cell.contentView addSubview:tiShi_img];
        
        
//        [tishi_lab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(dianZi_Btn.mas_bottom).offset(GetAdaptiveViewRectHeight(42));
//            make.left.mas_equalTo(dianZi_Btn.mas_left);
//        }];
        
        [tiShi_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(tishi_lab.mas_centerY);
            make.left.mas_equalTo(tishi_lab.mas_right);
            make.width.height.mas_equalTo(GetAdaptiveViewRectHeight(40));
        }];
    }else if (indexPath.section == 1) {
        UIButton *geRen_btn = [UIButton buttonWithTitle:@"个人" titleColor:hexColor(323223) font:[UIFont systemFontOfSize:15] target:self action:@selector(FPPersonClick)];
        geRen_btn.borderWidth = 0.5;
        geRen_btn.borderColor = hexColor(323232);
        geRen_btn.cornerRadius = 3;
        [cell.contentView addSubview:geRen_btn];
        
        img3 = [[UIImageView alloc] init];
        img3.image = [UIImage imageNamed:@"cancelOilTicketYES"];
        [cell.contentView addSubview:img3];
        
        UIButton *DanWei_Btn = [UIButton buttonWithTitle:@"纸质发票" titleColor:hexColor(323232) font:[UIFont systemFontOfSize:15] target:self action:@selector(chooseFPTouch)];
        DanWei_Btn.borderWidth = 0.5;
        DanWei_Btn.borderColor = hexColor(323232);
        DanWei_Btn.cornerRadius = 3;
        [cell.contentView addSubview:DanWei_Btn];
        
        img4 = [[UIImageView alloc] init];
        img4.image = [UIImage imageNamed:@"cancelOilTicketYES"];
        [cell.contentView addSubview:img4];
        
        
        UIImageView *back_imgView = [[UIImageView alloc] init];
        back_imgView.image = [UIImage imageNamed:@"FP_back_imgView"];
        [cell.contentView addSubview:back_imgView];
        
        _header_text_view = [[FSTextView alloc]init];
        _header_text_view.delegate =self;
        _header_text_view.text = @"";
        _header_text_view.font = [UIFont systemFontOfSize:12];
        _header_text_view.placeholderColor = hexColor(aeaeae);
        _header_text_view.textColor = [UIColor colorWithHexColorString:@"323232" alpha:1];
        _header_text_view.maxLength = 200;
        _header_text_view.placeholder = @"请输入你的公司名称";
        [back_imgView addSubview:_header_text_view];
        
        __weak typeof (self)weakSelf = self;
        [_header_text_view addTextLengthDidMaxHandler:^(FSTextView *textView) {
            [Global promptMessage:@"输入文本不能超过200个字符~" inView:weakSelf.view];
        }];
        
        [geRen_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.width.mas_equalTo(GetAdaptiveViewRectWidth(258));
            make.height.mas_equalTo(GetAdaptiveViewRectHeight(111));
        }];
        [DanWei_Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(geRen_btn.mas_top);
            make.width.mas_equalTo(geRen_btn.mas_width);
            make.height.mas_equalTo(geRen_btn.mas_height);
            make.left.mas_equalTo(geRen_btn.mas_right).offset(GetAdaptiveViewRectWidth(73));
        }];
        
        [img3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(geRen_btn.mas_top);
            make.centerX.mas_equalTo(geRen_btn.mas_right);
            make.width.height.mas_equalTo(GetAdaptiveViewRectWidth(45));
        }];
        [img4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(DanWei_Btn.mas_top);
            make.centerX.mas_equalTo(DanWei_Btn.mas_right);
            make.width.height.mas_equalTo(GetAdaptiveViewRectWidth(45));
        }];
        [back_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(DanWei_Btn.mas_bottom).offset(10);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(GetAdaptiveViewRectHeight(111)+10);
        }];
        
        [_header_text_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-GetAdaptiveViewRectWidth(48));
            make.left.mas_equalTo(GetAdaptiveViewRectWidth(48));
            make.height.mas_equalTo(GetAdaptiveViewRectHeight(100));
        }];
        
        
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, (cell.contentView.height-20)/2.f, 80, 20)];
            lab1.text = shouPiao_titleArr[indexPath.row];
            lab1.textColor = hexColor(808080);
            lab1.textAlignment = NSTextAlignmentLeft;
            lab1.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:lab1];
            
            UITextField *right_tf = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right+10, lab1.y, kScreenWidth-lab1.right-20, 20)];
            right_tf.placeholder = shouPiao_placeHoder_titleArr[indexPath.row];
            right_tf.text = @"";
            right_tf.textAlignment = NSTextAlignmentRight;
            right_tf.font = [UIFont systemFontOfSize:15];
            right_tf.textColor = hexColor(323232);
            [cell.contentView addSubview:right_tf];
        }else {
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, (cell.contentView.height-20)/2.f, 80, 20)];
            lab1.text = shouPiao_titleArr[indexPath.row];
            lab1.textColor = hexColor(808080);
            lab1.textAlignment = NSTextAlignmentLeft;
            lab1.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:lab1];
            
            UITextField *right_tf = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right+10, lab1.y, kScreenWidth-lab1.right-20, 20)];
            right_tf.placeholder = shouPiao_placeHoder_titleArr[indexPath.row];
            right_tf.text = @"";
            right_tf.textAlignment = NSTextAlignmentRight;
            right_tf.font = [UIFont systemFontOfSize:15];
            right_tf.textColor = hexColor(323232);
            [cell.contentView addSubview:right_tf];
        }
        
    }else {
        UIButton *MX_btn = [UIButton buttonWithTitle:@"明 细" titleColor:hexColor(323223) font:[UIFont systemFontOfSize:15] target:self action:@selector(FPPersonClick)];
        MX_btn.borderWidth = 0.5;
        MX_btn.borderColor = hexColor(323232);
        MX_btn.cornerRadius = 3;
        [cell.contentView addSubview:MX_btn];
        
        img5 = [[UIImageView alloc] init];
        img1.image = [UIImage imageNamed:@"cancelOilTicketYES"];
        [cell.contentView addSubview:img5];
        
        [MX_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.width.mas_equalTo(GetAdaptiveViewRectWidth(258));
            make.height.mas_equalTo(GetAdaptiveViewRectHeight(111));
        }];
        [img5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(MX_btn.mas_top);
            make.centerX.mas_equalTo(MX_btn.mas_right);
            make.width.height.mas_equalTo(GetAdaptiveViewRectWidth(45));
        }];
    }
    //    }
    
    
    //    if (indexPath.section == 2) {
    //        if (indexPath.row == 0) {
    //            for (UIView *vi in cell.contentView.subviews) {
    //                if ([vi isKindOfClass:[UITextField class]]) {
    //                    UITextField *tf = (UITextField *)vi;
    //                    tf.text = @"";
    //                }
    //            }
    //        }else {
    //            for (UIView *vi in cell.contentView.subviews) {
    //                if ([vi isKindOfClass:[UITextField class]]) {
    //                    UITextField *tf = (UITextField *)vi;
    //                    tf.text = @"";
    //                }
    //            }
    //        }
    //    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return GetAdaptiveViewRectHeight(100);
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, GetAdaptiveViewRectHeight(100))];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    lab.text = self.sectionHeader_titleArr[section];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = hexColor(808080);
    lab.font = [UIFont systemFontOfSize:15];
    [view addSubview:lab];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = hexColor(f4f5f6);
    return view;
}
- (void)chooseFPTouch:(UIButton *)btn {//电子或者纸质
    if (btn.tag == 100) {
        [btn setTitleColor:hexColor(ff4e00) forState:UIControlStateNormal];
        img1.hidden = NO;
        btn.borderColor = hexColor(ff4e00);
        
        [zhiZhi_Btn setTitleColor:hexColor(323232) forState:UIControlStateNormal];
        img2.hidden = YES;
        zhiZhi_Btn.borderColor = hexColor(323232);
    }else {
        [btn setTitleColor:hexColor(ff4e00) forState:UIControlStateNormal];
        img2.hidden = NO;
        btn.borderColor = hexColor(ff4e00);
        
        [dianZi_Btn setTitleColor:hexColor(323232) forState:UIControlStateNormal];
        img1.hidden = YES;
        dianZi_Btn.borderColor = hexColor(323232);
    }
}
- (void)whatIsFaPiao {//
    NSLog(@"什么是发票");
    NSString *str = @"什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票什么是发票";
    float Y_height = [Global heightForText:str textFont:14 standardWidth:kScreenWidth-60];
    
    UIImageView *img_view = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(tishi_lab.frame)+10, kScreenWidth - 20, Y_height+40)];
    img_view.image = [UIImage imageNamed:@"FP_whatFP_img"];
    [self.table_view addSubview:img_view];
    
    UILabel *content_lab = [[UILabel alloc] init];
    content_lab.text = str;
    content_lab.numberOfLines = 0;
    content_lab.font = [UIFont systemFontOfSize:14];
    [img_view addSubview:content_lab];
    
    
    [content_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(Y_height);
    }];
    
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
