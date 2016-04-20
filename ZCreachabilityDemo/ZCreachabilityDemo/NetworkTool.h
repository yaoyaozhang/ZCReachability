//
//  NetworkTool.h
//  GCDtestDemo
//
//  Created by lizhihui on 16/3/4.
//  Copyright © 2016年 lizhihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCReachability.h"

@interface NetworkTool : NSObject

/**
 *  是否有网
 */
@property (nonatomic,assign)BOOL isReachable;

/**
 *  是否是WiFi
 */
@property (nonatomic,assign)BOOL isReachableWiFi;

/**
 *  是否是WLAN
 */
@property (nonatomic,assign)BOOL isReachableWLAN;

/**
 *  请求验证的网址
 */
@property (strong,nonatomic) ZCReachability *hostReach;

// 当前网络状况
@property (strong ,nonatomic) NSString *NetWorkStats;

/**
 *  是否开启网络监测
 */
- (void)isOpenReachability:(BOOL )isOpen;


/**
 *  当前网络状况
 */
- (NSString *)currentNetworkStatsString;


/**
 *  网络监测工具类
 */
+ (NetworkTool *)shareNetworkTool;
@end
