//
//  ViewController.m
//  ZCreachabilityDemo
//
//  Created by lizhihui on 16/4/20.
//  Copyright © 2016年 lizhihui. All rights reserved.
//

#import "ViewController.h"
#import "NetworkTool.h"
#import "CommonToolsDefine.h"


@interface ViewController ()
{
    UIView * _topTipsView;// 提示View
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加网络监测的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netWorkChanged:) name:@"网络监测" object:nil];
    
    NSLog(@"%@",[[NetworkTool shareNetworkTool] currentNetworkStatsString]);
    
    [[NetworkTool shareNetworkTool] isOpenReachability:YES];
    
}



// 网络发生变化的时候UI提醒
- (void)netWorkChanged:(NSNotification*)notification{
    BOOL isHide=[NetworkTool shareNetworkTool].isReachable;
    [self showTopTipsView:@"   当前网络不可用，请检查您的网络设置" isShow:!isHide network:YES];
    NSLog(@"网络有变化");
    
    
}

// UI展示部分
-(void)showTopTipsView:(NSString *)text isShow:(BOOL)isShow network:(BOOL)isNetWork{
    CGFloat tipHeight=45.0f;
    if(isShow){
        if(_topTipsView==nil){
            _topTipsView=[[UIView alloc] initWithFrame:CGRectMake(0, NavBarHeight, ScreenWidth, tipHeight)];
            [_topTipsView setBackgroundColor:UIColorFromRGBAlpha(BgRedColor,0.2)];
            [_topTipsView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [self.view addSubview:_topTipsView];
        }else{
            _topTipsView.hidden = NO;
            for (UIView *v in _topTipsView.subviews) {
                [v removeFromSuperview];
            }
        }
        
        UILabel *textLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, tipHeight)];
        [textLabel setText:text];
        [textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [textLabel setTextColor:[UIColor blackColor]];
        [textLabel setFont:[UIFont systemFontOfSize:14]];
        [textLabel setTextAlignment:NSTextAlignmentCenter];
        [_topTipsView addSubview:textLabel];
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 40, tipHeight)];
        [iv setImage:[UIImage imageNamed:@"icon_warning_nonet"]];
        [iv setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
        [iv setContentMode:UIViewContentModeCenter];
        [_topTipsView addSubview:iv];
        if(isNetWork){
            [iv setHidden:NO];
        }else{
            [iv setHidden:YES];
        }
        
    }else{
        if(_topTipsView){
            _topTipsView.hidden=YES;
            
            for (UIView *v in _topTipsView.subviews) {
                // 从父视图上移除
                [v removeFromSuperview];
            }
        }
    }
}






@end
