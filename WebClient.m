//
//  WebClient.m
//  MultiBluetoothSync
//
//  Created by Mac-4 on 21/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//
//yahoo app id 6MfCyK50

#import "WebClient.h"
#define DEV_URL @"http://developer.yahooapis.com/TimeService/V1/getTime?appid=6MfCyK50&output=json"
#define TimeApi @"3UMC1ATK1CV0"

 static WebClient *_sharedClient = nil;

@implementation WebClient

+ (WebClient *)sharedClient {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(id)init
{
    self.manager = [[AFHTTPRequestOperationManager alloc]init];
    return self;
}

-(void)getTime{
    
    startTime = [[NSDate date] timeIntervalSince1970];
    endTime = 0;
    
    [self.manager GET:DEV_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        endTime = [[NSDate date]timeIntervalSince1970];
         NSLog(@" time %f",endTime-startTime);
        
        _timeStamp = [[responseObject valueForKey:@"Result"] valueForKey:@"Timestamp"];
        NSLog(@"timeStamp %@",_timeStamp);
        [self startClock];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
   
}


-(void)startClock
{
    NSLog(@" zfa  %f",[self timeIntervalFromString:_timeStamp]);
    correctedTime = [self timeIntervalFromString:_timeStamp] + endTime - startTime;
    NSLog(@"Corrrected time %f",correctedTime);
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(plusOneSecond) userInfo:nil repeats:YES];
 }

-(void)plusOneSecond{
    correctedTime = correctedTime + 1;
}

- (NSTimeInterval)timeIntervalFromString:(NSString *)string {
    double timestampComment = [string doubleValue];
    return timestampComment;
}

@end
