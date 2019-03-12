//
//  ShunYiTableViewCell.h
//  MyPracticeViewController
//
//  Created byg on 16/10/21.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TYProgerssView;
@interface ShunYiTableViewCell : UITableViewCell
@property (nonatomic, strong)TYProgerssView *progressView;
@property (nonatomic, assign)CGFloat progress;
@end
