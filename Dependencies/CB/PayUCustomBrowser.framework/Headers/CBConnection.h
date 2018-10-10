//
//  CBConnection.h
//  PayUTestApp
//
//  Created by Umang Arya on 20/07/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PUCBBaseConnection.h"
/*!
 * This class is used provide CB functionality to the merchant.
 */
@interface CBConnection : PUCBBaseConnection

#pragma mark - UIWebView delegate

/*!
 * This method must be called from UIWebView delegate method from Merchant's App.
 * @param  webView instance of webView received in parameter of [UIWebView webView:shouldStartLoadWithRequest:navigationType:]
 * @param  request request received in parameter of [UIWebView webView:shouldStartLoadWithRequest:navigationType:]
 */
- (void)payUwebView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request;

/*!
 * This method must be called from UIWebView delegate method from Merchant's App.
 * @param  webView instance of webView received in parameter of [UIWebView webViewDidStartLoad:]
 */
- (void)payUwebViewDidStartLoad:(UIWebView *)webView;

/*!
 * This method must be called from UIWebView delegate method from Merchant's App.
 * @param  webView instance of webView received in parameter of [UIWebView webView:didFailLoadWithError:]
 * @param  error error returned by delegate method of UIWebView [UIWebView webView:didFailLoadWithError:]
 */
- (void)payUwebView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

/*!
 * This method must be called from UIWebView delegate method from Merchant's App.
 * @param  webView instance of webView received in parameter of UIWebView's delegate method [UIWebView webViewDidFinishLoad:]
 */
- (void)payUwebViewDidFinishLoad:(UIWebView *)webView;

@end
