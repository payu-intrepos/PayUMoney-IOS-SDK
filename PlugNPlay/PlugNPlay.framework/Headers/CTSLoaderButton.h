//
//  CTSLoaderButton.h
//  DemoLayout
//
//  Created by Nirma on 01/09/16.
//  Copyright © 2016 Nirma. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface CTSLoaderButton : UIButton

@property (nonatomic ,strong) UIActivityIndicatorView *activityLoader;

    //-(id)initWithLoader:(CGRect)frame;
-(void)startLoad;
-(void)endLoad;

@end
