//
//  SULoader.h
//  SULoader
//
//  Created by 万众科技 on 16/6/24.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SURequestTask.h"

#define MimeType @"video/mp4"

@class SUResourceLoader;
@protocol SULoaderDelegate <NSObject>

@required
- (void)loader:(SUResourceLoader *)loader cacheProgress:(CGFloat)progress;

@optional
- (void)loader:(SUResourceLoader *)loader failLoadingWithError:(NSError *)error;

@end

@interface SUResourceLoader : NSObject<AVAssetResourceLoaderDelegate,SURequestTaskDelegate>

@property (nonatomic, weak) id<SULoaderDelegate> delegate;
@property (atomic, assign) BOOL seekRequired; //Seek标识
@property (nonatomic, assign) BOOL cacheFinished;

- (void)stopLoading;

@end

