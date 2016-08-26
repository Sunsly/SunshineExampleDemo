//
//  AdvertiseView.m
//  SunshineExampleDemo
//
//  Created by hui on 16/8/24.
//  Copyright © 2016年 hui. All rights reserved.
//

#import "AdvertiseView.h"

@interface AdvertiseView ()

@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UIImageView *imgView;

@property (nonatomic, strong) UIButton *countBtn;
@property (nonatomic, assign) int count;


@end

static int showTime = 3;

@implementation AdvertiseView


-(NSTimer *)timer
{
    if (!_timer) {
        _timer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _timer;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 1.广告图片
        _imgView = [[UIImageView alloc] initWithFrame:frame];
        _imgView.userInteractionEnabled = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
        [_imgView addGestureRecognizer:tap];

        // 2.跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width - btnW - 24, btnH, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", showTime] forState:UIControlStateNormal];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        
        _countBtn.layer.cornerRadius = 4;
        
        [self addSubview:_imgView];
        [self addSubview:_countBtn];

        
    }
    return self;
}



- (void)countDown
{
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self dismiss];
    }
}



-(void)setImagePath:(NSString *)imagePath
{
    _imagePath = imagePath;
    _imgView.image = [UIImage imageWithContentsOfFile:imagePath];
}
- (void)pushToAd{
    
    [self dismiss];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AdvertisePush" object:nil userInfo:nil];
    
}
- (void)showAdvertise
{
    // 倒计时方法1：GCD
    //    [self startCoundown];
    
    // 倒计时方法2：定时器
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

// 定时器倒计时
- (void)startTimer
{
    _count = showTime;
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// GCD倒计时
- (void)startCoundown
{
    __block int timeout = showTime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timers = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timers,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timers, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timers);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismiss];
                
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timers);
}


- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];

    

}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
