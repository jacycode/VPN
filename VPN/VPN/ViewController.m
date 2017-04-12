//
//  ViewController.m
//  VPN
//
//  Created by 刘清 on 2016/12/16.
//  Copyright © 2016年 刘清. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+invoke.h"
#import <NetworkExtension/NetworkExtension.h>

#define M_WIDTH [UIScreen mainScreen].bounds.size.width
#define M_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) UIButton *startBt;
@property (nonatomic, strong) NEVPNManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.startBt];
    
    self.manager = [NEVPNManager sharedManager];
    
    [self.manager loadFromPreferencesWithCompletionHandler:^(NSError *error) {
        if(error) {
            NSLog(@"加载配置失败: %@", error);
        } else {
            
            Class NEVPNProtocolL2TP = NSClassFromString(@"NEVPNProtocolL2TP");
            
            NEVPNProtocol *p = [[NEVPNProtocolL2TP alloc] init];
            
            [p performSelector:@selector(setSharedSecretReference:) withObject:[@"vpn" dataUsingEncoding:NSUTF8StringEncoding]];
            p.username = @"vpn";
            p.passwordReference = [@"vpn" dataUsingEncoding:NSUTF8StringEncoding];
            [p performSelector:@selector(setLocalIdentifier:) withObject:@"localidentifier"];
            p.serverAddress = @"";
            p.disconnectOnSleep = NO;
            
            NSLog(@"加载配置成功");
            
        }
    }];
    
}

//getter
- (UIButton *)startBt
{
    if (!_startBt) {
        _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBt.bounds = CGRectMake(0, 0, 80, 80);
        _startBt.center = CGPointMake(M_WIDTH / 2, M_HEIGHT / 2);
        _startBt.layer.borderColor = [UIColor brownColor].CGColor;
        _startBt.layer.borderWidth = 2;
        _startBt.layer.cornerRadius = 40;
        _startBt.backgroundColor = [UIColor lightGrayColor];
        [_startBt setTitle:@"连接" forState:UIControlStateNormal];
        
        __weak ViewController *weakSelf = self;
        [_startBt addEvents:UIControlEventTouchUpInside Callback:^(id sender) {
            
            NSBundle *b = [NSBundle bundleWithPath:@"/System/Library/Frameworks/NetworkExtension.framework"];
            
            if ([b load]) {
                
                [weakSelf.manager saveToPreferencesWithCompletionHandler:^(NSError *error) {
                    if(error) {
                        NSLog(@"保存配置失败: %@", error);
                    }
                    else {
                        NSLog(@"保存配置成功!");
                    }
                }];
                

            } else {
                NSLog(@"未检测到L2TP协议API");
            }
        }];
    }
    return _startBt;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
