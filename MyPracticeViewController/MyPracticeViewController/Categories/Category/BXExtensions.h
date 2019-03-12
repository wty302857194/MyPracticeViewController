//
//  BXExtensions.h
//  BXInsurenceBroker
//
//  Created by JYJ on 16/3/15.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "UIApplication+Extensions.h"
#import "UIScreen+Extension.h"

#import "UIDevice+DeviceType.h"

#import "UIView+IBExtension.h"
#import "UIView+Runtime.h"
#import "UIView+Extension.h"

#import "NSString+BXExtension.h"
#import "NSDate+Extension.h"

#import "UIBarButtonItem+Extension.h"
#import "UIImage+Extension.h"
#import "UILabel+Extension.h"
#import "UIButton+Extension.h"

#import "UIImage+ScreenShot.h"
#import "UIFont+Extension.h"

#import "NSDictionary+Extension.h"
/**
 *  弱引用
 */
#define BXWeakSelf __weak typeof(self) weakSelf = self;

#define BXNoteCenter [NSNotificationCenter defaultCenter]

#define BXScreenH [UIScreen mainScreen].bounds.size.height
#define BXScreenW [UIScreen mainScreen].bounds.size.width
#define BXScreenBounds [UIScreen mainScreen].bounds
#define BXKeyWindow [UIApplication sharedApplication].keyWindow