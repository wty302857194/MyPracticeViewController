//
//  NSDate+SQCalendarLogic.h
//  DateDemo
//
//  Created by CrazyBing on 15/11/1.
//  Copyright © 2015年 qq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SQCalendarLogic)
- (NSUInteger)numberOfDaysInCurrentMonth;
- (NSDate *)firstDayOfCurrentMonth;
- (NSUInteger)weeklyOrdinality;
- (NSUInteger)numberOfWeeksInCurrentMonth;
- (NSUInteger)weekDay;
- (NSUInteger)dateDay;
@end
