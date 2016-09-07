//
//  ViewController.m
//  App加载广告
//
//  Created by Tb on 16/9/7.
//  Copyright © 2016年 Tb. All rights reserved.
//

#import "ViewController.h"
#import "TbAdvertiseView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TbAdvertiseView *advert = [[TbAdvertiseView alloc] init];
     advert.adverseImageViewUrl = @"mine_icon_nearby";
    advert.frame = self.view.bounds;
    [self.view addSubview:advert];
    [advert show];
                               //advert.frame = self.view.bounds
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
}

@end
