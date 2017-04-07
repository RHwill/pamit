//
//  BgDownloadViewController.m
//  NSURLSession
//
//  Created by Lips蔡 on 2016/10/27.
//  Copyright © 2016年 PA. All rights reserved.
//

#import "BgDownloadViewController.h"
#import "AppDelegate.h"

@interface BgDownloadViewController ()<NSURLSessionDownloadDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLSession * session;
@property (nonatomic, strong) NSURLSessionDownloadTask * download;
@end

@implementation BgDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downloadInBackground];
    
    // Do any additional setup after loading the view.
}

- (void)downloadInBackground {
    if (_download) {
        return;
    }
    NSString * url = @"http://test1-puhui-web.pingan.com.cn:10180/manager/stg/pamit/updateH5/190/0000-60100040_91.zip";
    _session = [self backgroundSession];
    // 4.下载任务的创建
    _download = [_session downloadTaskWithURL:[NSURL URLWithString:url]];
    [_download resume];
}

#pragma mark - NSURLSessionDownloadDelegate
//下载任务完成,这个方法在下载完成时触发，它包含了已经完成下载任务得 Session Task,Download Task和一个指向临时下载文件得文件路径
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSURL *documentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *destinationURL = [documentsDirectory URLByAppendingPathComponent:[[[downloadTask originalRequest] URL] lastPathComponent]];
    [[NSFileManager defaultManager] removeItemAtURL:destinationURL error:nil];
    NSError * fileError;
    BOOL success = [[NSFileManager defaultManager] copyItemAtURL:location toURL:destinationURL error:&fileError];
    if (!success) {
        // 失败
         NSLog(@"%@",fileError);
    }else {
        // 成功
    }
}

//这个方法用来跟踪下载数据并且根据进度刷新ProgressView
/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
    
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error == nil) {
        NSLog(@"任务: %@ 成功完成", task);
    } else {
        NSLog(@"任务: %@ 发生错误: %@", task, [error localizedDescription]);
    }
    _download = nil;
}

#pragma mark - NSURLSessionDelegate
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.backgroundSessionCompletionHandler) {
        void (^completionHandler)() = appDelegate.backgroundSessionCompletionHandler;
        appDelegate.backgroundSessionCompletionHandler = nil;
        completionHandler();
    }
    NSLog(@"所有任务已完成!");
}

- (NSURLSession *)backgroundSession {
    static NSURLSession * session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"testBgDownload"];
        session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    });
    return session;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
