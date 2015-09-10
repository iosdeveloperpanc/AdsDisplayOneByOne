//
//  URLLoadingViewController.m
//  循环滚动改进版
//
//  Created by Pan on 15/9/10.
//  Copyright (c) 2015年 lanyao. All rights reserved.
//

#import "URLLoadingViewController.h"

#import "JXBAdPageView.h"

// 本示例采用SDWebImage去加载网络图片
#import "UIImageView+WebCache.h"

@interface URLLoadingViewController ()

@end

@implementation URLLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *dataArray = @[@"https://ss0.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=285876434,2848538093&fm=21&gp=0.jpg",
                           @"https://ss0.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1135553526,1006070139&fm=21&gp=0.jpg",
                           @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2746806795,707720731&fm=21&gp=0.jpg",
                           @"https://ss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=8c4956f7327adab422d01c43bbd5b36b/bf096b63f6246b60786357abeff81a4c500fa284.jpg",
                           @"https://ss0.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3759234285,693410336&fm=21&gp=0.jpg",
                           @"https://ss0.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1262102604,326317574&fm=21&gp=0.jpg",
                           @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3992155232,292560584&fm=21&gp=0.jpg"
                           ];

    // 对象方法调用
    /*
    JXBAdPageView *pageView = [[JXBAdPageView alloc] initWithAdsImages:dataArray timerInterval:2.0 urlLoadingBlock:^(NSArray *imageViews, NSArray *imageUrlStrings) {
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = (UIImageView *)imageViews[i];
            NSURL *imageUrl = [NSURL URLWithString:imageUrlStrings[i]];
            [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"img_01"]];
        }
    }];
     */

    // 类方法调用
    JXBAdPageView *pageView = [JXBAdPageView pageViewWithAdsImages:dataArray timerInterval:2.0 urlLoadingBlock:^(NSArray *imageViews, NSArray *imageUrlStrings) {
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = (UIImageView *)imageViews[i];
            NSURL *imageUrl = [NSURL URLWithString:imageUrlStrings[i]];
            [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"img_01"]];
        }
    }];
    
    [pageView setFrame:self.view.bounds];
    
    [self.view addSubview:pageView];
    
    pageView.blockTapAds = ^(JXBAdPageView *pageView, NSInteger index){
        
        NSLog(@"当前点击的广告页Index = %ld", index);
        
    };
}

@end
