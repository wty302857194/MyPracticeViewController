//
//  NSDictionary+YBDictionaryToModel.h
//  YBDictionaryToModel
//
//  NSDictionary的一个category
//  里面有一个实例方法，用目标字典调用此方法，会将Property属性打印至控制台
//  PS：NSNumber方法只是简单判断，具体还要看接口文档

#import <Foundation/Foundation.h>

@interface NSDictionary (YBDictionaryToModel)

/**
 *	将字典key快速生成property，并打印至控制台
 */
- (void)propertyCodeForModel;

/**
 *	是否递归字典内的所有字典属性
 */
- (void)propertyCodeRecursionForModel;

@end
