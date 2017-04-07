//
//  ViewController.m
//  强制横屏Demo
//
//  Created by Lips蔡 on 16/5/24.
//  Copyright © 2016年 PA. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     强制横屏 适用在所有app是竖屏app只有某个页面是横屏的项目中 
     如果有 UINavigationController 在 UINavigationController 中实现下面两个方法
     
     - (BOOL)shouldAutorotate {
     return NO;
     }
     
     // 强制转向
     - (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
     return UIInterfaceOrientationLandscapeLeft;
     }
     */
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 40, 100);
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)test {
    [self presentViewController:[[SecondViewController alloc] init] animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
