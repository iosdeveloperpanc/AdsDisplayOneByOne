# AdsDisplayOneByOne
##简单易用-广告图片循环轮播

// 使用说明：

// 本地图片加载<br> 
 1. 如果不需要自动滚动，就将timerInterval传0或0以下的数字<br> 
 2. 如果不是网络加载，就将UrlLoadingBlock传nil即可<br> 
 3. 点击广告页的相应方法用的是block,实现blockTapAds的回调即可<br> 

// 网络图片加载<br> 
 1. 如果不需要自动滚动，就将timerInterval传0或0以下的数字<br> 
 2. 如果是网络加载，实现UrlLoadingBlock的回调<br> 
 3. 点击广告页的相应方法用的是block,实现blockTapAds的回调即可<br> 

// 如何使用？想怎么用就怎么用！<br> 
 1. #import "JXBAdPageView.h"<br>
 2. 不管是Xib加载JXBAdPageView，还是纯代码创建JXBAdPageView，均支持！v
    2.1 如果是Xib加载，去实现成员变量初始化即可<br>
        self.blockUrlLoading = blockUrlLoading;<br>
        self.dataArray = dataArray;<br>
        self.displayTime = displayTime;<br>
        以及颜色设置 参照步骤4<br>
    2.2 如果是代码创建，建议调用类方法、对象方法，一句代码完成创建及初始化过程。<br>
 
 3. 什么？你非要[[JXBAdPageView alloc] init] 或者 [[JXBAdPageView alloc] initWithFrame:]???<br>
    那也没关系，创建之后去实现成员变量初始化即可，参照步骤2.1。<br>
    （其实实际项目中，就是这样子去写的，先创建，获取到网络数据的时候进行赋值！）
 
 4. pageControl颜色设置<br>
       \- (void)setPageControlCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor; // 调用该方法
       也可以 单独设置<br>
       pageView.currentPageIndicatorTintColor = [UIColor redColor];<br>
       pageView.pageIndicatorTintColor = [UIColor blackColor];<br>
 
       // 若不设置，就默认当前色为黄色，其他page颜色为蓝色<br>
 
##写这个的原因<br> 
1.实际开发的需要<br> 
2.看到一位仁兄的代码，我觉得惨不忍睹，然后用他的实现思路，重写了一下，并封装的更全面、更简单、更易用<br> 
3.附上该仁兄源码的链接：https://github.com/JxbSir/JXBAdPageView<br> 
