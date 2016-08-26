//
//  UIView+BlankPageView.h
//  SunshineExampleDemo
//
//  Created by hui on 16/8/24.
//  Copyright © 2016年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlankPageView.h"
@interface UIView (BlankPageView)

@property (nonatomic,strong)BlankPageView *blankPageview;

- (void)configBlankPage:(BlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;


@end
