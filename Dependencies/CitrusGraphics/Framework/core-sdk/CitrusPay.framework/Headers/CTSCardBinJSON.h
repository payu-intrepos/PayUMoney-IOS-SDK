//
//  CTSCardBinJSON.h
//  CitrusPay
//
//  Created by Mukesh Patil on 10/24/16.
//  Copyright © 2016 Citrus Payment Solutions Private Limited. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CTSUtility.h"
/* V1 BIN API
Sample Input JSON

In case of Success
In data found
{
    "country_code":"IND",
    "cardtype":"Debit Card",
    "cardscheme":"RUPAY",
    "currency_code":"INR",
    "Issuingbank":"",
    "country":"India"
}

 {"cardtype":"Credit Card","currency":"Euro","issuingbank":"PIRAEUS","cardscheme":"MASTERCARD","country_code":"GRC","issuingbank_code":"CID107","currency_code":"EUR","country":"Greece","iscvvless":""}
 
In no data found
{
    "Status":"success",
    "message":"No records found"
}


In case of Error
{
    "Status":"error",
    "Code":"001",
    "message":"Invalid bin number"
}
*/

/* V2 BIN API
In case of Success
In data found
{
    "issuingbank": "CITI BANK",
    "cardtype": "Credit Card",
    "cardscheme": "VISA",
    "currency_code": "INR",
    "currency": "Indian rupee",
    "country_code": "IND",
    "country": "India",
    "issuingbank_code": "CID-156",
    "iscvvless": ""
}

b. In no data found
{
    "Status":"success",
    "message":"No records found"
}

2. In case of Error
{
    "Status":"error",
    "Code":"001",
    "message":"Invalid bin number"
}
{
    "Status":"error",
    "Code":"002",
    "message":"Something goes down, Unable to pull details"
}
{
    "Status":"error",
    "Code":"003",
    "message":"Invalid bin list provided"
}
{
    "Status":"error",
    "Code":"004",
    "message":"Unauthorized request"
}
{
    "Status":"error",
    "Code":"005",
    "message":"Invalid parameters provided"
}
{
    'Status':'error',
    'code': '400',
    'message':'Bad request'
}
{
    'Status':'error',
    'code': '500',
    'message':'Internal server error'
}
*/

/**
 *   CTSCardBinJSON Class.
 */
@interface CTSCardBinJSON : JSONModel
// As per V1 API
/**
 *   The CTSCardBinJSON class' country_code object.
 */
@property (strong) NSString <Optional> * country_code;
/**
 *   The CTSCardBinJSON class' cardtype object.
 */
@property (strong) NSString <Optional> * cardtype;
/**
 *   The CTSCardBinJSON class' cardscheme object.
 */
@property (strong) NSString <Optional> * cardscheme;
/**
 *   The CTSCardBinJSON class' currency_code object.
 */
@property (strong) NSString <Optional> * currency_code;
/**
 *   The CTSCardBinJSON class' issuingbank object.
 */
@property (strong) NSString <Optional> * issuingbank;
/**
 *   The CTSCardBinJSON class' country object.
 */
@property (strong) NSString <Optional> * country;


// As per V2 API
/**
 *   The CTSCardBinJSON class' currency object.
 */
@property (strong) NSString <Optional> * currency;
/**
 *   The CTSCardBinJSON class' issuingbank_code object.
 */
@property (strong) NSString <Optional> * issuingbank_code;
/**
 *   The CTSCardBinJSON class' iscvvless object.
 */
@property (strong) NSString <Optional> * iscvvless;


// in case of error
/**
 *   The CTSCardBinJSON class' Status object.
 */
@property (strong) NSString <Optional> * status;
/**
 *   The CTSCardBinJSON class' message object.
 */
@property (strong) NSString <Optional> * message;
/**
 *   The CTSCardBinJSON class' Code object.
 */
@property (strong) NSString <Optional> * code;

-(CardType)getCardType;



@end
