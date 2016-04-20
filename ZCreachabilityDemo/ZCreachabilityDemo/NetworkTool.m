//
//  NetworkTool.m
//  GCDtestDemo
//
//  Created by lizhihui on 16/3/4.
//  Copyright © 2016年 lizhihui. All rights reserved.
//



#import "NetworkTool.h"
#import <UIKit/UIKit.h>


@interface NetworkTool(){
    /**
     *  是否开启网络监测
     */
   BOOL _isReachability;
}
@end

@implementation NetworkTool

// 单例
+ (NetworkTool *)shareNetworkTool{
    static NetworkTool *_instac = nil;
    
    static dispatch_once_t onceToKen;
    dispatch_once(&onceToKen, ^{
        _instac = [[NetworkTool alloc]init];
    });
    return _instac;
}

// 初始化
- (id)init{
    self = [super init];
    if (self) {
        [self addNetWorkObserver];
        _isReachability = NO;
    }
    return self;
}

// 添加网络监听
- (void)addNetWorkObserver{
    if (self.NetWorkStats == nil) {
        // 设置网络监测文案
        self.NetWorkStats = [self currentNetworkStatsString];
    }
    
    self.hostReach = [ZCReachability reachabilityWithHostName:@"www.baidu.com"];
    
    // 开启网络状况的监测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    [self .hostReach startNotifier];
    
}

-(void)reachabilityChanged:(NSNotification *)not{
    // 对改变做出响应
    ZCNetworkStatus status = [self.hostReach currentReachabilityStatus];
    self.isReachable = YES;
    if (status == ZCNotReachable) {
        self.NetWorkStats = @"没有网啊";
        self.isReachable = NO;
        self.isReachableWiFi = NO;
        self.isReachableWLAN = NO;
    }else{
        self.isReachable = YES;
        if (status == ZCReachableViaWiFi) {
            self.NetWorkStats = @"WifI";
            self.isReachableWiFi = YES;
            self.isReachableWLAN = NO;
        }else{
            self.NetWorkStats = @"WLAN";
            self.isReachableWiFi = NO;
            self.isReachableWLAN = YES;
        }
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.NetWorkStats = [self currentNetworkStatsString];
        });
        
    }
    
    if (_isReachability) {
        NSLog(@"发送网络监测的通知 ***");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"网络监测" object:nil];
    }
    
    
    
}


// 循环获取状态栏图标，判断网络实际情况
- (NSString *)currentNetworkStatsString{

     UIApplication *app = [UIApplication sharedApplication];
    
    // 得到状态栏的数组
    NSArray *children = [[[app valueForKey:@"statusBar"] valueForKeyPath:@"foregroundView"]subviews];
    NSString *stats = [[NSString alloc]init];
    
    // 标记类型
    int netType = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            // 得到到网络状态图标
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    stats= @"无网络";
                    self.isReachable = NO;
                    self.isReachableWiFi = NO;
                    self.isReachableWLAN = NO;
                    break;
                case 1:
                    stats= @"2G";
                    self.isReachable = YES;
                    self.isReachableWiFi = NO;
                    self.isReachableWLAN = YES;
                    break;
                case 2:
                    stats= @"3G";
                    self.isReachable = YES;
                    self.isReachableWiFi = NO;
                    self.isReachableWLAN = YES;
                    break;
                case 3:
                    stats= @"4G";
                    self.isReachable = YES;
                    self.isReachableWiFi = NO;
                    self.isReachableWLAN = YES;
                    break;
                case 5:
                    stats= @"WiFi";
                    self.isReachable = YES;
                    self.isReachableWiFi = YES;
                    self.isReachableWLAN = NO;
                    break;
                default:
                    break;
            }
        }
    }
    return stats;
    
}



- (void)isOpenReachability: (BOOL)isOpen{
    _isReachability = isOpen;
}


@end
