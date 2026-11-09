#import <UIKit/UIKit.h>

// ==========================================
// 声明我们需要 Hook 的类
// ==========================================
// 喜马拉雅播放页广告
@interface XMHPlayingAdLargeView : UIView
@end
@interface XMHPlayingYellowBarUnionItem : UIView
@end

// 开屏广告 & 首页广告
@interface TGGDTSplashViewController : UIViewController
@end
@interface XMHomeRecMaskBannerAdCell : UICollectionViewCell
@end

// ==========================================
// 1. 播放页：精准干掉底部大图广告
// ==========================================
%hook XMHPlayingAdLargeView

// 拦截加载视频广告的方法，不让它播
- (void)loadVideo {
    NSLog(@"[xmly] 拦截播放页大图广告视频加载");
}

// 在布局时直接将其高度置零并隐藏
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    self.alpha = 0;
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
}

// 拦截展示上报，防止无意义的网络请求
- (void)reportAdViewShow {
    // 不调用 %orig
}

%end

// ==========================================
// 2. 播放页：精准干掉小黄条（从源头断绝）
// ==========================================
%hook XMHPlayingYellowBarUnionItem

// 直接告诉系统：不要创建我！
+ (BOOL)canCreateWithSoundItem:(id)item {
    NSLog(@"[xmly] 拦截小黄条广告创建");
    return NO; 
}

%end

// ==========================================
// 3. 首页/开屏：干掉开屏广告控制器
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
// 4. 首页：干掉信息流 Banner 广告
// ==========================================
%hook XMHomeRecMaskBannerAdCell
+ (CGSize)sizeForCellWithCellModel:(id)model { return CGSizeZero; }
+ (CGSize)sizeForCellWithCellModel:(id)model availableWidth:(double)width { return CGSizeZero; }
%end
