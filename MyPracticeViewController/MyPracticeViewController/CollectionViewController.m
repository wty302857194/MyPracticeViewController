//
//  CollectionViewController.m
//  MyPracticeViewController
//
//  Created by wbb on 2017/9/15.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "CollectionViewController.h"
#import "CeShiCollectionViewCell.h"
#define  cellHeight (kScreenWidth-41)/3.f
static NSString * const StoreListCell = @"CeShiCollectionViewCell";

@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -200, kScreenWidth, 200)];
//    view.backgroundColor = hexColor(ff4e00);
//    [self.collectionView addSubview:view];
    
    
}

#pragma mark - --懒加载collectionView--
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        //分区之间的间距
        flowLayout.sectionInset = UIEdgeInsetsMake(10,10,10,10);
        //cell之间的最小间距
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kScreenHeight) collectionViewLayout:flowLayout];
//        _collectionView.contentInset = UIEdgeInsetsMake(200.0f, 0.0f, 0.0f, 0.0f);
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"CeShiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:StoreListCell];
        // 这两句是必须要的
        [_collectionView registerClass:[CustomCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myhead"];
        // 代理方法进行配置
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsMake(10, 0, 10, 10);
}
- (CGSize) collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(cellHeight, cellHeight);
}
//每行cell之间的间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
// 列宽是系统自己计算的(列宽必须要写,cellHeight可能有小数导致精度不对,系统自己计算的列宽和自己写的不匹配,布局会出问题)
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 10;
//}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CeShiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:StoreListCell forIndexPath:indexPath];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(kScreenWidth, 40);
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0) {
        CustomCollectionHeader * headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myhead" forIndexPath:indexPath];
        headerView.layer.masksToBounds = YES;
        
        
        return headerView;
    }
    return nil;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


@implementation CustomCollectionHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}
@end
