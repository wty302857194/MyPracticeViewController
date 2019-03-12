//
//  DESelectView.h
//  MyPracticeViewController
//
//  Created by wbb on 2017/10/23.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SelectViewType) {
    WEBVIEWTYPE = 0,
    TABLEVIEWTYPE
};
@interface DESelectView : UIView
@property (nonatomic) SelectViewType selectViewType;
@property (nonatomic, copy)NSString *webUrlString;
@property (nonatomic, copy)NSArray *dataArr;

- (void)initDataArray:(NSArray *)arr withSelectViewType:(SelectViewType)selectViewType;
@end


