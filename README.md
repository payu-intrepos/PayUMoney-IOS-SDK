# PayUmoney iOS SDK

### INTRODUCTION

The PayUmoney iOS SDK enables collection of payments via various payment methods.The SDK is designed for various merchants who are developing their own iOS apps and need a mode which accepts payments within these apps.

### FEATURES
PayUmoney iOS SDK broadly offers following features.

* Login to PayUmoney
* Guest checkout if you do not have PayUmoney account
* Payments via credit/debit card (CC, DC) or netbanking payments (NB)
* Saving Credit/Debit cards into user's account for easier future payments by abiding The Payment Card Industry Data Security Standard (PCI DSS)
* One Tap functionality for the Saved Cards
* Simplified bank page interaction using Custom Browser.

### Technical Integration

* Drag and drop the ‘PayUmoney_SDK.framework’ into your project
* In your target’s general settings, make sure you have entry ‘PayUmoney_SDK.framework’ in Embedded Binaries and ‘Linked Frameworks and Libraries’
* Import umbrella header file into the View Controller from where you  to initiate the payment
```sh
    #import <PayUmoney_SDK/PayUmoney_SDK.h>
```
* To start the payment process, you need to create an object of type ‘PUMRequestParams’
    ```sh
    self.params = [[PUMRequestParams alloc] init];
    ```
* Set the mandatory properties of ‘params’ object
    ```sh
    self.params.environment = PUMEnvironmentProduction;
	self.params.surl = @“https://www.payumoney.com/mobileapp/payumoney/success.php”
	self.params.furl = @“https://www.payumoney.com/mobileapp/payumoney/failure.php”
	self.params.amount = @"100";
	self.params.key = @"";
	self.params.merchantid = @"";
	self.params.txnid =@“”;
	//Set your Surl/Furl here
	self.params.delegate = self;
	self.params.firstname = @"";
	self.params.productinfo = @"";
	self.params.email = @"";
	self.params.phone = @"";
	self.params.udf1 = @"";
	self.params.udf2 = @"";
	self.params.udf3 = @"";
	self.params.udf4 = @"";
	self.params.udf5 = @"";
	self.params.udf6 = @"";
	self.params.udf7 = @"";
	self.params.udf8 = @"";
	self.params.udf9 = @"";
	self.params.udf10 = @"";
	//get hash from your server
	self.params.hashValue = @“hash from server”; 
    ```
### HASH CALCULATION
```sh
hashSequence = key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5|salt.
```

Calculate the hash at your server side by using the above format of hash sequence. Encrypt it in SHA-512 and pass in params.hash.

Please Note – udf1 to udf5 are user-defined fields. These are meant to send any additional valuesthat you need to post. However, if you don’t feel the need to post any additional params, even then you will need post these params with blank values.
Create a view controller of type PUMMainVController
Create a UINavigationController with controller created in step 7 as root view controller 
Present the navigation controller created in step 8.
```sh
PUMMainVController *paymentVC = [[PUMMainVController alloc] init];
 UINavigationController *paymentNavController = [[UINavigationController alloc] initWithRootViewController:paymentVC];    

	    [self presentViewController:paymentNavController
                       animated:YES
                     completion:nil];

```

### PAYMENT COMPLETION

To know when the payment has completed, implement the following methods in your controller and get success/failure response:

```sh
-(void)transactionCompletedWithResponse:(NSDictionary*)response
                       errorDescription:(NSError* )error {    
}
-(void)transactinFailedWithResponse:(NSDictionary* )response
                   errorDescription:(NSError* )error {
}
-(void)transactinExpiredWithResponse: (NSString *)msg {
}
-(void)transactinCanceledByUser {    
}
```

### USING SDK IN TEST MODE
For using SDK in test mode you need to follow the below mentioned steps.
* params.test = PUMEnvironmentTest
* Send the SURL/FURL, MerchantId and key accordingly for test and live mode.

