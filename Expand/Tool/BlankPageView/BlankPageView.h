//
//  BlankPageView.h
//  SunshineExampleDemo
//
//  Created by hui on 16/8/24.
//  Copyright © 2016年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,BlankPageType){
    BlankPageViewType = 0,
    BlankPageViewTypeProject,
    BlankPageViewTypeNoButton,
    BlankPageViewTypeMaterialScheduling
};
@interface BlankPageView : UIView



@property (nonatomic,strong)UIImageView *imgView;//背景图片
@property (nonatomic,strong)UILabel *blankLabel;//文字显示
@property (nonatomic,strong)UIButton *reloadBtn;//重新加载btn

@property (nonatomic,copy)void (^reloadBtnBlock)(id sender);//事件block


- (void)configWithType:(BlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;//初始化view


@end
