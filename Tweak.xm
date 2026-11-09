#import <UIKit/UIKit.h>

// 声明我们用到的类
@interface TGGDTSplashViewController : UIViewController
@end
@interface XMLaunchView : UIView
@end
@interface TMEAdFullScreenMaskView : UIView
@end
@interface XMHomeRecMaskBannerAdCell : UITableViewCell
@end
@interface TMEAdMaskBannerView : UIView
@end
@interface TMEAdNativeView : UIView
@end
@interface XMHPlayingAdLargeView : UIView
@end
@interface XMRNPlayLargeAdView : UIView
@end
@interface XMHPlayingYellowBarUnionItem : UIView
@end

// ==========================================
// 暴力干掉开屏 VC
// ==========================================
%hook TGGDTSplashViewController

// 1. 强行不让它加载真实的 View
- (void)loadView {
    // 不调用 %orig，直接给它一个透明的空 View
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor clearColor];
}

// 2. 试图阻断它的初始化
- (instancetype)init {
    self = %orig;
    if (self) {
        NSLog(@"[xmly] 抓到开屏广告 VC 初始化，准备关闭");
    }
    return self;
}

// 3. 只要它一出现，立刻关掉
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    [self dismissViewControllerAnimated:NO completion:nil];
}
%end

// ==========================================
// 顺手干掉底层的启动图
// ==========================================
%hook XMLaunchView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
}
%end

// ==========================================
// 其他常规页面广告 (首页 + 播放页)
// ==========================================
%hook TMEAdFullScreenMaskView
- (void)didMoveToWindow { %orig; self.hidden = YES; [self removeFromSuperview]; }
%end

%hook XMHomeRecMaskBannerAdCell
- (void)layoutSubviews {
    %orig; self.hidden = YES;
    CGRect frame = self.frame; frame.size.height = 0; self.frame = frame;
}
%end

%hook TMEAdMaskBannerView
- (void)didMoveToWindow { %orig; self.hidden = YES; [self removeFromSuperview]; }
%end

%hook TMEAdNativeView
- (void)didMoveToWindow { %orig; self.hidden = YES; }
%end

%hook XMHPlayingAdLargeView
- (void)didMoveToWindow {
    %orig; self.hidden = YES;
    CGRect frame = self.frame; frame.size.height = 0; self.frame = frame;
}
%end

%hook XMRNPlayLargeAdView
- (void)didMoveToWindow {
    %orig; self.hidden = YES;
    CGRect frame = self.frame; frame.size.height = 0; self.frame = frame;
}
%end

%hook XMHPlayingYellowBarUnionItem
- (void)didMoveToWindow {
    %orig; self.hidden = YES;
    CGRect frame = self.frame; frame.size.height = 0; self.frame = frame;
}
%end
