//
//  NSDictionary+YBDictionaryToModel.m
//  YBDictionaryToModel
//
//  Created by Queuey on 16/6/14.
//  Copyright © 2016年 Mr.Q. All rights reserved.
//

#import "NSDictionary+YBDictionaryToModel.h"

@implementation NSDictionary (YBDictionaryToModel)

- (void)propertyCodeForModel {
	[self printPropertyCodeToConsole:NO];
}
/**
 *	是否递归字典内的所有字典属性
 */
- (void)propertyCodeRecursionForModel {
	[self printPropertyCodeToConsole:YES];
}

- (void)printPropertyCodeToConsole:(BOOL)recursion {
	NSMutableString * printString = [NSMutableString new];
	
	if (!self) {
		NSLog(@"Dictionary is nil");
		return;
	}
	if (![self isKindOfClass:[NSDictionary class]]) {
		NSLog(@"it is not a dictionary!!!");
		return;
	}
	
	[self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
		NSString *str;
		
		NSLog(@"key: %@ \t\t %@",key,[obj class]);
		
		if ([obj isKindOfClass:[NSString class]]) {
			str = [NSString stringWithFormat:@"@property (nonatomic, copy  ) NSString *%@;",key];
		}
		
		if ([obj isKindOfClass:[NSArray class]]) {
			str = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
		}
		
		if ([obj isKindOfClass:[NSDictionary class]]) {
			str = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
			if (recursion) {
				[obj printPropertyCodeToConsole:YES];
			}
		}
		
		if ([obj isKindOfClass:[NSNumber class]]) {
			NSNumber *number = (NSNumber *)obj;
			if (strcmp(number.objCType, @encode(int)) == 0) {
				str = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
			}
			if (strcmp(number.objCType, @encode(Boolean)) == 0) {
				str = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
			}
			if (strcmp(number.objCType, @encode(float)) == 0) {
				str = [NSString stringWithFormat:@"@property (nonatomic, assign) CGFloat %@;",key];
			}
			if (strcmp(number.objCType, @encode(double)) == 0) {
				str = [NSString stringWithFormat:@"@property (nonatomic, assign) double %@;",key];
			}
			NSLog(@"%s",number.objCType);
		}
		
		if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
			str = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
		}
		
		[printString appendFormat:@"\n%@\n",str];
	}];
	
	NSLog(@"\n-----------------------------------------\n%@\n-----------------------------------------",printString);
	
}


@end
