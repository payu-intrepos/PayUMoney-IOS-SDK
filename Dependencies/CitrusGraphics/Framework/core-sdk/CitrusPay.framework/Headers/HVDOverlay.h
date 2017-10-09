//
//  HVDOverlay.h
//
//  Created by Harshad on 01/08/14.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface HVDOverlay : NSObject

+ (instancetype)overlayWithImage:(UIImage *)image;

+ (instancetype)spinnerOverlay;

- (void)show;
- (void)dismiss;

- (void)setOverlayColor:(UIColor *)overlayColor;

- (void)setTintColor:(UIColor *)tintColor;

@end
