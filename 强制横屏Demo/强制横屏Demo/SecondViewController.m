//
//  SecondViewController.m
//  强制横屏Demo
//
//  Created by Lips蔡 on 16/5/24.
//  Copyright © 2016年 PA. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@property (nonatomic, strong) UIButton * backButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _backButton  = [UIButton buttonWithType:UIButtonTypeSystem];
    _backButton.frame = CGRectMake(200, 200, 40, 40);
    [_backButton setTitle:@"back" forState:UIControlStateNormal];
    [self.view addSubview:_backButton];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    ThirdViewController * thirdVC = [[ThirdViewController alloc] init];
//    thirdVC.backButton  = [UIButton buttonWithType:UIButtonTypeSystem];
//    thirdVC.backButton.frame = CGRectMake(200, 200, 40, 40);
//    [thirdVC.backButton setTitle:@"back" forState:UIControlStateNormal];
//    [thirdVC.view addSubview:thirdVC.backButton];
//    [thirdVC.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self presentViewController:thirdVC animated:YES completion:^{
//        
//    }];
}

- (BOOL)shouldAutorotate {
    return NO;
}

// 强制转向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)back {
    [self dismissViewControllerAnimated:NO completion:^{}];
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
