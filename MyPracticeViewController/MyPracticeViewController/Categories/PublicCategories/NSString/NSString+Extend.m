//
//  NSString+Extend.m
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonDigest.h>  // 加密

@implementation NSString (Extend)

/**
 *  32位MD5加密
 */
- (NSString *)md5 {
    
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return [result copy];
}


/**
 *  SHA1加密
 */
-(NSString *)sha1 {
    
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return [result copy];
}



/*
 *  时间戳对应的NSDate
 */
-(NSDate *)date {
    
    NSTimeInterval timeInterval=self.floatValue;
    
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}


-(NSString *)ChangeNumberFormat
{
    if([self rangeOfString:@"."].length > 0)
    {
        NSArray *arr = [self componentsSeparatedByString:@"."];
        NSString *point = [arr lastObject];
        
        NSString *value = [arr firstObject];
        
        NSMutableString * reverseString = [NSMutableString string];
        for(int i = 0 ; i < value.length; i ++){
            //倒序读取字符并且存到可变数组数组中
            unichar c = [value characterAtIndex:value.length-i-1];
            [reverseString appendFormat:@"%c",c];
        }
        
        
        NSInteger cutCount = reverseString.length/4;
        NSMutableString *ret = [NSMutableString string];
        for(NSInteger i = 0 ; i<=cutCount;i++)
        {
            if(i == cutCount)
            {
                [ret appendFormat:@"%@",[reverseString substringFromIndex:i*3]];
            }
            else
            {
                [ret appendFormat:@"%@,",[reverseString substringWithRange:NSMakeRange(i*3, 3)]];
            }
        }
        
        
        NSMutableString * final = [NSMutableString string];
        for(int i = 0 ; i < ret.length; i ++){
            //倒序读取字符并且存到可变数组数组中
            unichar c = [ret characterAtIndex:ret.length-i-1];
            [final appendFormat:@"%c",c];
        }
        [final appendFormat:@".%@",point];
        return final;
    }
    else
    {
        NSString *value = self;
        
        NSMutableString * reverseString = [NSMutableString string];
        for(int i = 0 ; i < value.length; i ++){
            //倒序读取字符并且存到可变数组数组中
            unichar c = [value characterAtIndex:value.length-i-1];
            [reverseString appendFormat:@"%c",c];
        }
        
        
        NSInteger cutCount = reverseString.length/4;
        NSMutableString *ret = [NSMutableString string];
        for(NSInteger i = 0 ; i<=cutCount;i++)
        {
            if(i == cutCount)
            {
                [ret appendFormat:@"%@",[reverseString substringFromIndex:i*3]];
            }
            else
            {
                [ret appendFormat:@"%@,",[reverseString substringWithRange:NSMakeRange(i*3, 3)]];
            }
        }
        
        
        NSMutableString * final = [NSMutableString string];
        for(int i = 0 ; i < ret.length; i ++){
            //倒序读取字符并且存到可变数组数组中
            unichar c = [ret characterAtIndex:ret.length-i-1];
            [final appendFormat:@"%c",c];
        }
        return final;
    }
    return self;
}





@end
