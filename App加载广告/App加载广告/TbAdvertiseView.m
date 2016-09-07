

//
//  TbAdvertiseView.m
//  App加载广告
//
//  Created by Tb on 16/9/7.
//  Copyright © 2016年 Tb. All rights reserved.
//

#define XMGScreenW [UIScreen mainScreen].bounds.size.width
#define XMGScreenH [UIScreen mainScreen].bounds.size.height

#import "TbAdvertiseView.h"
#import "UIView+XMGExtension.h"
@interface TbAdvertiseView()
@property (nonatomic,strong)UIButton *showTimeButton;
/**定时器*/
@property (nonatomic, strong) NSTimer *countTimer;

@end
// 广告显示的时间
@implementation TbAdvertiseView

static int  totalAdterTime = 5;

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}
- (void)setAdverseImageViewUrl:(NSString *)adverseImageViewUrl
{
    _adverseImageViewUrl = [adverseImageViewUrl copy];
}
- (UIImageView *)advetiseImageView
{
    if (!_advetiseImageView) {
        _advetiseImageView = [[UIImageView alloc] init];
        [_advetiseImageView setImage:[UIImage imageNamed:@"mine_icon_nearby"]];
        _advetiseImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PushTo)];
        [_advetiseImageView addGestureRecognizer:tapGesture];
    }
    return _advetiseImageView;
}

- (UIButton *)showTimeButton
{
    if (!_showTimeButton) {
        _showTimeButton = [[UIButton alloc]init] ;
        [_showTimeButton setTitle:[NSString stringWithFormat:@"剩余%zd秒",totalAdterTime] forState:
         UIControlStateNormal];
        [_showTimeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _showTimeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_showTimeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _showTimeButton.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _showTimeButton.layer.cornerRadius = 4;
        
        CGFloat buttonW = 60;
        CGFloat buttonH = 30;
        _showTimeButton.x = XMGScreenW - buttonW - 24;
        _showTimeButton.y = buttonH;
        _showTimeButton.width = buttonW;
        _showTimeButton.height = buttonH;

    }
    return _showTimeButton;
}
- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加广告图片
      [self addSubview:self.advetiseImageView];
        // 跳过按钮
        [self addSubview:self.showTimeButton];
        

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.advetiseImageView.frame = self.bounds;
}

- (void)show
{
    [self createTimer];
}

- (void)countDown
{
    totalAdterTime --;
    [self.showTimeButton setTitle:[NSString stringWithFormat:@"剩余%d秒",totalAdterTime] forState:UIControlStateNormal];
    if (totalAdterTime == 1) {
        [self dismiss];
    }
}

- (void)createTimer
{
    [[NSRunLoop currentRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

- (void)PushTo
{
    NSLog(@"pushTo");
}
@end
