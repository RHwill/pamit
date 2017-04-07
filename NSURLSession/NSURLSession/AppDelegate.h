//
//  AppDelegate.h
//  NSURLSession
//
//  Created by Lips蔡 on 16/6/15.
//  Copyright © 2016年 PA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy) void (^backgroundSessionCompletionHandler)();

@end

