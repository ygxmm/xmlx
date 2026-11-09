#import <UIKit/UIKit.h>

// ==========================================
// 1. 核心：精准拦截广点通开屏广告控制器
// ==========================================
@interface TGGDTSplashViewController : UIViewController
@end

%hook TGGDTSplashViewController

// 拦截展示广告的方法 1
- (BOOL)splashViewShowWithModel:(id)model animBegin:(id)animBegin animEnd:(id)animEnd cacheWebView:(BOOL)cacheWebView {
    NSLog(@"[xmly] 拦截开屏广告展示方法 1，直接返回 NO");
    // 主动调用自带的关闭方法，清理现场
    [self splashViewDismissAnimated:NO completion:nil];
    return NO; // 拒绝展示
}

// 拦截展示广告的方法 2
- (BOOL)splashViewShowWithModel:(id)model animBegin:(id)animBegin animEnd:(id)animEnd cacheWebView:(BOOL)cacheWebView firstFrameCompletion:(id)firstFrameCompletion {
    NSLog(@"[xmly] 拦截开屏广告展示方法 2，直接返回 NO");
    [self splashViewDismissAnimated:NO completion:nil];
    return NO;
}

// 拦截自带的关闭方法，确保它真的被清理掉
- (void)splashViewDismissAnimated:(BOOL)animated completion:(id)completion {
    %orig(YES, completion); // 强制执行带动画的关闭
}

%end

// ==========================================
// 2. 干掉底层启动图 (XMLaunchView)
// ==========================================
@interface XMLaunchView : UIView
@end
%hook XMLaunchView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
}
%end

// ==========================================
// 3. 首页广告拦截 (保留之前的)
// ==========================================
@interface TMEAdFullScreenMaskView : UIView
@end
@interface XMHomeRecMaskBannerAdCell : UITableViewCell
@end
@interface TMEAdMaskBannerView : UIView
@end
@interface TMEAdNativeView : UIView
@end

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

// ==========================================
// 4. 播放页广告拦截 (保留之前的)
// ==========================================
@interface XMHPlayingAdLargeView : UIView
@end
@interface XMRNPlayLargeAdView : UIView
@end
@interface XMHPlayingYellowBarUnionItem : UIView
@end

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
