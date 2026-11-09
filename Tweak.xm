#import <UIKit/UIKit.h>

// ==========================================
// 类声明
// ==========================================
// 播放页广告
@interface XMHPlayingAdLargeView : UIView
@end
@interface XMHPlayingYellowBarUnionItem : UIView
@end

// 弹窗/插屏广告
@interface XMAdRewardAlert : UIView // 继承自 RWAlertView
@end
@interface XMFeedAdView : UIView
@end
@interface JADInterstitialAd : NSObject
@end

// 开屏 & 首页
@interface TGGDTSplashViewController : UIViewController
- (void)splashViewDismissAnimated:(BOOL)animated completion:(void (^)(void))completion;
@end
@interface XMHomeRecMaskBannerAdCell : UICollectionViewCell
@end

// ==========================================
// 1. 播放页：精准干掉底部大图广告
// ==========================================
%hook XMHPlayingAdLargeView
- (void)loadVideo {
    NSLog(@"[xmly] 拦截播放页大图广告视频加载");
}
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    self.alpha = 0;
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
}
%end

// ==========================================
// 2. 播放页：精准干掉小黄条
// ==========================================
%hook XMHPlayingYellowBarUnionItem
+ (BOOL)canCreateWithSoundItem:(id)item {
    return NO; 
}
%end

// ==========================================
// 3. 弹窗拦截：干掉广告奖励弹窗
// ==========================================
%hook XMAdRewardAlert
// 直接把初始化拦截掉，返回 nil，让它连实例都创建不出来
- (id)initWithHeaderIcon:(id)a bgImage:(id)b setttingIntro:(id)c cancelButtonTitle:(id)d certainButtonTitle:(id)e tapBlock:(id)f {
    NSLog(@"[xmly] 拦截广告奖励弹窗 (init 1)");
    return nil;
}
- (id)initWithHeaderIcon:(id)a bgImage:(id)b title:(id)c setttingIntro:(id)d cancelButtonTitle:(id)e certainButtonTitle:(id)f tapBlock:(id)g {
    NSLog(@"[xmly] 拦截广告奖励弹窗 (init 2)");
    return nil;
}
%end

// ==========================================
// 4. 弹窗拦截：干掉信息流弹窗视图
// ==========================================
%hook XMFeedAdView
// 拦截网络请求和展示
- (void)requestFeedAd {
    NSLog(@"[xmly] 拦截信息流广告请求");
}
- (void)show {
    NSLog(@"[xmly] 拦截信息流广告弹出");
}
- (void)showFeedAdView {
    NSLog(@"[xmly] 拦截信息流广告视图显示");
}
%end

// ==========================================
// 5. 弹窗拦截：干掉京东插屏广告
// ==========================================
%hook JADInterstitialAd
- (void)loadAdData {
    NSLog(@"[xmly] 拦截京东插屏数据加载");
}
- (void)showAdFromRootViewController:(id)vc {
    NSLog(@"[xmly] 拦截京东插屏展示");
}
%end

// ==========================================
// 6. 首页/开屏：干掉开屏广告
// ==========================================
%hook TGGDTSplashViewController
- (BOOL)splashViewShowWithModel:(id)model animBegin:(id)animBegin animEnd:(id)animEnd cacheWebView:(BOOL)cacheWebView {
    [self splashViewDismissAnimated:NO completion:nil];
    return NO;
}
- (BOOL)splashViewShowWithModel:(id)model animBegin:(id)animBegin animEnd:(id)animEnd cacheWebView:(BOOL)cacheWebView firstFrameCompletion:(id)completion {
    [self splashViewDismissAnimated:NO completion:nil];
    return NO;
}
%end

// ==========================================
// 7. 首页：干掉信息流 Banner
// ==========================================
%hook XMHomeRecMaskBannerAdCell
+ (CGSize)sizeForCellWithCellModel:(id)model { return CGSizeZero; }
+ (CGSize)sizeForCellWithCellModel:(id)model availableWidth:(double)width { return CGSizeZero; }
%end
