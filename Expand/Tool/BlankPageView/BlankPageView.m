//
//  BlankPageView.m
//  SunshineExampleDemo
//
//  Created by hui on 16/8/24.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "BlankPageView.h"
#import "Masonry.h"
#import "UIView+Frame.h"
@implementation BlankPageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)configWithType:(BlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block
{
    //当获取到数据  移除当前view
    if (hasData) {
        [self removeFromSuperview];
        return;
    }//if data is no
    self.alpha = 1.0;
    //图片显示
    if (!self.imgView) {
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.centerX - 30, self.centerY -60, 60, 60)];
        [self addSubview:self.imgView];
    }
    //    文字
    if (!self.blankLabel) {
        self.blankLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.centerX - 100, self.imgView.bottom + 10, 200, 40)];
        self.blankLabel.numberOfLines = 0;
        self.blankLabel.font = [UIFont systemFontOfSize:15];
        self.blankLabel.textColor = [UIColor lightGrayColor];
        self.blankLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.blankLabel];
    }

    
    self.reloadBtnBlock = nil;//block
    if (!self.reloadBtn) {
        self.reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.reloadBtn setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
        self.reloadBtn.frame = CGRectMake(self.centerX - 50, self.blankLabel.bottom+5, 100, 40);
        self.reloadBtn.adjustsImageWhenHighlighted = YES;
        [self.reloadBtn addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.reloadBtn];
    }
    self.reloadBtn.hidden = NO;
    self.reloadBtnBlock = block;
    
    if (hasError) {
        [self.imgView setImage:[UIImage imageNamed:@"blankpage_image_loadFail"]];
        self.blankLabel.text = @"貌似出了点差错";

    }
    if (blankPageType == BlankPageViewTypeMaterialScheduling) {
        self.reloadBtn.hidden = YES;
    } else {
        if (self.reloadBtn) {
            self.reloadBtn.hidden = NO;
        }
        NSString *imageName,*blankTitle;
        
        switch (blankPageType) {
            case BlankPageViewTypeProject:
            {
                imageName = @"blankpage_image_Sleep";
                blankTitle = @"当前还未有数据";

            }
                break;
            case BlankPageViewTypeNoButton: {
                imageName = @"blankpage_image_Sleep";
                blankTitle = @"当前还未有数据";
                if (self.reloadBtn) {
                    self.reloadBtn.hidden = YES;
                }
            }
                break;
            default:{
                imageName = @"blankpage_image_Sleep";
                blankTitle = @"当前还未有数据";
            }
                break;
        }
        [self.imgView setImage:[UIImage imageNamed:imageName]];
        self.blankLabel.text =blankTitle;
        
    }
    
}
- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.reloadBtn) {
            self.reloadBtnBlock(sender);
        }
    });
}

@end
