//
//  XHServiceModel.m
//  MyPracticeViewController
//
//  Created by wbb on 2018/4/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "XHServiceModel.h"

@implementation XHServiceModel

+ (NSDictionary *)objectClassInArray{
    return @{@"childs" : [XHServiceChildsModel class]};
}

@end


@implementation XHServiceChildsModel

@end
