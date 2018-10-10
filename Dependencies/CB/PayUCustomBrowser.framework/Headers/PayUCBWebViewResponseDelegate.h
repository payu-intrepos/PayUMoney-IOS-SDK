//
//  PayUCBWebViewResponseDelegate.h
//  PayUNonSeamlessTestApp
//
//  Created by Vipin Aggarwal on 13/05/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 * This protocol defines methods to get callback for transaction status.
 */
@protocol PayUCBWebViewResponseDelegate <NSObject>

/*!
 * This method gets called when transaction is successfull.
 * @param response Response sent by PayU on successful completion of Payment.
 *
 * @note Hash inside response should be compared with server calculated hash to rule out possibility of tampering of data.
 * This should be done at server's end.
 */
- (void)PayUSuccessResponse:(id)response;

/*!
 * @param response Response sent by PayU when the transaction gets failed
 */
- (void)PayUFailureResponse:(id)response;

/*!
 * @param notification An NSDictionary containing details about the network error
 */
- (void)PayUConnectionError:(NSDictionary *)notification;

@optional
- (void)PayUTxnCancelledWithBackPress;

- (void)PayUTerminateTransaction;

- (void)PayUSuccessResponse:(id) payUResponse SURLResponse:(id) surlResponse;

- (void)PayUFailureResponse:(id) payUResponse FURLResponse:(id) furlResponse;

@end
