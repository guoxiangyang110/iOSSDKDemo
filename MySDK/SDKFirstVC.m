//
//  SDKFirstVC.m
//  MySDK
//
//  Created by 郭向阳 on 2017/6/15.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import "SDKFirstVC.h"
#import "SDKSecondVC.h"

@interface SDKFirstVC ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation SDKFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s",__func__);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    
    [self.button addTarget:self action:@selector(clickBt:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews{
    if (_button) {
        [_button setFrame:CGRectMake(100, 100, 100, 50)];
    }
}

#pragma mark - Actin
- (void)clickBt:(id)sender{
    NSLog(@"%s",__func__);
    
    SDKSecondVC *targetVC = [[SDKSecondVC alloc]init];
    
    [self presentViewController:targetVC animated:YES completion:nil];
}

#pragma mark - Getter
- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor greenColor];
        [_button setTitle:@"next" forState:UIControlStateNormal];
    }
    
    return _button;
}

@end
