//
//  ViewController.m
//  NSURLSession
//
//  Created by Lips蔡 on 16/6/15.
//  Copyright © 2016年 PA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSMutableData * data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // GET请求
    [self sessionDataGET];
    // POST请求
    [self sessionDataPOST];
    // 有代理的GET请求
    [self sessionDataGETDelegate];
    // 下载
    [self sessionDownload];
    // 有代理的下载
    [self sessionDownloadDelegate];
    // 上传GET
    [self sessionUploadGET];
    // 上传POST
}

- (void)sessonUploadPOST  {
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://test1-cfs-phone-web.pingan.com.cn/cfsssfront/common/uploadPicture.do?"]];
    NSURLSessionUploadTask * task = [[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:[NSData dataWithContentsOfFile:@""] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
}

- (void)sessionUploadGET {
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://test1-cfs-phone-web.pingan.com.cn/cfsssfront/common/uploadPicture.do?"]];
    NSURL * fileURL = [NSURL fileURLWithPath:@""];
    NSURLSessionUploadTask * task  = [[NSURLSession sharedSession] uploadTaskWithRequest:request fromFile:fileURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
}

- (void)sessionDownloadDelegate {
    NSURL * url = [NSURL URLWithString:@"http://172.16.2.254/php/phonelogin/image.png"];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:url];
    [task resume];
}

// 1.每次写入调用(会调用多次)
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
}

// 2.下载完成时调用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
}

// 3.请求成功/失败（如果成功，error为nil）
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
//     113 有这个方法啦
//}

- (void)sessionDownload {
    NSURL * url = [NSURL URLWithString:@"http://172.16.2.254/php/phonelogin/image.png"];
    NSURLSessionDownloadTask * task = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        /*
         a.location是沙盒中tmp文件夹下的一个临时url,文件下载后会存到这个位置,由于tmp中的文件随时可能被删除,所以我们需要自己需要把下载的文件移动到其他地方:pathUrl.
         b.response.suggestedFilename是从相应中取出文件在服务器上存储路径的最后部分，例如根据本路径为，最后部分应该为：“image.png”
         */
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:response.suggestedFilename];
        NSURL * url = [NSURL fileURLWithPath:path];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:url error:nil];
        
    }];
    [task resume];
}

- (void)sessionDataPOST {
    NSURL * url = [NSURL URLWithString:@"https://test1-puhui-web.pingan.com.cn:10143/manager/stg/pamit/upgrade/ios.json"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }];
    [task resume];
}

- (void)sessionDataGET {
    NSURL * url = [NSURL URLWithString:@"https://test1-puhui-web.pingan.com.cn:10143/manager/stg/pamit/upgrade/ios.json"];
    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }];
    [task resume];
}

- (void)sessionDataGETDelegate {
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURL * url = [NSURL URLWithString:@"https://test1-puhui-web.pingan.com.cn:10143/manager/stg/pamit/upgrade/ios.json"];
    NSURLSessionTask * task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:url]];
    [task resume];
}

#pragma mark - NSURLSessionDataDelegate
// 1.接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    //【注意：此处需要允许处理服务器的响应，才会继续加载服务器的数据。 若在接收响应时需要对返回的参数进行处理(如获取响应头信息等),那么这些处理应该放在这个允许操作的前面。】
    completionHandler(NSURLSessionResponseAllow);
}

// 2.接收到服务器的数据（此方法在接收数据过程会多次调用）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 处理每次接收的数据，例如每次拼接到自己创建的数据receiveData
    [self.data appendData:data];
}

// 3.请求成功/失败（如果成功，error为nil）
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    //  请求完成,成功或者失败的处理
    if (error == nil) {
        
    }else {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
