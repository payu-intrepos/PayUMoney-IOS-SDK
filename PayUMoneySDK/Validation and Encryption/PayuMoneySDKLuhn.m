//
//  Luhn.m
//  payuSDK
//
//  Created by Honey Lakhani on 8/21/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKLuhn.h"
#import "PayuMoneySDKSetUpCardDetails.h"

@implementation Luhn
+(BOOL)validate : (NSString *)number
{
    int sum = 0;
    BOOL alternate = NO;
    int len = (int)number.length;
    //NSLog(@"len ====== %d",len);
    for (int i = len-1; i >= 0; i--)
    {
        int n = [[number substringWithRange:NSMakeRange(i, 1)] intValue];

               if(alternate)
        {
            n *= 2;
            //NSLog(@"nnnnnnnnnn %d",n);
            if(n>9)
                n = (n%10)+1;
            
        }
        sum += n;
        alternate = !alternate;
    }
    
    //sum += (sum * 9)%10;
    //NSLog(@"sum +++++++++++++++++ %d",sum);
    if(sum % 10 == 0)
    {
        if([[PayuMoneySDKSetUpCardDetails findIssuer:number :@"CC"]isEqual:@"VISA"] && number.length == 16)
            return YES;
        else if ([[PayuMoneySDKSetUpCardDetails findIssuer:number :@"CC"]isEqual:@"LASER"])
            return YES;
        else if ([[PayuMoneySDKSetUpCardDetails findIssuer:number :@"CC"]isEqual:@"MAST"] && number.length == 16)
            return YES;
        else if ([[PayuMoneySDKSetUpCardDetails findIssuer:number :@"CC"]isEqual:@"RUPAY"] && (number.length == 16 || number.length == 19))
            return YES;
        else if ([[PayuMoneySDKSetUpCardDetails findIssuer:number :@"CC"]isEqual:@"MAES"] && number.length >= 12 && number.length <=19)
            return YES;
        else if ([[PayuMoneySDKSetUpCardDetails findIssuer:number :@"CC"]isEqual:@"DINR"] && number.length == 14)
            return YES;
        else if ([[PayuMoneySDKSetUpCardDetails findIssuer:number :@"CC"]isEqual:@"AMEX"] && number.length == 15)
            return YES;
        else if([[PayuMoneySDKSetUpCardDetails findIssuer:number :@"CC"]isEqual:@"JCB"] && number.length == 16)
            return YES;
        
    }
    return NO;
}
@end




/*public class Luhn {


    public static boolean validate(String ccNumber) {
        int sum = 0;
        boolean alternate = false;
        for (int i = ccNumber.length() - 1; i >= 0; i--) {
            int n = Integer.parseInt(ccNumber.substring(i, i + 1));
            if (alternate) {
                n *= 2;
                if (n > 9) {
                    n = (n % 10) + 1;
                }
            }
            sum += n;
            alternate = !alternate;
        }
        if (sum % 10 == 0) {
            // valid now check length
            if (SetupCardDetails.findIssuer(ccNumber, "CC").contentEquals("VISA") && ccNumber.length() == 16) {
                return true;
            } else if (SetupCardDetails.findIssuer(ccNumber, "CC").contentEquals("LASER")) {
                return true;
            } else if (SetupCardDetails.findIssuer(ccNumber, "CC").contentEquals("MAST") && ccNumber.length() == 16) {
                return true;
            } else if (SetupCardDetails.findIssuer(ccNumber, "CC").contentEquals("MAES") && ccNumber.length() >= 12 && ccNumber.length() <= 19) {
                return true;
            } else if (SetupCardDetails.findIssuer(ccNumber, "CC").contentEquals("DINR") && ccNumber.length() == 14) {
                return true;
            } else if (SetupCardDetails.findIssuer(ccNumber, "CC").contentEquals("AMEX") && ccNumber.length() == 15) {
                return true;
            } else if (SetupCardDetails.findIssuer(ccNumber, "CC").contentEquals("JCB") && ccNumber.length() == 16) {
                return true;
            }
        }
        return false;
    }
    
}
*/
