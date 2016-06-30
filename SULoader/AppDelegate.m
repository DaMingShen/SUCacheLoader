//
//  AppDelegate.m
//  SULoader
//
//  Created by 万众科技 on 16/6/24.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 - (void)addRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
 //如果loader没有取消
 if(self.isCancelled==NO){
 //从指定位置开始请求数据操作
 [self startOperationFromOffset:loadingRequest.dataRequest.requestedOffset length:loadingRequest.dataRequest.requestedLength];
 //加入到数组中
 [self.pendingRequests addObject:loadingRequest];
 }
 //如果已取消
 else{
 //如果请求还没完成，则将其取消
 if(loadingRequest.isFinished==NO){
 [loadingRequest finishLoadingWithError:[self loaderCancelledError]];
 }
 }
 }
 
 - (void)removeRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
 //从数组中移除
 [self.pendingRequests removeObject:loadingRequest];
 }
 
 - (void)cancel{
 //取消标记设置为yes
 self.isCancelled = YES;
 //取消所有请求
 for(AVAssetResourceLoadingRequest *pendingRequest in self.pendingRequests){
 if(pendingRequest.isFinished==NO){
 [pendingRequest finishLoadingWithError:[self loaderCancelledError]];
 }
 }
 [self.pendingRequests removeAllObjects];
 //取消所有操作
 if(self.contentInfoOperation){
 [self.contentInfoOperation cancel];
 self.contentInfoOperation = nil;
 }
 if(self.dataOperation){
 [self.dataOperation cancel];
 self.dataOperation = nil;
 }
 //清除缓存
 if (self.writingFileHandle != nil){
 [self.writingFileHandle closeFile];
 self.writingFileHandle = nil;
 }
 if (self.readingFileHandle != nil){
 [self.readingFileHandle closeFile];
 self.readingFileHandle = nil;
 }
 if (self.cachedFilePath != nil && [[NSFileManager defaultManager] fileExistsAtPath:self.cachedFilePath]){
 [[NSFileManager defaultManager] removeItemAtPath:self.cachedFilePath error:nil];
 }
 }
 
 - (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
 //1、提取URL
 NSURL * resourceURL = loadingRequest.request.URL;
 //2、如果是自定义的scheme
 if ([resourceURL.scheme isEqualToString:CustomScheme]) {
 //3、找到其对应的Loader
 NSString * requestKey = resourceURL.absoluteString;
 SUResourceLoader * loader = [sResourceLoaders objectForKey:requestKey];
 //4、如果没有找到则新生成一个
 if (loader == nil) {
 loader = [[SUResourceLoader alloc]initWithResourceURL:resourceURL session:sSession];
 loader.delegate = self;
 [sResourceLoaders setObject:loader forKey:resourceURL.absoluteString];
 }
 //将请求加入到loader中
 [loader addRequest:loadingRequest];
 return YES;
 }
 return NO;
 }
 
 - (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
 //1、提取URL
 NSURL * resourceURL = loadingRequest.request.URL;
 //2、如果是自定义的scheme
 if ([resourceURL.scheme isEqualToString:CustomScheme]) {
 //3、找到其对应的Loader
 NSString * requestKey = resourceURL.absoluteString;
 SUResourceLoader * loader = [sResourceLoaders objectForKey:requestKey];
 //将请求从loader中移除
 [loader removeRequest:loadingRequest];
 }
 }
 */

@end
