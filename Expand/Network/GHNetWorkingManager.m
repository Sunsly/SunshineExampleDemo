//
//  GHNetWorkingManager.m
//  SunshineExampleDemo
//
//  Created by hui on 16/8/21.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "GHNetWorkingManager.h"
#import "AFNetworking.h"



#define fUNC_NIL_BLOCK(block,blocks)  \
if (block) {              \
blocks;               \
}                         \

@interface GHNetWorkingManager ()

@property (nonatomic,strong)AFHTTPSessionManager *sessionMamager;
@end


@implementation GHNetWorkingManager


//初始化类
+(GHNetWorkingManager *)shareSessionManager
{
    static GHNetWorkingManager *manager = nil;
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (manager == nil) {
            manager = [[[self class]alloc]init];
        }
    });
    return manager;
}

-(instancetype)init
{

    if (self == [super init]) {
        self.sessionMamager = [[AFHTTPSessionManager alloc]init];
        
        AFHTTPRequestSerializer *requestSerializerNotCache = [AFHTTPRequestSerializer serializer];
        requestSerializerNotCache.timeoutInterval = kTimeOutInterval;
        
        self.sessionMamager.requestSerializer = [AFJSONRequestSerializer serializer];
        
    }
    return self;
}
-(void)postUrl:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(GHSuccessBlock)successBlock failure:(GHFailureBlock)failureBlock
{

    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:nil success:successBlock failure:failureBlock];
    
    if (sessionManager != nil) {
        return;
    }
    
    

    


}

- (AFHTTPSessionManager *)getManagerWithWithPath:(const NSString *)path
                                      parameters:(id)parameters
                                   netIdentifier:(NSString *)netIdentifier
                                        progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                         success:(void (^)(id responseObject))successBlock
                                         failure:(void (^)(NSError   *error))failureBlock {
    
    // 1.当前的请求是否正在进行
//    for (NSDictionary *dict in self.networkingManagerArray) {
//        NSString *key = [[dict allKeys] firstObject];
//        if ([key isEqualToString:netIdentifier]) {
//            NSLog(@"当前的请求正在进行,拦截请求");
//            if (failureBlock) {
//                NSError *cancelError = [NSError errorWithDomain:@"请求正在进行!" code:(-12001) userInfo:nil];
//                fUNC_NIL_BLOCK(failureBlock , failureBlock(cancelError));
//            }
//            return nil;
//        }
//    }
//    
    // 2.检测是否有网络
    AFNetworkReachabilityStatus net = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if ( net == AFNetworkReachabilityStatusNotReachable) {
        NSError *cancelError = [NSError errorWithDomain:@"没有网络,请检测网络!" code:(-12002) userInfo:nil];
        fUNC_NIL_BLOCK(failureBlock , failureBlock(cancelError));
        NSLog(@"没有网络");
        return nil;
    }
    return  self.sessionMamager;
}



@end
