//
//  GHNetWorkingManager.h
//  SunshineExampleDemo
//
//  Created by hui on 16/8/21.
//  Copyright © 2016年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTimeOutInterval  15.0f   //网络请求超时的时间

typedef void (^GHDownloadProgressBlock)(NSProgress *downLoadProgress);

typedef void (^GHSuccessBlock)(id responseObject);

typedef void (^GHFailureBlock)(NSError *error);


@interface GHNetWorkingManager : NSObject


+ (GHNetWorkingManager *)shareSessionManager;//网络请求

/**
 *  post请求
 *
 *  @param urlString     url
 *  @param parameters    参数
 *  @param netIdentifier 请求标识
 *  @param successBlock  请求成功
 *  @param failureBlock  请求失败
 */
- (void)postUrl:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(GHSuccessBlock )successBlock failure:(GHFailureBlock )failureBlock;



@end
