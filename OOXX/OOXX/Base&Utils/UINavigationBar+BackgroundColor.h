//
//  UINavigationBar+BackgroundColor.h
//  OOXX
//
//  Created by NanZhang on 2017/10/1.
//  Copyright © 2017年 NanZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BackgroundColor)

- (UIView *)overlay;
- (void)setOverlay:(UIView *)overlay;
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;

@end
