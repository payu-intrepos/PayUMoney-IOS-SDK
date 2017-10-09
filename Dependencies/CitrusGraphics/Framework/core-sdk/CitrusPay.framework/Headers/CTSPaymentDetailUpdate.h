//
//  CTSPaymentDetailUpdate.h
//  RestFulltester
//
//  Created by Yadnesh Wankhede on 12/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "CTSPaymentOption.h"
#import "CTSElectronicCardUpdate.h"
#import "CTSNetBankingUpdate.h"
#import "CTSBlazeCardPayment.h"

@interface CTSPaymentDetailUpdate : JSONModel
@property( strong) NSString* type;
@property( strong) NSString <Optional>*defaultOption;
@property( strong) NSString<Optional>* password;
@property( strong) NSMutableArray<CTSPaymentOption>* paymentOptions;
-(instancetype)initCitrusPayWithEmail:(NSString *)email;

+(CTSPaymentDetailUpdate *)citrusPay DEPRECATED_ATTRIBUTE;

-(CTSPaymentDetailUpdate *)initCitrusCash;
/**
 *  to add card to the object, internally stored in an array to send to
 *server,card is validated before they are added to the array
 *
 *  @param card object of type CTSElectronicCardUpdate
 *
 *  returns SUCESS of type CardValidationError , else corrospding error
 *of type CardValidationError is returned
 */
- (void)addCard:(CTSElectronicCardUpdate*)card;

/**
 *  to add netbanking detail to the object, internally stored in an array to
 *send to server,currently no validation
 *
 *  @param netBankDetail : the detail related to bank
 *
 *  @return always returns true
 */

- (BOOL)addNetBanking:(CTSNetBankingUpdate*)netBankDetail;




/**
 Convinience method to help forming nb code
 */
-(void)addFakeNBCode;



/**
 validate the object

 @return Error code
 */
-(CTSErrorCode)validate;



/**
 delete cvv field
 */
- (void)clearCVV;



/**
 to check if its tokenized

 @return return YES if its tokenized payment
 */
-(BOOL)isTokenizedCard;



/**
 delete netbanking code from the object
 */
- (void)clearNetbankCode;



/**
 validate if the object is for tokenized payment

 @return return error code
 */
-(CTSErrorCode)validateTokenized;



/**
 to check if payent is tokenized

 @return return YES if payent object is for tokenized payment
 */
-(BOOL)isTokenized;



/**
 add dummy cvv and expiry for Maetro card
 */
-(void)dummyCVVAndExpiryIfMaestro;



/**
 only CC are alowed in amex
 */
-(void)amexCreditcardCorrectionIfNeeded;




/**
 correct card details for Amex and Maestro cards
 */
-(void)doCardCorrectionsIfNeeded;


/**
 Method to convert data to Blaze cards payment

 @return BlazeCardPayment objct
 */
- (CTSBlazeCardPayment *)migrateToBlazeCardPaymentInfo;
@end
