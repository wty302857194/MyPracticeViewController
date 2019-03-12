//
//  YKLabel.h
//  
//
//  Created by youki on 16/1/14.
//  Copyright © 2016年 youki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YKLabelVerticalAlignmentModel)
{
    YKLabelVerticalAlignmentModelTop,
    YKLabelVerticalAlignmentModelMiddle,
    YKLabelVerticalAlignmentModelBottom,
};


@interface YKLabel : UILabel

// 设置lab从哪里开始显示
@property (assign, nonatomic) YKLabelVerticalAlignmentModel verticalAlignment;
// 行间距
@property (assign, nonatomic) CGFloat lineSpaceing;

@end
