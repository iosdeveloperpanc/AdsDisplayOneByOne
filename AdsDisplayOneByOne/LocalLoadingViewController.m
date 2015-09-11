//
//  TapResultViewController.h
//  AdsDisplayOneByOne
//
//  Created by Pan on 15/9/11.
//  Copyright (c) 2015年 lanyao. All rights reserved.
//

#import "LocalLoadingViewController.h"
#import "JXBAdPageView.h"

#import "TapResultViewController.h"

@interface LocalLoadingViewController ()

@property (nonatomic, strong) JXBAdPageView *pageView;

@end

@implementation LocalLoadingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.pageView startTimer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.pageView stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 本地图片加载
    NSArray *dataArray = @[@"img_01", @"img_02", @"img_03", @"img_04", @"img_05"];
    
    // 类方法调用
    //    JXBAdPageView *pageView = [JXBAdPageView pageViewWithAdsImages:dataArray timerInterval:0 urlLoadingBlock:nil];
    
    // 对象方法调用
    JXBAdPageView *pageView = [[JXBAdPageView alloc] initWithAdsImages:dataArray timerInterval:0 urlLoadingBlock:nil];
    
    /*
     pageView.currentPageIndicatorTintColor = [UIColor redColor];
     pageView.pageIndicatorTintColor = [UIColor blackColor];
     */
    
    [pageView setPageControlCurrentPageIndicatorTintColor:[UIColor redColor] pageIndicatorTintColor:[UIColor blackColor]];
    self.pageView = pageView;
    
    [self.view addSubview:pageView];
    
    pageView.blockTapAds = ^(JXBAdPageView *pageView, NSInteger index){
        
        NSLog(@"当前点击的广告页Index = %ld", index);
        NSString *result = [NSString stringWithFormat:@"当前点击的广告页Index = %ld", index];
        [self performSegueWithIdentifier:@"localPush" sender:result];
    };
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.pageView setFrame:self.view.bounds];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSString *)sender
{
    if ([segue.identifier isEqualToString:@"localPush"]) {
        TapResultViewController *resultVc = (TapResultViewController *)segue.destinationViewController;
        resultVc.result = sender;
    }
}

@end
