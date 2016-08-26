//
//  AdvertiseView.h
//  SunshineExampleDemo
//
//  Created by hui on 16/8/24.
//  Copyright © 2016年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAdUserDefaults [NSUserDefaults standardUserDefaults]

static NSString *const adImageName = @"adImageName";

@interface AdvertiseView : UIView


- (void)showAdvertise;//展示广告

@property (nonatomic,copy)NSString *imagePath;//图片路径

@end
