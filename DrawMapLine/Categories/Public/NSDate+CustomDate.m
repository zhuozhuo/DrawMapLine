//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02

//
//  Created by aimoke on 15/6/25.
//  Copyright (c) 2015年 zhuo. All rights reserved.
//

#import "NSDate+CustomDate.h"
#import <NSDate+DateTools.h>
@implementation NSDate (CustomDate)

+(NSDate *)getDateWithInterval:(long long)timestamp
{
    return [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    
}


-(long long)getTimeIntervalSince1970Millisecond
{
    long long timeInterval = (long long)[self timeIntervalSince1970];
    return timeInterval*1000;
}


-(long long)getSecondFromMillisecond:(long long)millisecond
{
    return millisecond/1000;
}


-(NSString *)getMounthAndDayString
{
    return [self formattedDateWithFormat:@"M/d"];
}


-(NSString *)getHourAndMinuteString
{
    return [self formattedDateWithFormat:@"H:mm"];
}


-(NSString *)getYearMonthAndDayMInuteString
{
    return [self formattedDateWithFormat:@"yyyy/MM/dd HH:mm"];
}

+(long long)getZeroHourTimeStamp:(NSDate *)date
{
    NSDate *zeroDate = [[[date dateBySubtractingHours:[date hour]]dateBySubtractingMinutes:[date minute]]dateBySubtractingSeconds:[date second]];
    long long timeStamp = [zeroDate getTimeIntervalSince1970Millisecond];
    return timeStamp;
}

+(long long)getCurrentDayTimeStamp
{
    NSDate *date = [NSDate date];
    NSDate *zeroDate = [[[date dateBySubtractingHours:[date hour]]dateBySubtractingMinutes:[date minute]]dateBySubtractingSeconds:[date second]];
   long long timeStamp = [zeroDate timeIntervalSince1970];
    NSLog(@"timeStamp:%lld",timeStamp);
    timeStamp =  timeStamp*1000;
    NSLog(@"timeStamp:%lld",timeStamp);
    return timeStamp;
}

+(NSInteger)getWeekDay
{
    NSDate *endDate = [NSDate date];
    NSInteger day = [endDate weekday];
    if(day==1)
        day = 7;
    else
        day = day -1;
    
    return day;
}


+(NSInteger)getMonthDay
{
    NSDate *endDate = [NSDate date];
    NSInteger monthDay = [endDate day];
    return monthDay;
}


@end
