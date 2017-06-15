//
//  SecondVC.m
//  MySDK
//
//  Created by 郭向阳 on 2017/6/15.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 100, 50)];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"last" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(clickBt) forControlEvents:UIControlEventTouchUpInside];
}

- (void) clickBt{
    NSLog(@"%s",__func__);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
