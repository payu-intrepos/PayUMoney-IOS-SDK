//
//  iOSDefaultActivityIndicator.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 08/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSDefaultActivityIndicator : NSObject

//-(void)initActivityIndicatorWithSuperView:(UIView *) superView;
-(void)startAnimatingActivityIndicatorWithSelfView:(UIView *) selfView;
-(void)stopAnimatingActivityIndicator;

@end
