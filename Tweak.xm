#import <UIKit/UIKit.h>

// ==========================================
// 1. 开屏广告精准拦截
// ==========================================
@interface TGGDTSplashViewController : UIViewController
@end

%hook TGGDTSplashViewController
- (BOOL)splashViewShowWithModel:(id)model animBegin:(id)animBegin animEnd:(id)animEnd cacheWebView:(BOOL)cacheWebView {
    NSLog(@"[xmly] 拦截开屏广告展示 1");
    [self splashViewDismissAnimated:NO completion:nil];
    return NO;
}
- (BOOL)splashViewShowWithModel:(id)model animBegin:(id)animBegin animEnd:(id)animEnd cacheWebView:(BOOL)cacheWebView firstFrameCompletion:(id)completion {
    NSLog(@"[xmly] 拦截开屏广告展示 2");
    [self splashViewDismissAnimated:NO completion:nil];
    return NO;
}
%end

// ==========================================
// 2. 首页信息流 Banner 广告精准拦截 (从数据源切断)
// ==========================================
@interface XMHomeRecMaskBannerAdCell : UICollectionViewCell
@end

%hook XMHomeRecMaskBannerAdCell
+ (CGSize)sizeForCellWithCellModel:(id)model {
    return CGSizeZero; // 让系统以为这个 Cell 高度是 0
}
+ (CGSize)sizeForCellWithCellModel:(id)model availableWidth:(double)width {
    return CGSizeZero; // 让系统以为这个 Cell 高度是 0
}
%end

// ==========================================
// 3. 全屏遮罩广告精准拦截
// ==========================================
@interface TMEAdFullScreenMaskView : UIView
@end
%hook TMEAdFullScreenMaskView
- (instancetype)initWithFrame:(CGRect)frame {
    self = %orig;
    if (self) self.hidden = YES;
    return self;
}
%end

// ==========================================
// 4. 暴力兜底 (防止有些广告用其他类名漏网)
// ==========================================
@interface XMLaunchView : UIView
@end
%hook XMLaunchView
- (void)didMoveToWindow { %orig; self.hidden = YES; }
%end

@interface TMEAdNativeView : UIView
@end
%hook TMEAdNativeView
- (void)didMoveToWindow { %orig; self.hidden = YES; }
%end
