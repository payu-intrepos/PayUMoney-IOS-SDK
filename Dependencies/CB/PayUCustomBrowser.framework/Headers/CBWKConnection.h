//
//  CBWKConnection.h
//  PayU_iOS_SDK_TestApp
//
//  Created by Sharad Goyal on 25/09/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "PUCBBaseConnection.h"

/*!
 * This class is used provide CB functionality to the merchant.
 */
@interface CBWKConnection : PUCBBaseConnection

@property (nonatomic, copy) NSString *postData;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, weak) UIViewController *vcToPresentAlert;
@property BOOL didMakePostRequest;

#pragma mark - WKWebView scriptMessageHandler Delegate

- (void)payUuserContentController:(WKUserContentController *)userContentController
          didReceiveScriptMessage:(WKScriptMessage *)message;

#pragma mark - WKWebView Navigation Delegate

// Tracking Load Progress

- (void)payUwebView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;

- (void)payUwebView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error;

- (void)payUwebView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error;

-(void)payUwebView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;

- (void)payUwebView:(WKWebView *)webView
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
  completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition,
                              NSURLCredential *credential))completionHandler;

- (void)payUwebView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;

- (void)payUwebView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;

- (void)payUwebViewWebContentProcessDidTerminate:(WKWebView *)webView;

// Decide Load Policy Delegates

- (void)payUwebView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

- (void)payUwebView:(WKWebView *)webView
decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse
    decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;

#pragma mark - WKWebView UI Delegate

// Creating a webView

- (WKWebView *)payUwebView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;

// Displaying UI Panels

- (void)payUwebView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler;

- (void)payUwebView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;

- (void)payUwebView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *result))completionHandler;

// Closing a webView
- (void)payUwebViewDidClose:(WKWebView *)webView;

@end
