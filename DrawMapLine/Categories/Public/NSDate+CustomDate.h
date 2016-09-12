//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 15/6/25.
//  Copyright (c) 2015年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CustomDate)
//根据时间戳获取时间
/**
 *  获取date 根据时间戳 毫秒
 *
 *  @param timestamp 毫秒时间戳
 *
 *  @return 日期
 */
+(NSDate *)getDateWithInterval:(long long)timestamp;


/**
 *  获取自1970年的时间戳毫秒
 *
 *  @return 毫秒时间戳
 */
-(long long)getTimeIntervalSince1970Millisecond;


/**
 *  获取秒时间戳
 *
 *  @param millisecond 根据毫秒时间戳获取秒时间戳
 *
 *  @return 返回秒时间戳
 */
-(long long)getSecondFromMillisecond:(long long)millisecond;


/**
 *  获取月/日的表达字符串 10/22
 *
 *  @return 月/日组合的字符串
 */
-(NSString *)getMounthAndDayString;

/**
 *  获取小时分钟 string
 *
 *  @return string
 */
-(NSString *)getHourAndMinuteString;


/**
 *  获取当天零小时零分零秒的时间戳
 *
 *  @param date 
 *
 *  @return nsinteger
 */
+(long long)getZeroHourTimeStamp:(NSDate *)date;


/**
 *  获取年月日小时分钟的字符串
 *
 *  @return string
 */
-(NSString *)getYearMonthAndDayMInuteString;


/**
 *  获取当天零点时间戳
 *
 *  @return NSInteger
 */
+(long long)getCurrentDayTimeStamp;

/**
 *  获取是周几
 *
 *  @return 返回周几
 */
+(NSInteger)getWeekDay;

/**
 *  获取是这个月的几号
 *
 *  @return 这个月的几号
 */
+(NSInteger)getMonthDay;


@end
