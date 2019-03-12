//
//  ShanGoShoppingTableViewController.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 16/9/22.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "ShanGoShoppingTableViewController.h"
//#import "ZLScrolling.h"

@interface ShanGoShoppingTableViewController (){
    NSArray *_pic_img_arr;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_view;

@end

@implementation ShanGoShoppingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
#pragma mark - 广告页
//- (void)topView {
//    ZLScrolling *zl = [[ZLScrolling alloc] initWithCurrentController:self frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT*56/135) photos:_pic_img_arr placeholderImage:[UIImage imageNamed:@"seckiliing_img_default"]];
//    zl.timeInterval = 4;
//    zl.delegate = self;
//    self.tableView.tableHeaderView = zl.view;
//}
#pragma mark - ZLScrolling代理
//- (void)zlScrolling:(ZLScrolling *)zlScrolling clickAtIndex:(NSInteger)index
//{
//    NSLog(@"点击到------%ld",(long)index);
//    if (index > _bannerList_model_arr.count) {
//        return;
//    } else {
//        Advertlist *advertModel = _bannerList_model_arr[index];
//        if ([advertModel.href isEqualToString:@"#"]||advertModel.href.length==0) {
//            return;
//        } else {
//            HomeWebViewController *homeWebViewController =[[HomeWebViewController alloc]initWithNibName:@"HomeWebViewController" bundle:nil];
//            [homeWebViewController passWebViewUrl:advertModel.href];
//            homeWebViewController.webTypeID = 10001;
//            [self.navigationController pushViewController:homeWebViewController animated:YES];
//        }
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
////    return cell;
//}


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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
