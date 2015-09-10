//
//  LocalLoadingViewController.m
//  循环滚动改进版
//
//  Created by Pan on 15/9/10.
//  Copyright (c) 2015年 lanyao. All rights reserved.
//

#import "LocalLoadingViewController.h"
#import "JXBAdPageView.h"

@interface LocalLoadingViewController ()

@end

@implementation LocalLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 本地图片加载
    NSArray *dataArray = @[@"img_01", @"img_02", @"img_03", @"img_04", @"img_05"];
    
    // 类方法调用
    //    JXBAdPageView *pageView = [JXBAdPageView pageViewWithAdsImages:dataArray timerInterval:0 urlLoadingBlock:nil];
    
    // 对象方法调用
    JXBAdPageView *pageView = [[JXBAdPageView alloc] initWithAdsImages:dataArray timerInterval:0 urlLoadingBlock:nil];
    
    [pageView setFrame:self.view.bounds];
    
    /*
    pageView.currentPageIndicatorTintColor = [UIColor redColor];
    pageView.pageIndicatorTintColor = [UIColor blackColor];
    */
    
    [pageView setPageControlCurrentPageIndicatorTintColor:[UIColor redColor] pageIndicatorTintColor:[UIColor blackColor]];
    
    [self.view addSubview:pageView];
    
    pageView.blockTapAds = ^(JXBAdPageView *pageView, NSInteger index){
        
        NSLog(@"当前点击的广告页Index = %ld", index);
        
    };
}


@end
