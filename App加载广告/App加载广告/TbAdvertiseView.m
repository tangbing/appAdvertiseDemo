

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
#import <UIImageView+WebCache.h>

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
//- (void)setAdverseImageViewUrl:(NSString *)adverseImageViewUrl
//{
//    _adverseImageViewUrl = [adverseImageViewUrl copy];
//    NSLog(@"setAdverseImageViewUrl:%@",_adverseImageViewUrl);
//}

- (UIImageView *)advetiseImageView
{
    if (!_advetiseImageView) {
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

- (instancetype)initWithAdWidth:(CGRect)rect imageUrl:(NSString *)imageUrl adType:(TbAdvertiseType)adType
{
    self = [super init];
    if (self) {
        if (adType == TbAdvertiseTypeByPicture) {// 本地图片
            self.adverseImageViewUrl = imageUrl;
        } else {// 网络图片
            //利用SDWerbImage下载图片到沙盒，获取图片在沙盒的位置，付给图片
            
            self.adverseImageViewUrl = [self downloadImage:imageUrl];
            NSLog(@"----------------------------------------------%@",self.adverseImageViewUrl);
        }
        // 添加广告图片
        [self addSubview:self.advetiseImageView];
        // 跳过按钮
        [self addSubview:self.showTimeButton];
    }
    return self;
}
- (NSString *)downloadImage:(NSString *)url
{
   __block NSString *cacheImagePath = nil;
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image) {
            NSLog(@"%@,%@",image,imageURL);
            NSLog(@"cache:%@",[manager cacheKeyForURL:[NSURL URLWithString:url]]);
            BOOL isExit = [manager diskImageExistsForURL:imageURL];
            if (isExit) {
                NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:url]];
                if (cacheImageKey.length) {
                    cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
                    NSLog(@"cachePath:%@",cacheImagePath);
                }

            }
        }
    }];
    return cacheImagePath;
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
