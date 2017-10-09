//
//  CTSPrepaidPayResp.h
//  CTS iOS Sdk
//
//  Created by Yadnesh on 9/15/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CTSAmount.h"

@interface CTSPrepaidPayResp : JSONModel
/*{
    "customer":"developercitrus@mailinator.com",
    "merchant":"Citrus SDK Test",
    "type":"Sale",
    "date":1442384263773,
    "amount":{
        "value":1,
        "currency":"INR"
    },
    "status":"SUCCESSFUL",
    "reason":"",
    "balance":{
        "value":320.00,
        "currency":"INR"
    },
    "ref":"144238426257265:Citrus SDK Test",
    "returnUrl":null,
    "customParams":null,
    "responseParams":{
        "paymentMode":"PREPAID_CARD",
        "transactionId":"CTX1509160617439835253",
        "impsMobileNumber":"",
        "pgRespCode":"1",
        "TxRefNo":"CTX1509160617439835253",
        "TxMsg":"",
        "authIdCode":"1488615",
        "cardType":"CPAY",
        "pgTxnNo":"1488615",
        "currency":"INR",
        "TxStatus":"SUCCESSFUL",
        "amount":"1",
        "maskedCardNumber":"",
        "avoidSaveCard":"true",
        "impsMmid":"",
        "isCOD":"",
        "TxId":"144238426257265",
        "txnDateTime":"Wed Sep 16 06:17:43 UTC 2015",
        "TxGateway":"PREPAID PG (Citrus Plus)",
        "productName":"",
        "issuerRefNo":"1488615",
        "signature":"249fc57dd2547a72e163da006bfa97b406ec908b"
    }
}
 */
@property (strong)NSString *customer,*merchant,*type,*date,*status,*ref;
@property (strong)CTSAmount* amount,*balance;
@property(strong)NSDictionary *responseParams;
@property(strong)NSDictionary<Optional> *customParams;

@end
