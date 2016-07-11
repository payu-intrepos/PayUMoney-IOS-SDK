//
//  ActivityView.m
//  PayuMoneyApp
//
//  Created by Honey Lakhani on 7/7/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKActivityView.h"
@interface PayuMoneySDKActivityView ()

@property (nonatomic, strong) UIView *originalView;
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UIImageView *activityIndicator;
@property (nonatomic, strong) UILabel *activityLabel;

@end
@implementation PayuMoneySDKActivityView

static PayuMoneySDKActivityView *activityView = nil;

+(PayuMoneySDKActivityView *)currentActivityView
{
    return activityView;
}
+ (PayuMoneySDKActivityView *)activityViewForView:(UIView *)addToView withLabel:(NSString *)labelText;
{
    return [self activityViewForView:addToView withLabel:labelText width:0];
}

+ (PayuMoneySDKActivityView *)activityViewForView:(UIView *)addToView withLabel:(NSString *)labelText width:(NSUInteger)aLabelWidth;
{
    // Immediately remove any existing activity view:
    if (activityView)
        [self removeView];
    
    // Remember the new view (so this is a singleton):
    activityView = [[self alloc] initForView:addToView withLabel:labelText width:aLabelWidth];
    
    return activityView;
}

- (PayuMoneySDKActivityView *)initForView:(UIView *)addToView withLabel:(NSString *)labelText width:(NSUInteger)aLabelWidth;
{
    if (!(self = [super initWithFrame:CGRectZero]))
        return nil;
    
    // Allow subclasses to change the view to which to add the activity view (e.g. to cover the keyboard):
    self.originalView = addToView;
    addToView = [self viewForView:addToView];
    
    // Configure this view (the background) and its subviews:
    [self setupBackground];
    self.labelWidth = aLabelWidth;
    self.borderView = [self makeBorderView];
    self.activityIndicator = [self makeActivityIndicator];
    self.activityLabel = [self makeActivityLabelWithText:labelText];
    
    // Assemble the subviews:
    [addToView addSubview:self];
    [self addSubview:self.borderView];
    [self.borderView addSubview:self.activityIndicator];
    [self.borderView addSubview:self.activityLabel];
    //[self.activityIndicatorView startAnimating];
    // Animate the view in, if appropriate:
   // [self animateShow];
    
    return self;
}

- (UIView *)viewForView:(UIView *)view;
{
    return view;
}
- (void)setupBackground;
{
    self.opaque = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.45];
}


/*
 makeBorderView
 
 Returns a new view to contain the activity indicator and label.  By default this view is transparent.  Subclasses may override this method, optionally calling super, to use a different or customized view.
 
 Written by DJS 2009-07.
 Changed by DJS 2011-11 to simplify and make it easier to override.
 */

- (UIView *)makeBorderView;
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
    view.opaque = NO;
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    view.layer.cornerRadius = 10.0;
    return view;
}
+ (void)removeView;
{
    if (!activityView)
        return;
    
    if (activityView.showNetworkActivityIndicator)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [activityView removeFromSuperview];
    
    // Remove the global reference:
    activityView = nil;
}

+ (void)removeViewAnimated:(BOOL)animated
{
    if (!activityView)
        return;
    
    if (animated)
        [activityView animateRemove];
    else
        [[self class] removeView];
}

- (void)setShowNetworkActivityIndicator:(BOOL)show;
{
    self.showNetworkActivityIndicator = show;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = show;
}


- (void)animateShow;
{
    self.alpha = 0.0;
    self.borderView.transform = CGAffineTransformMakeScale(3.0, 3.0);
    
    [UIView beginAnimations:nil context:nil];
    //	[UIView setAnimationDuration:5.0];            // Uncomment to see the animation in slow motion
    
    self.borderView.transform = CGAffineTransformIdentity;
    self.alpha = 1.0;
    
    [UIView commitAnimations];
}

/*
 animateRemove
 
 Animates the view out, deferring the removal until the animation is complete.  For the bezel style, fades out the background and zooms the bezel down to half size.
 
 Written by DJS 2009-07.
 Changed by DJS 2009-09 to disable the network activity indicator if it was shown by this view.
 */

- (void)animateRemove;
{
    if (self.showNetworkActivityIndicator)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.borderView.transform = CGAffineTransformIdentity;
    
    [UIView beginAnimations:nil context:nil];
    //	[UIView setAnimationDuration:5.0];            // Uncomment to see the animation in slow motion
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeAnimationDidStop:finished:context:)];
    
    self.borderView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.alpha = 0.0;
    
    [UIView commitAnimations];
}

