//
//  SuoYinViewController.m
//  MyPracticeViewController
//
//  Created by wbb on 2017/11/15.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "SuoYinViewController.h"
#import "user.h"

@interface SuoYinViewController ()

@end

@implementation SuoYinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化测试数据
    NSMutableArray *city = [[NSMutableArray alloc] init];
    NSMutableArray *_userArray = [NSMutableArray arrayWithObjects:@"北京",@"安徽",@"合肥",@"邯郸",@"蚌埠",@"上海",@"广州",@"西安",@"淮南",@"江西",@"武汉",@"广西",@"河北",@"俄罗斯",@"盐城",@"江苏",@"新疆",@"乌鲁木齐", nil];
    //项目集成时候，也就把这里的_userArray数据源换一下，其他代码用我的不变即可，就可快速按照索引排序和分类
    for (int i = 0; i < _userArray.count; i++) {

        user *us = [[user alloc] init];
        us.name = _userArray[i];
        [city addObject:us];
    }
    
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSArray *indexArr = [collation sectionTitles];
    //临时数据，存放section对应的userObjs数组数据
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:indexArr.count];
    
    //设置sections数组初始化：元素包含userObjs数据的空数据
    for (NSInteger index = 0; index < indexArr.count; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    //将用户数据进行分类，存储到对应的sesion数组中
    for (user *userObj in city) {
        
        //根据timezone的localename，获得对应的的section number
        NSInteger sectionNumber = [collation sectionForObject:userObj collationStringSelector:@selector(name)];
        
        //获得section的数组
        NSMutableArray *sectionUserObjs = [newSectionsArray objectAtIndex:sectionNumber];
        
        //添加内容到section中
        [sectionUserObjs addObject:userObj];
    }
    
    //排序，对每个已经分类的数组中的数据进行排序，如果仅仅只是分类的话可以不用这步
    for (NSInteger index = 0; index < indexArr.count; index++) {
        
        NSMutableArray *userObjsArrayForSection = [newSectionsArray objectAtIndex:index];
        
        //获得排序结果
        NSArray *sortedUserObjsArrayForSection = [collation sortedArrayFromArray:userObjsArrayForSection collationStringSelector:@selector(name)];
        
        //替换原来数组
        [newSectionsArray replaceObjectAtIndex:index withObject:sortedUserObjsArrayForSection];
    }
 
    NSLog(@"newSectionsArray === %@",newSectionsArray);
    NSMutableArray *sectionTitleArray = [NSMutableArray array];
    NSMutableArray *tempArr = [NSMutableArray array];
    [newSectionsArray enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (array.count == 0) {
            [tempArr addObject:array];
        }else{
            [sectionTitleArray addObject:indexArr[idx]];
        }
    }];
    [newSectionsArray removeObjectsInArray:tempArr];
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
