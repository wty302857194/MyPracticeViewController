//
//  MyTableViewController.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 16/9/9.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "MyTableViewController.h"
#import "CAShapeLayerViewController.h"
#import "RoundeRectViewController.h"
#import "QiPaoViewController.h"
#import "PDFWebViewController.h"
#import "TimerViewController.h"
#import "SCViewViewController.h"
#import "FmdbViewController.h"
#import "CollectionViewController.h"
#import "DESelectView.h"
#import "SuoYinViewController.h"
#import "CategoryViewController.h"
//#import "MachineDistributionViewController.h"
//#import "DiDiAppointViewController.h"
#import "XHServiceViewController.h"
#import "HuaDongViewController.h"

@interface MyTableViewController (){
    HuaDongViewController *huadong;
}
@property (nonatomic,strong)NSArray *menu_arr;
@end

@implementation MyTableViewController


- (NSArray *)menu_arr {
    if (!_menu_arr) {
        _menu_arr = @[@"滑动菜单",@"百度地图",@"键盘弹出&自定义提示框",@"测试",@"顺义",@"CAShapeLayer",@"RoundedRect",@"气泡",@"pdf",@"倒计时",@"商品详情",@"数据库",@"myCollection",@"索引",@"三级分类",@"MachineDistributionViewController",@"MachineViewController",@"XHServiceViewController"];
    }
    return _menu_arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menu_arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid=@"listviewid";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:cellid];
    }
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];//为什么加上forIndexPath:indexPath 就不对了？
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
//    }
    cell.textLabel.text = self.menu_arr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            [self performSegueWithIdentifier:@"huaDong" sender:self];
//            self.firstBlock();
        }
            break;
        case 1:{
            [self performSegueWithIdentifier:@"guangGao" sender:self];
        }
            break;
        case 2:{
            [self performSegueWithIdentifier:@"ceshi" sender:self];
        }
            break;
        case 3:{
            [self performSegueWithIdentifier:@"yueshu" sender:self];
        }
            break;
        case 4:{
            [self performSegueWithIdentifier:@"ShunYiTableViewController" sender:self];
        }
            break;
        case 5:{
            CAShapeLayerViewController *ca = [[CAShapeLayerViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 6:{
            RoundeRectViewController *ca = [[RoundeRectViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 7:{
            QiPaoViewController *ca = [[QiPaoViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 8:{
            PDFWebViewController *ca = [[PDFWebViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 9:{
            TimerViewController *ca = [[TimerViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 10:{
            SCViewViewController *ca = [[SCViewViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 11:{
            FmdbViewController *ca = [[FmdbViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 12:{
            CollectionViewController *ca = [[CollectionViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 13:{
            SuoYinViewController *ca = [[SuoYinViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 14:{
            CategoryViewController *ca = [[CategoryViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 15:{
//            MachineDistributionViewController *ca = [[MachineDistributionViewController alloc] init];
//            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 16:{
//            DiDiAppointViewController *ca = [[DiDiAppointViewController alloc] init];
//            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 17:{
            XHServiceViewController *ca = [[XHServiceViewController alloc] init];
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        default:
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
