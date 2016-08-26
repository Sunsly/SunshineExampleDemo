//
//  AdvertiseHelper.m
//  SunshineExampleDemo
//
//  Created by hui on 16/8/24.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "AdvertiseHelper.h"

@implementation AdvertiseHelper

+ (AdvertiseHelper *)shareInstance
{
    static AdvertiseHelper *helper = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        helper = [[AdvertiseHelper alloc]init];
    });
    
    return helper;
}

+(void)showAdvertiserView:(NSArray *)imageArray
{
   // NSString *filePath  = [AdvertiseHelper shareInstance]getFilePathWithImageName:[kAdUserDefaults valueForKey:adImageName];
    
    

}

- (NSString *)getFilePathWithImageName:(NSString *)imageName
{

    if (imageName) {
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        return filePath;
    }
    return nil;
    
}

@end
