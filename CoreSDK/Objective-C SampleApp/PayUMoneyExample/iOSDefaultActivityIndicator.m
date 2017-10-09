//
//  iOSDefaultActivityIndicator.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 08/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "iOSDefaultActivityIndicator.h"


@interface iOSDefaultActivityIndicator()

@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) UIView *grayView;
@property (strong, nonatomic) UIView *superView;
@end

@implementation iOSDefaultActivityIndicator

-(instancetype)init{
    self = [super init];
    self.grayView = [UIView new];
    self.spinner = [UIActivityIndicatorView new];
    return self;
}

-(void)initActivityIndicatorWithSuperView:(UIView *) superView{
    self.grayView = [[UIView alloc]initWithFrame:superView.frame];
    self.grayView.backgroundColor = [UIColor grayColor];
    self.grayView.alpha = 0.5f;
    self.grayView.opaque = NO;
    superView.userInteractionEnabled=NO;
    self.grayView.userInteractionEnabled = NO;
    [superView addSubview:self.grayView];

    
    int heightWidthOfActivityIndicator = 50;
    _spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(superView.frame.size.width/2 - heightWidthOfActivityIndicator/2, superView.frame.size.height/2 - heightWidthOfActivityIndicator/2, heightWidthOfActivityIndicator, heightWidthOfActivityIndicator)];
    [_spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    _spinner.color = [UIColor blueColor];
    [superView addSubview:self.spinner];
    
    [superView bringSubviewToFront:self.grayView];
    [self.grayView bringSubviewToFront:self.spinner];
}

-(void)startAnimatingActivityIndicatorWithSelfView:(UIView *) selfView{
    [self initActivityIndicatorWithSuperView:selfView];
    self.superView = selfView;
    [self.spinner startAnimating];
}

-(void)stopAnimatingActivityIndicator{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.spinner stopAnimating];
        [self.grayView setHidden:true];
        self.superView.userInteractionEnabled = YES;
    });

}


@end
