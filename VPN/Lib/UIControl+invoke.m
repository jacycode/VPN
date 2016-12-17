//
//  UIControl+invoke.m
//  VPN
//
//  Created by 刘清 on 2016/12/17.
//  Copyright © 2016年 刘清. All rights reserved.
//

#import "UIControl+invoke.h"
#import <objc/runtime.h>

static const void * target_key;

@interface _Target : NSObject

//回调block
@property (nonatomic, copy) Callback callback;
//回调事件类型
@property (nonatomic, assign) UIControlEvents events;

- (instancetype)initWithCallback:(Callback)callback events:(UIControlEvents)events;
- (void)invoke:(id)sender;

@end
@implementation _Target

- (instancetype)initWithCallback:(Callback)callback events:(UIControlEvents)events
{
    if (self = [super init]) {
        self.callback = callback;
        self.events = events;
    }
    return self;
}
- (void)invoke:(id)sender
{
    if (self.callback) self.callback(sender);
}

@end

@implementation UIControl (invoke)

- (void)addEvents:(UIControlEvents)events Callback:(Callback)callback
{
    _Target *target = [[_Target alloc] initWithCallback:callback events:events];
    [self addTarget:target action:@selector(invoke:) forControlEvents:events];
    NSMutableArray *targets = [self gTarget];
    [targets addObject:target];
}
- (void)removeCallbackForEvents:(UIControlEvents)events
{
    NSMutableArray *targets = [self gTarget];
    [targets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        _Target *target = (_Target *)obj;
        if (target.events == events) {
            [self removeTarget:target action:@selector(invoke:) forControlEvents:events];
            [targets removeObject:target];
        }
    }];
}
- (NSMutableArray *)gTarget
{
    NSMutableArray *targets = objc_getAssociatedObject(self, target_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, target_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
