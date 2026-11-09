#import <UIKit/UIKit.h>

// 1. 干掉全屏/开屏广告遮罩
%hook TMEAdFullScreenMaskView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    [self removeFromSuperview];
}
%end

// 2. 干掉首页信息流里的 Banner 广告 Cell
%hook XMHomeRecMaskBannerAdCell
- (void)layoutSubviews {
    %orig;
    self.hidden = YES;
    // 顺便把高度设为 0，防止它占位置
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
}
%end

// 3. 干掉 Banner 广告视图本身
%hook TMEAdMaskBannerView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
    [self removeFromSuperview];
}
%end

// 4. 干掉原生广告视图
%hook TMEAdNativeView
- (void)didMoveToWindow {
    %orig;
    self.hidden = YES;
}
%end
