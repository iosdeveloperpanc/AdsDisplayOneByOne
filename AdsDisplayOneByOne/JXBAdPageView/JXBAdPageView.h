
// 使用说明：

// 本地图片加载
/*
 1. 如果不需要自动滚动，就将timerInterval传0或0以下的数字
 2. 如果不是网络加载，就将UrlLoadingBlock传nil即可
 3. 点击广告页的相应方法用的是block,实现blockTapAds的回调即可
 */

// 网络图片加载
/*
 1. 如果不需要自动滚动，就将timerInterval传0或0以下的数字
 2. 如果是网络加载，实现UrlLoadingBlock的回调
 3. 点击广告页的相应方法用的是block,实现blockTapAds的回调即可
 */

// 如何使用？想怎么用就怎么用！
/* 
 1. #import "JXBAdPageView.h"
 
 2. 不管是Xib加载JXBAdPageView，还是纯代码创建JXBAdPageView，均支持！
    2.1 如果是Xib加载，去实现成员变量初始化即可
        self.blockUrlLoading = blockUrlLoading;
        self.dataArray = dataArray;
        self.displayTime = displayTime;
        以及颜色设置 参照步骤4
    2.2 如果是代码创建，建议调用类方法、对象方法，一句代码完成创建及初始化过程。
 
 3. 什么？你非要[[JXBAdPageView alloc] init] 或者 [[JXBAdPageView alloc] initWithFrame:]???
    那也没关系，创建之后去实现成员变量初始化即可，参照步骤2.1。（其实实际项目中，就是这样子去写的，先创建，获取到网络数据的时候进行赋值！）
 
 4. pageControl颜色设置
    - (void)setPageControlCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor; // 调用该方法
    也可以 单独设置
    pageView.currentPageIndicatorTintColor = [UIColor redColor];
    pageView.pageIndicatorTintColor = [UIColor blackColor];
 
    // 若不设置，就默认当前色为黄色，其他page颜色为蓝色
 */

#import <UIKit/UIKit.h>

typedef void (^blockImageUrlLoading)(NSArray *imageViews, NSArray *imageUrlStrings);

@interface JXBAdPageView : UIView

@property (nonatomic, strong) NSArray        *dataArray;
@property (nonatomic, assign) NSTimeInterval displayTime;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

@property (nonatomic, copy) void (^blockTapAds)(JXBAdPageView *, NSInteger); // 点击图片的block
@property (nonatomic, copy) blockImageUrlLoading blockUrlLoading; // url网络加载图片block

- (instancetype)initWithAdsImages:(NSArray*)dataArray timerInterval:(NSTimeInterval)displayTime urlLoadingBlock:(blockImageUrlLoading)blockUrlLoading;
+ (instancetype)pageViewWithAdsImages:(NSArray*)dataArray timerInterval:(NSTimeInterval)displayTime urlLoadingBlock:(blockImageUrlLoading)blockUrlLoading;

// set pageControl colors
- (void)setPageControlCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor;

@end
