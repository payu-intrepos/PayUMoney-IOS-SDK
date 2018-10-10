//
//  PUUIViewController.h
//  PayUNonSeamlessTestApp
//
//  Created by Vipin Aggarwal on 11/03/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PayU_CB_SDK.h"
#import <WebKit/WebKit.h>
#import "PUCBConfiguration.h"

NS_ENUM(NSInteger) {
    PUCBNilArgument = 100,
    PUCBInvalidMerchantKey = 101,
    PUCBBankSimulatorNotSupported = 102
};


@protocol PUCBWebVCDelegate <NSObject>

@required
/*!
 * This method gets called when transaction is successfull.
 * @param response
 * Response sent by PayU on successful completion of Payment.
 *
 * @note Hash inside response should be compared with server calculated hash to rule out possibility of tampering of data.
 * This should be done at server's end.
 *
 */
- (void)PayUSuccessResponse:(id)response;

/*!
 * This method gets called when transaction fails. It logs txn_fail event.
 * @param response
 * Response sent by PayU when the transaction gets failed
 */
- (void)PayUFailureResponse:(id)response;

/*!
 * This method gets called in case of network error
 * @param notification
 * An NSDictionary containing details about the network error
 */
- (void)PayUConnectionError:(NSDictionary *)notification;

/*!
 * This method gets called in case of transaction is cancelled by Back press
 */
- (void)PayUTransactionCancel;

/*!
 * If the merchant intentends to receive response from her own server, this method shoudld be implemented.
 * This method is called when merchant's Success URL passes data to the custom browser.
 * @param payUResponse
 * Response sent by PayU on successful completion of Payment.
 * @param surlResponse
 * Response sent by merchant's server on successful completion of the payment.
 */
- (void)PayUSuccessResponse:(id) payUResponse SURLResponse:(id) surlResponse;
    
    
/*!
 * If the merchant intentends to receive response from her own server, this method shoudld be implemented.
 * This method is called when merchant's Failure URL passes data to the custom browser.
 * @param payUResponse
 * Response sent by PayU when the transaction gets failed.
 * @param furlResponse
 * Response sent by merchant's server on failure of the payment.
 */
- (void)PayUFailureResponse:(id) payUResponse FURLResponse:(id) furlResponse;

@optional
/*!
 * This method gets called when user presses back button
 * You must return NO from this if you want to show your own view (like alert)
 */
- (void)shouldDismissVCOnBackPress;
    
/*!
 * This method gets called in case of transaction gets terminated without getting any response
 */
 - (void)PayUTerminateTransaction;
    
/*!
 * This method is called when PUCBWebVC has performed its duty and should be removed from view hirearchy.
 * Implement this method if you want to control how PUCBWebVC should be removed.
 * If not implemented, CB will be popped (if it was pushed to navigation controller) or dismissed (if it as presented)
 */
- (void)removeCustomBrowser;
@end


@interface PUCBWebVC : UIViewController <UIWebViewDelegate, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate>

@property (strong, nonatomic) UIWebView *vwWebView;
@property (strong, nonatomic) WKWebView *vwWKWebView;
@property (weak, nonatomic) id <PUCBWebVCDelegate> cbWebVCDelegate;

/*!
 * Following initializers are not available for this class.
 * To create instance, use designated initializers
 */
-(instancetype) init ATTRIBUTE_INIT;
+(instancetype) new ATTRIBUTE_NEW;


/*!
 * This method is one of the two designated initializer of PUCBWebVC class
 * @param postParam
 * Post parmamters required by the payment server
 * @param url
 * This is the payment URL, the first URL which gets loaded in payment journey
 * @param key
 * This is the merchant key which she gets after onbaording PayU
 * @param error
 * Error is retured if the other parmaters fails validation checks
 @see -initWithNSURLRequest:merchantKey:error
 */

- (instancetype)initWithPostParam:(NSString*)postParam
                        url:(NSURL*)url
                merchantKey:(NSString*)key
                            error:(NSError**)error;

/*!
 * This method is one of the two designated initializer of PUCBWebVC class
 * @param request
 * This is the NSURLRequest which should ideally contain post params along with the payment URL
 * @param key
 * This is the merchant key which she gets after onbaording PayU
 * @param error
 * Error is retured if the other parmaters fails validation checks
 */
- (instancetype)initWithNSURLRequest:(NSURLRequest*)request
                         merchantKey:(NSString*)key
                               error:(NSError**)error;

@end
