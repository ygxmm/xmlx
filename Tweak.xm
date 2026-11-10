#import <UIKit/UIKit.h>

// ==========================================
// 类声明
// ==========================================
@interface XMHPlayingAdLargeView : UIView
@end
@interface XMHPlayingYellowBarUnionItem : UIView
@end
@interface XMAdRewardAlert : UIView
@end
@interface XMFeedAdView : UIView
@end
@interface JADInterstitialAd : NSObject
@end
@interface TGGDTSplashViewController : UIViewController
- (void)splashViewDismissAnimated:(BOOL)animated completion:(void (^)(void))completion;
@end
@interface XMHomeRecMaskBannerAdCell : UICollectionViewCell
@end

// 新增：摇一摇和全屏广告
@interface TMEAdNativeShakeView : UIView
@end
@interface XMOneShotGiantScreenAdView : UIView
@end

// ==========================================
// 1. 播放页：精准干掉底部大图广告
// ==========================================
%hook XMHPlayingAdLargeView
- (void)loadVideo { }
- (void)didMoveToWindow {
    %orig; self.hidden = YES; self.alpha = 0;
    CGRect frame = self.frame; frame.size.height = 0; self.frame = frame;
}
%end

// ==========================================
// 2. 播放页：精准干掉小黄条
// ==========================================
%hook XMHPlayingYellowBarUnionItem
+ (BOOL)canCreateWithSoundItem:(id)item { return NO; }
%end

// ==========================================
// 3. 弹窗拦截
// ==========================================
%hook XMAdRewardAlert
- (id)initWithHeaderIcon:(id)a bgImage:(id)b setttingIntro:(id)c cancelButtonTitle:(id)d certainButtonTitle:(id)e tapBlock:(id)f { return nil; }
- (id)initWithHeaderIcon:(id)a bgImage:(id)b title:(id)c setttingIntro:(id)d cancelButtonTitle:(id)e certainButtonTitle:(id)f tapBlock:(id)g { return nil; }
%end

%hook XMFeedAdView
- (void)requestFeedAd { }
- (void)show { }
- (void)showFeedAdView { }
%end

%hook JADInterstitialAd
- (void)loadAdData { }
- (void)showAdFromRootViewController:(id)vc { }
%end

// ==========================================
// 4. 首页：干掉摇一摇和全屏广告
// ==========================================
%hook TMEAdNativeShakeView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
}
%end

%hook XMOneShotGiantScreenAdView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
}
%end

// ==========================================
// 5. 开屏广告
// ==========================================
%hook TGGDTSplashViewController
- (BOOL)splashViewShowWithModel:(id)model animBegin:(id)animBegin animEnd:(id)animEnd cacheWebView:(BOOL)cacheWebView {
    [self splashViewDismissAnimated:NO completion:nil]; return NO;
}
- (BOOL)splashViewShowWithModel:(id)model animBegin:(id)animBegin animEnd:(id)animEnd cacheWebView:(BOOL)cacheWebView firstFrameCompletion:(id)completion {
    [self splashViewDismissAnimated:NO completion:nil]; return NO;
}
%end

%hook XMHomeRecMaskBannerAdCell
+ (CGSize)sizeForCellWithCellModel:(id)model { return CGSizeZero; }
+ (CGSize)sizeForCellWithCellModel:(id)model availableWidth:(double)width { return CGSizeZero; }
%end
