//
//  JLMainVC1.m
//  TestScrollView
//
//  Created by jolly2 on 4/29/24.
//

#import "JLMainVC1.h"
#import "JLSubVC1.h"
#define isIPhoneXSeries ({\
BOOL iPhoneXSeries = NO;\
if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {\
(iPhoneXSeries);\
}\
if (@available(iOS 11.0, *)) {\
UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];\
if (mainWindow.safeAreaInsets.bottom > 0.0) {\
iPhoneXSeries = YES;\
}\
}\
(iPhoneXSeries);\
})

/// 状态栏高度
#define kStatusBarHeight  (CGFloat)(isIPhoneXSeries?(44):(20))
/// 状态栏和导航栏总高度
#define kNavBarHeight  (CGFloat)(isIPhoneXSeries?(88):(64))
/// topView的高
#define kTopViewHeight 200
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface JLMainVC1 ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)JLSubVC1 *testVC0;
@property (strong, nonatomic)JLSubVC1 *testVC1;
@end

@implementation JLMainVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addViewControllers];
}

- (void)addViewControllers{
    self.testVC0 = [JLSubVC1 new];
    [self addChildVC:self.testVC0 index:0];
    __weak typeof(self) WS = self;
    self.testVC0.scrollBlock = ^(UIScrollView *scrollView) {
        [WS updateTopViewFrame:scrollView];
    };
   
    self.testVC1 = [JLSubVC1 new];
    [self addChildVC:self.testVC1 index:1];
    self.testVC1.scrollBlock = ^(UIScrollView *scrollView) {
        [WS updateTopViewFrame:scrollView];
    };
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setBounces:NO];
    
    [self.scrollView setContentSize:CGSizeMake(kScreenWidth * self.childViewControllers.count, 0)];
    [self.scrollView setScrollEnabled:YES];
}
- (void)addChildVC:(UIViewController *)controller index:(NSInteger )index{
    [self addChildViewController:controller];
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    controller.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kScreenHeight);
    [self.scrollView addSubview:controller.view];
}
- (IBAction)typeClick:(UIButton *)sender {
    self.selectedIndex = 0;
}
- (IBAction)typeClick2:(UIButton *)sender {
    self.selectedIndex = 1;
}

#pragma mark - scrollViuew
//父视图滚动的回调，用于横向滚动判断
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%.2f, %.2f",scrollView.contentOffset.x, scrollView.contentOffset.y);
    
    CGFloat placeholderOffset = 0;
    if (self.selectedIndex == 0) {
        if (self.testVC0.scrollView.contentOffset.y > 150) {
            placeholderOffset = 150;
        }else {
            placeholderOffset = self.testVC0.scrollView.contentOffset.y;
        }
        [self.testVC1.scrollView setContentOffset:CGPointMake(0, placeholderOffset) animated:NO];
    }else {
        if (self.testVC1.scrollView.contentOffset.y > 150) {
            placeholderOffset = 150;
        }else {
            placeholderOffset = self.testVC1.scrollView.contentOffset.y;
        }
        [self.testVC0.scrollView setContentOffset:CGPointMake(0, placeholderOffset) animated:NO];
    }
}

// 选中第几个tab
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = ceilf(scrollView.contentOffset.x / kScreenWidth);
    self.selectedIndex = index;
}

//子视图滚动的回调，用于竖直方向上滚动判断
- (void)updateTopViewFrame:(UIScrollView *)scrollView{
    CGFloat placeHolderHeight = 150;
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat y = 0.0;
    if (offsetY >= 0 && (offsetY <= placeHolderHeight)) {
        NSLog(@"1- offsetY：%.2f <= placeHolderHeight：%.2f", offsetY, placeHolderHeight);
        y = -offsetY;
    } else if (offsetY > placeHolderHeight) {
        NSLog(@"2- offsetY：%.2f > placeHolderHeight：%.2f", offsetY, placeHolderHeight);
        y = -placeHolderHeight;
    } else if (offsetY < 0) {
        NSLog(@"3- offsetY：%.2f < 0,  placeHolderHeight：%.2f", offsetY, placeHolderHeight);
        y = -offsetY;
    }
    
    CGFloat y0 = y + kNavBarHeight;
    self.topView.frame = CGRectMake(0, y0, kScreenWidth, kTopViewHeight);
    
}

@end
