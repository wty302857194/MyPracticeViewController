//
//  XHServiceModel.h
//  MyPracticeViewController
//
//  Created by wbb on 2018/4/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
{
    "categoryId": 46,
    "name": "服饰鞋帽",
    "typeLogoLight": "20161107/ab677ee1ceb64d20934cea0cca54a5b7.png",
    "typeLogo": “20161107/eba5a00810d54a92bff350c4387d2844.png"
 “childs”:[
    {
        "categoryId": 47,
        "name": "男装",
        "typeIogoIight": null,
        "typeIogo": "20151224/7cc093fb33ec455b9cf40eb46ebebab6.jpg"
    } ]
}
 */
@interface XHServiceModel : NSObject
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *typeLogoLight;
@property (nonatomic, copy) NSString *typeLogo;
@property (nonatomic, strong) NSArray *childs;

@end
@interface XHServiceChildsModel : NSObject
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *typeIogoIight;
@property (nonatomic, copy) NSString *typeIogo;
@end
