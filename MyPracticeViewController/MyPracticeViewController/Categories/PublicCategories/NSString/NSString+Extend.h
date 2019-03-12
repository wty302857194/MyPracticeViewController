//
//  NSString+Extend.h
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)
/**
 *  32位MD5加密
 */
@property (nonatomic,copy,readonly) NSString *md5;


/**
 *  SHA1加密
 */
@property (nonatomic,copy,readonly) NSString *sha1;


/*
 *  时间戳对应的NSDate
 */
@property (nonatomic,strong,readonly) NSDate *date;

-(NSString *)ChangeNumberFormat;





@end
