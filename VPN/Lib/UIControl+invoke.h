//
//  UIControl+invoke.h
//  VPN
//
//  Created by 刘清 on 2016/12/17.
//  Copyright © 2016年 刘清. All rights reserved.
//

#import <UIKit/UIKit.h>

//事件回调类型
typedef void(^Callback)(id sender);

@interface UIControl (invoke)

//添加响应回调
- (void)addEvents:(UIControlEvents)events Callback:(Callback)callback;
//移除响应回调
- (void)removeCallbackForEvents:(UIControlEvents)events;

@end
