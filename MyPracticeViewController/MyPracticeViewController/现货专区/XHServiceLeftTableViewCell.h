//
//  XHServiceLeftTableViewCell.h
//  MyPracticeViewController
//
//  Created by wbb on 2018/3/27.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHServiceLeftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *lineLab;
@property (nonatomic, assign) BOOL isShowLine;
@end
