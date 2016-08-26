//
//  UIView+BlankPageView.m
//  SunshineExampleDemo
//
//  Created by hui on 16/8/24.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "UIView+BlankPageView.h"
#import <objc/runtime.h>

static char BlankPageViewKey;


@implementation UIView (BlankPageView)


-(void)setBlankPageview:(BlankPageView *)blankPageview
{

    [self willChangeValueForKey:@"BlankPageViewKey"];
    
    
    objc_setAssociatedObject(self, &BlankPageViewKey, blankPageview, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
    

}

-(BlankPageView *)blankPageview
{
    return objc_getAssociatedObject(self, &BlankPageViewKey);

}

-(void)configBlankPage:(BlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block
{
    if (hasData) {
        //有数据if
        if (self.blankPageview) {
            self.blankPageview.hidden = YES;
            [self.blankPageview removeFromSuperview];
        }
    } else {
        if (!self.blankPageview) {
            self.blankPageview = [[BlankPageView alloc]initWithFrame:self.bounds];
        }
        self.blankPageview.hidden = NO;
        [self.blankPageContainer addSubview:self.blankPageview];

        [self.blankPageview configWithType:blankPageType hasData:hasData hasError:hasError reloadButtonBlock:block];
    }
}
//tableview;
- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}
@end
