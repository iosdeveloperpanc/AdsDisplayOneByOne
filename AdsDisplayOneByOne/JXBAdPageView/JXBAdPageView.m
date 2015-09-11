
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
 2.2 如果是代码创建，建议调用类方法、对象方法，一句代码完成创建及初始化过程。
 
 3. 什么？你非要[[JXBAdPageView alloc] init] 或者 [[JXBAdPageView alloc] initWithFrame:]???
 那也没关系，创建之后去实现成员变量初始化即可，参照2.1步骤。（其实实际项目中，就是这样子去写的，先创建，获取到网络数据的时候进行赋值！）
 
 4. pageControl颜色设置
 - (void)setPageControlCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor; // 调用该方法
 也可以 单独设置
 pageView.currentPageIndicatorTintColor = [UIColor redColor];
 pageView.pageIndicatorTintColor = [UIColor blackColor];
 
 // 若不设置，就默认当前色为黄色，其他page颜色为蓝色
 */


#import "JXBAdPageView.h"

@interface JXBAdPageView()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSInteger           currentIndex;
@property (nonatomic, strong) UIScrollView        *scrollView;
@property (nonatomic, strong) UIPageControl       *pageControl;
@property (nonatomic, strong) UIImageView         *imgPrev;
@property (nonatomic, strong) UIImageView         *imgCurrent;
@property (nonatomic, strong) UIImageView         *imgNext;
@property (nonatomic, strong) NSTimer             *timer;

@end

@implementation JXBAdPageView

+ (instancetype)pageViewWithAdsImages:(NSArray *)dataArray timerInterval:(NSTimeInterval)displayTime urlLoadingBlock:(blockImageUrlLoading)blockUrlLoading
{
    return [[self alloc] initWithAdsImages:dataArray timerInterval:displayTime urlLoadingBlock:blockUrlLoading];
}

- (instancetype)initWithAdsImages:(NSArray*)dataArray timerInterval:(NSTimeInterval)displayTime urlLoadingBlock:(blockImageUrlLoading)blockUrlLoading
{
    if (self = [super init]) {
        [self setupSubviews];
        
        self.dataArray = dataArray;
        self.displayTime = displayTime;
        self.blockUrlLoading = blockUrlLoading;

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];

    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;

        if (i == 0) {
            self.imgPrev = imageView;
        } else if (i == 1) {
            self.imgCurrent = imageView;
        } else {
            self.imgNext = imageView;
        }

        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    self.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    self.pageControl.hidesForSinglePage = YES;
    [self addSubview:self.pageControl];
    
    // tap手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAds)];
    [self.scrollView addGestureRecognizer:tap];
    
    // 长按手势
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAds:)];
    [self.scrollView addGestureRecognizer:press];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    
    CGFloat sizeWidth = self.dataArray.count <= 1 ? width : width * 3;
    self.scrollView.contentSize = CGSizeMake(sizeWidth, height);
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
    
    self.imgPrev.frame = CGRectMake(0, 0, width, height);
    self.imgCurrent.frame = CGRectMake(width, 0, width, height);
    self.imgNext.frame = CGRectMake(width * 2, 0, width, height);
    
    self.pageControl.center = CGPointMake(width/2, height - 20);
}

#pragma mark - 点击广告
- (void)tapAds
{
    [self stopTimer];
    
    if (self.blockTapAds) {
        self.blockTapAds(self, self.currentIndex);
    }
}

#pragma mark - 长按广告
- (void)longPressAds:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self stopTimer];
    }else if (gesture.state == UIGestureRecognizerStateEnded) {
        [self startTimer];
    }
}

#pragma mark - 加载图片
- (void)loadImages {
    
    if (self.currentIndex < 0)
    {
        self.currentIndex = self.dataArray.count - 1;
    } else if (self.currentIndex >= self.dataArray.count)
    {
        self.currentIndex = 0;
    }
    
    NSInteger prev = self.currentIndex - 1;
    prev = self.currentIndex - 1 < 0 ? self.dataArray.count - 1 : self.currentIndex - 1;
    
    NSInteger next = self.currentIndex + 1;
    next = next > self.dataArray.count - 1 ? 0 : self.currentIndex + 1;
   
    NSString *prevImage = [self.dataArray objectAtIndex:prev];
    NSString *curImage = [self.dataArray objectAtIndex:self.currentIndex];
    NSString *nextImage = [self.dataArray objectAtIndex:next];
    
    if(self.blockUrlLoading)
    {
        NSArray *imageViewArray = @[self.imgPrev, self.imgCurrent, self.imgNext];
        NSArray *imageUrlArray = @[prevImage, curImage, nextImage];
        self.blockUrlLoading(imageViewArray, imageUrlArray);
    } else {
        self.imgPrev.image = [UIImage imageNamed:prevImage];
        self.imgCurrent.image = [UIImage imageNamed:curImage];
        self.imgNext.image = [UIImage imageNamed:nextImage];
    }
    
    self.pageControl.currentPage = self.currentIndex;
    
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == self.scrollView.frame.size.width * 2)
        self.currentIndex++;
    else if (scrollView.contentOffset.x == 0)
        self.currentIndex--;

    [self loadImages];
}

#pragma mark - 轮播图片
- (void)nextPage {
    self.currentIndex++;
    [self loadImages];
}

#pragma mark - timer 懒加载
- (NSTimer *)timer
{
    if (_timer == nil) {
        if (self.displayTime > 0) {
            _timer = [NSTimer timerWithTimeInterval:self.displayTime target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        }
    }
    return _timer;
}

#pragma mark 开启计时器
- (void)startTimer
{
    if (self.timer) {
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark 关闭计时器
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark -
#pragma mark 重写displayTime的Setter
- (void)setDisplayTime:(NSTimeInterval)displayTime
{
    _displayTime = displayTime;
    
    [self startTimer];
}

#pragma mark 重写dataArray的Setter
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    self.pageControl.numberOfPages = dataArray.count;
    [self loadImages];
}

#pragma mark 重写blockUrlLoading的Setter
- (void)setBlockUrlLoading:(blockImageUrlLoading)blockUrlLoading
{
    _blockUrlLoading = [blockUrlLoading copy];
    
    [self loadImages];
}

#pragma mark 重写currentPageIndicatorTintColor的Setter
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

#pragma mark 重写pageIndicatorTintColor的Setter
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

#pragma mark - 设置pageControl颜色
- (void)setPageControlCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

@end
