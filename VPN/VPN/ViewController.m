//
//  ViewController.m
//  VPN
//
//  Created by 刘清 on 2016/12/16.
//  Copyright © 2016年 刘清. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+invoke.h"

#define M_WIDTH [UIScreen mainScreen].bounds.size.width
#define M_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) UIButton *startBt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.startBt];
    
}

//getter
- (UIButton *)startBt
{
    if (!_startBt) {
        _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBt.bounds = CGRectMake(0, 0, 80, 80);
        _startBt.center = CGPointMake(M_WIDTH / 2, M_HEIGHT / 2);
        _startBt.layer.borderColor = [UIColor brownColor    ].CGColor;
        _startBt.layer.borderWidth = 2;
        _startBt.layer.cornerRadius = 40;
        _startBt.backgroundColor = [UIColor lightGrayColor];
        [_startBt setTitle:@"连接" forState:UIControlStateNormal];
        [_startBt addEvents:UIControlEventTouchUpInside Callback:^(id sender) {
            NSLog(@"***");
        }];
    }
    return _startBt;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
