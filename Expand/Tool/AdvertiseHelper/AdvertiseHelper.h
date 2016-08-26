//
//  AdvertiseHelper.h
//  SunshineExampleDemo
//
//  Created by hui on 16/8/24.
//  Copyright © 2016年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertiseHelper : NSObject

+ (AdvertiseHelper *)shareInstance;//单例

+ (void)showAdvertiserView:(NSArray *)imageArray;

@end
