#import <UIKit/UIKit.h>

// 1. 首页广告类声明
@interface TMEAdFullScreenMaskView : UIView
@end
@interface XMHomeRecMaskBannerAdCell : UITableViewCell
@end
@interface TMEAdMaskBannerView : UIView
@end
@interface TMEAdNativeView : UIView
@end

// 2. 播放页广告类声明
@interface XMHPlayingAdLargeView : UIView
@end
@interface XMRNPlayLargeAdView : UIView
@end
@interface XMHPlayingYellowBarUnionItem : UIView
@end

// ==========================================
// 首页去广告
// ==========================================
%hook TMEAdFullScreenMaskView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    [self removeFromSuperview];
}
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
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    [self removeFromSuperview];
}
%end

%hook TMEAdNativeView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
}
%end

// ==========================================
// 播放页去广告
// ==========================================

// 干掉播放页底部的原生大广告
%hook XMHPlayingAdLargeView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
}
%end

// 干掉播放页底部的 RN 大广告
%hook XMRNPlayLargeAdView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
}
%end

// 干掉播放页顶部/悬浮的“小黄条”广告
%hook XMHPlayingYellowBarUnionItem
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
}
%end
