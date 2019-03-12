//
//  SearchResultConductTableViewCell.h
//  CJHLogistics
//
//  Created by wbb on 2017/11/16.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResultModel;
typedef void(^ReloadCellHeightBlock)();
@interface SearchResultConductTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *dataSourceArr;
@property (nonatomic, strong) SearchResultModel *searchModel;
@property (nonatomic, assign) NSInteger cellHeight;
@property (nonatomic, copy) ReloadCellHeightBlock reloadCellHeightBlock;
@end
