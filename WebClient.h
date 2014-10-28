//
//  WebClient.h
//  MultiBluetoothSync
//
//  Created by Mac-4 on 21/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface WebClient : NSObject
{
    NSTimeInterval startTime;
    __block NSTimeInterval endTime ;
    NSTimeInterval correctedTime;
}

@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong) NSString *timeStamp;
+ (WebClient *)sharedClient ;
-(void)getTime;
@end