- (void)removeAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
{
    [[self class] removeView];
}


/*
 makeActivityIndicator
 
 Returns a new activity indicator view.  Subclasses may override this method, optionally calling super, to use a different or customized view.
 
 Written by DJS 2009-07.
 Changed by DJS 2011-11 to simplify and make it easier to override.
 */


- (UIImageView *)makeActivityIndicator;
{
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    
//    [indicator startAnimating];
//
    UIImageView *indicator  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    NSArray *imgArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"nopoint.png"],[UIImage imageNamed:@"onepoint.png"],[UIImage imageNamed:@"twopoint"],[UIImage imageNamed:@"threepoint"], nil];
   // indicator.backgroundColor = [UIColor redColor];
    indicator.animationImages = imgArray;
    indicator.animationDuration = 1.5;
    [indicator startAnimating];
    //[self addSubview:indicator];
    
    return indicator;
}

/*
 makeActivityLabelWithText:
 
 Returns a new activity label.  The bezel style uses centered white text.
 
 Written by DJS 2009-07.
 Changed by Suleman Sidat 2011-07 to support a multi-line label.
 Changed by DJS 2011-11 to simplify and make it easier to override.
 Changed by chrisledet 2013-01 to use NSTextAlignmentCenter and NSLineBreakByWordWrapping instead of the deprecated UITextAlignmentCenter and NSLineBreakByCharWrapping.
 */

- (UILabel *)makeActivityLabelWithText:(NSString *)labelText;
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.text = labelText;
    
    return label;
}
- (CGRect)enclosingFrame;
{
    CGRect frame = self.superview.bounds;
    
    if (self.superview != self.originalView)
        frame = [self.originalView convertRect:self.originalView.bounds toView:self.superview];
    
    return frame;
}
- (void)layoutSubviews;
{
    // If we're animating a transform, don't lay out now, as can't use the frame property when transforming:
    if (!CGAffineTransformIsIdentity(self.borderView.transform))
        return;
    
    self.frame = [self enclosingFrame];
    
    CGSize maxSize = CGSizeMake(260, 400);
    CGSize textSize = [self.activityLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]] constrainedToSize:maxSize lineBreakMode:self.activityLabel.lineBreakMode];
    
    // Use the fixed width if one is specified:
    if (self.labelWidth > 10)
        textSize.width = self.labelWidth;
    
    // Require that the label be at least as wide as the indicator, since that width is used for the border view:
    if (textSize.width < self.activityIndicator.frame.size.width)
        textSize.width = self.activityIndicator.frame.size.width + 10.0;
    
    // If there's no label text, don't need to allow height for it:
    if (self.activityLabel.text.length == 0)
        textSize.height = 0.0;
    
    self.activityLabel.frame = CGRectMake(self.activityLabel.frame.origin.x, self.activityLabel.frame.origin.y, textSize.width, textSize.height);
    
    // Calculate the size and position for the border view: with the indicator vertically above the label, and centered in the receiver:
    CGRect borderFrame = CGRectZero;
    borderFrame.size.width = textSize.width + 30.0;
    borderFrame.size.height = self.activityIndicator.frame.size.height + textSize.height + 40.0;
    borderFrame.origin.x = floor(0.5 * (self.frame.size.width - borderFrame.size.width));
    borderFrame.origin.y = floor(0.5 * (self.frame.size.height - borderFrame.size.height));
    self.borderView.frame = borderFrame;
    
    // Calculate the position of the indicator: horizontally centered and near the top of the border view:
    CGRect indicatorFrame = self.activityIndicator.frame;
    indicatorFrame.origin.x = 0.5 * (borderFrame.size.width - indicatorFrame.size.width);
    indicatorFrame.origin.y = 20.0;
    self.activityIndicator.frame = indicatorFrame;
    
    // Calculate the position of the label: horizontally centered and near the bottom of the border view:
    CGRect labelFrame = self.activityLabel.frame;
    labelFrame.origin.x = floor(0.5 * (borderFrame.size.width - labelFrame.size.width));
    labelFrame.origin.y = borderFrame.size.height - labelFrame.size.height - 10.0;
    self.activityLabel.frame = labelFrame;
}
@end
