//
//  TYProgerssView.h
//  MyPracticeViewController
//
//  Created by 杨飞 on 16/11/10.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYProgerssView : UIView
@property(nonatomic,assign)double progress;
//未选择的背景色
@property (nonatomic,strong) UIColor *noChoose_Color;
// 进度条的颜色
@property (nonatomic,strong) UIColor *prs_Color;
@end
