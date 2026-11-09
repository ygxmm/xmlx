#import <UIKit/UIKit.h>

// ==========================================
// 1. 类声明 (防止编译报错)
// ==========================================
// 首页广告
@interface TMEAdFullScreenMaskView : UIView
@end
@interface XMHomeRecMaskBannerAdCell : UITableViewCell
@end
@interface TMEAdMaskBannerView : UIView
@end
@interface TMEAdNativeView : UIView
@end

// 播放页广告
@interface XMHPlayingAdLargeView : UIView
@end
@interface XMRNPlayLargeAdView : UIView
@end
@interface XMHPlayingYellowBarUnionItem : UIView
@end

// 开屏广告 (腾讯广点通)
@interface TGGDTSplashViewController : UIViewController
@end
@interface XMLaunchView : UIView
@end

// ==========================================
// 2. 核心拦截：直接拦截 UIViewController 的弹出
// ==========================================
%hook UIViewController

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    // 如果是广点通的开屏广告，直接拦截，不让它弹出来！
    if ([viewControllerToPresent isKindOfClass:NSClassFromString(@"TGGDTSplashViewController")]) {
        NSLog(@"[xmly] 拦截了开屏广告 VC 的弹出");
        if (completion) {
            completion();
        }
        return; 
    }
    %orig;
}

%end

// ==========================================
// 3. 兜底拦截：如果开屏广告是加在 Window 上的
// ==========================================
%hook TGGDTSplashViewController
- (void)viewWillAppear:(BOOL)animated {
    %orig;
    // 就算它弹出来了，我也让你看不见
    self.view.hidden = YES;
    self.view.alpha = 0;
}
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    // 自动关掉它
    [self dismissViewControllerAnimated:NO completion:nil];
}
%end

// 顺手把底层的启动图也给弄透明，防止白屏
%hook XMLaunchView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
}
%end

// ==========================================
// 4. 其他页面广告 (保留之前的)
// ==========================================
%hook TMEAdFullScreenMaskView
- (void)didMoveToWindow { %orig; self.hidden = YES; [self removeFromSuperview]; }
%end

%hook XMHomeRecMaskBannerAdCell
- (void)layoutSubviews {
    %orig;
    self.hidden = YES;
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
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
    %orig;
    self.hidden = YES;
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
}
%end

%hook XMRNPlayLargeAdView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
}
%end

%hook XMHPlayingYellowBarUnionItem
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
}
%end
