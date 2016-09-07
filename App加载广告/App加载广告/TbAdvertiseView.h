//
//  TbAdvertiseView.h
//  App加载广告
//
//  Created by Tb on 16/9/7.
//  Copyright © 2016年 Tb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbAdvertiseView : UIView

@property (nonatomic,strong)UIImageView *advetiseImageView;
@property (nonatomic,copy)NSString *adverseImageViewUrl;

- (void)show;
@end
