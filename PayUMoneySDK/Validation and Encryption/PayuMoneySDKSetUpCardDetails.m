//
//  SetUpCardDetails.m
//  payuSDK
//
//  Created by Honey Lakhani on 8/21/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKSetUpCardDetails.h"

@implementation PayuMoneySDKSetUpCardDetails

+(NSString *)findIssuer : (NSString *)number : (NSString *)cardMode
{
    if(number.length > 5)
    {
        if ([self matchRegex:@"^(4026|417500|4508|4844|491(3|7))[\\d|\\D]+" :number]) {
            return @"VISA";
        }
       else if ([number characterAtIndex:0] == '4' ) {
            
            return @"VISA";
        }
        else if ([[NSArray arrayWithObjects:@"6304",@"6706",@"6771",@"6709", nil] containsObject:[number substringWithRange: NSMakeRange(0, 4)]])
            return @"LASER";
        else if ([self matchRegex:@"^(508[5-9][0-9][0-9])|(60698[5-9])|(60699[0-9])|(607[0-8][0-9][0-9])|(6079[0-7][0-9])|(60798[0-4])|(608[0-4][0-9][0-9])|(608500)|(6528[5-9][0-9])|(6529[0-9][0-9])|(6530[0-9][0-9])|(6531[0-4][0-9])|(6521[5-9][0-9])|(652[2-7][0-9][0-9])|(6528[0-4][0-9])" :[number substringWithRange:NSMakeRange(0,6)]])
            return @"RUPAY";
        else if ([self matchRegex : @"(5[06-8]|6\\d|\\D)\\d{14}|\\D{14}(\\d{2,3}|\\D{2,3})?[\\d|\\D]+" : number] || [self matchRegex : @"(5[06-8]|6\\d|\\D)[\\d|\\D]+" : number] || [self matchRegex : @"((504([435|645|774|775|809|993]))|(60([0206]|[3845]))|(622[018])\\d|\\D)[\\d|\\D]+" : number] )
            return @"MAES";
        else if ([self matchRegex:@"^5[1-5][\\d|\\D]+" :number])
            return @"MAST";
        else if ([self matchRegex:@"^3[47][\\d|\\D]+" :number])
            return @"AMEX";
        else if ([[number substringWithRange:NSMakeRange(0, 2)]isEqual:@"36"] || [self matchRegex:@"^30[0-5][\\d|\\D]+" :number])
            return @"DINR";
        else if ([self matchRegex:@"^30[0-5][\\d|\\D]+" :number])
            return @"DINR";
        else if ([self matchRegex:@"^35(2[89]|[3-8][0-9])[\\d|\\D]+" :number])
            return @"JCB";
        
        else
        {
            if([cardMode isEqual:@"CC"])
                return @"CC";
            else if ([cardMode isEqual:@"DC"])
                return @"DC";
        }
    }
    return @"";
}
+(NSUInteger)matchRegex : (NSString *)regex : (NSString *)number
{
//    NSError *err = NULL;
//    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:&err];
//  //  NSUInteger noOfMatches = [exp numberOfMatchesInString:number options:0 range:NSMakeRange(0, number.length)];
//    
//    NSRange rangeOfFirstMatch = [exp rangeOfFirstMatchInString:number options:0 range:NSMakeRange(0, [number length])];
//    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
//      //  NSString *substringForFirstMatch = [number substringWithRange:rangeOfFirstMatch];
//               if(rangeOfFirstMatch.length == number.length)
//            return 1;
//    }
//    return 0;
   // NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *cardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [cardTest evaluateWithObject:number];
}



+(UIImage *)getCardDrawable : (NSString *)number
{
    UIImage *cardimage;
    cardimage = [UIImage imageNamed:@"card.png"];
    
//    if(number.length > 3)
//    {
        if ([number characterAtIndex:0] == '4' ) {
            return [UIImage imageNamed:@"card_visa.png"];
        }
        else if ([[NSArray arrayWithObjects:@"6304",@"6706",@"6771",@"6709", nil] containsObject:[number substringWithRange: NSMakeRange(0, 4)]])
            return [UIImage imageNamed:@"card_laser.png"];
    else if ([self matchRegex:@"6(?:011|5[0-9]{2})[0-9]{12}[\\d]+" :number])
     
        return [UIImage imageNamed:@"card_discover.png"];
    
    else if ([self matchRegex:@"(?!608000)(^(508[5-9][0-9][0-9])|(60698[5-9])|(60699[0-9])|(607[0-8][0-9][0-9])|(6079[0-7][0-9])|(60798[0-4])|(608[0-4][0-9][0-9])|(608500)|(6528[5-9][0-9])|(6529[0-9][0-9])|(6530[0-9][0-9])|(6531[0-4][0-9])|(6521[5-9][0-9])|(652[2-7][0-9][0-9])|(6528[0-4][0-9]))" :[number substringWithRange:NSMakeRange(0,6)]])
        return [UIImage imageNamed:@"card_rupay.png"];
    else if ([self matchRegex : @"(5[06-8]|6\\d|\\D)\\d{14}|\\D{14}(\\d{2,3}|\\D{2,3})?[\\d|\\D]+" : number] || [self matchRegex : @"(5[06-8]|6\\d|\\D)[\\d|\\D]+" : number] || [self matchRegex : @"((504([435|645|774|775|809|993]))|(60([0206]|[3845]))|(622[018])\\d|\\D)[\\d|\\D]+" : number] )
               return [UIImage imageNamed:@"card_maestro.png"];

        else if ([self matchRegex:@"^5[1-5][\\d|\\D]+" :number])
            return [UIImage imageNamed:@"card_master.png"];
        else if ([self matchRegex:@"^3[47][\\d|\\D]+" :number])
            return [UIImage imageNamed:@"card_amex.png"];
        else if ([[number substringWithRange:NSMakeRange(0, 2)]isEqual:@"36"] || [self matchRegex:@"^30[0-5][\\d|\\D]+" :number])
            return [UIImage imageNamed:@"card_diner.png"];
        else if ([self matchRegex:@"2(014|149)[\\d|\\D]+" :number])
            return [UIImage imageNamed:@"crad_diner.png"];
        else if ([self matchRegex:@"^35(2[89]|[3-8][0-9])[\\d|\\D]+" :number])
            return [UIImage imageNamed:@"card_jcb.png"];
        
//        else
//        {
//            if([cardMode isEqual:@"CC"])
//                return @"CC";
//            else if ([cardMode isEqual:@"DC"])
//                return @"DC";
//        }
   // }
    return cardimage;
}



@end


//
//
//public static String findIssuer(String mNumber, String cardMode) {
//    if (mNumber.length() > 3) {
//        if (mNumber.startsWith("4")) {
//            return "VISA";
//        } else if (Arrays.asList("6304", "6706", "6771", "6709").contains(mNumber.substring(0, 4))) {
//            return "LASER";
//        }/* else if(mNumber.matches("6(?:011|5[0-9]{2})[0-9]{12}[\\d]+")) {
//          return "DISCOVER";
//          }*/ else if (mNumber.matches("(5[06-8]|6\\d|\\D)\\d{14}|\\D{14}(\\d{2,3}|\\D{2,3})?[\\d|\\D]+") || mNumber.matches("(5[06-8]|6\\d|\\D)[\\d|\\D]+") || mNumber.matches("((504([435|645|774|775|809|993]))|(60([0206]|[3845]))|(622[018])\\d|\\D)[\\d|\\D]+")) {
//              return "MAES";
//          } else if (mNumber.matches("^5[1-5][\\d|\\D]+")) {
//              return "MAST";
//          } else if (mNumber.matches("^3[47][\\d|\\D]+")) {
//              return "AMEX";
//          } else if (mNumber.startsWith("36") || mNumber.matches("^30[0-5][\\d|\\D]+")) {
//              return "DINR";
//          } else if (mNumber.matches("2(014|149)[\\d|\\D]+")) {
//              return "DINR";
//          } else if (mNumber.matches("^35(2[89]|[3-8][0-9])[\\d|\\D]+")) {
//              return "JCB";
//          } else {
//              if (cardMode.contentEquals("CC"))
//                  return "CC";
//              else if (cardMode.contentEquals("DC"))
//                  return "MAST";
//          }
//    }
//    return null;
//}
//
//public static Drawable getCardDrawable(Resources resources, String mNumber) {
//    
//    Drawable amexDrawable = resources.getDrawable(R.drawable.amex);
//    Drawable dinerDrawable = resources.getDrawable(R.drawable.diner);
//    Drawable maestroDrawable = resources.getDrawable(R.drawable.maestro);
//    Drawable masterDrawable = resources.getDrawable(R.drawable.master);
//    Drawable visaDrawable = resources.getDrawable(R.drawable.visa);
//    Drawable jcbDrawable = resources.getDrawable(R.drawable.jcb);
//    Drawable laserDrawable = resources.getDrawable(R.drawable.laser);
//    Drawable discoverDrawable = resources.getDrawable(R.drawable.discover);
//    Drawable cardsDrawable = resources.getDrawable(R.drawable.card);
//    
//    if (mNumber.startsWith("4")) {
//        return visaDrawable;
//    } else if (Arrays.asList("6304", "6706", "6771", "6709").contains(mNumber.substring(0, 4))) {
//        //Laser
//        return laserDrawable;
//    } else if (mNumber.matches("6(?:011|5[0-9]{2})[0-9]{12}[\\d|\\D]+")) {
//        //Discover
//        return discoverDrawable;
//    } else if (mNumber.matches("(5[06-8]|6\\d|\\D)\\d{14}|\\D(\\d{2,3}|\\D{2,3})?[\\d|\\D]+") || mNumber.matches("(5[06-8]|6\\d|\\D)[\\d|\\D]+") || mNumber.matches("((504([435|645|774|775|809|993]))|(60([0206]|[3845]))|(622[018])\\d|\\D)[\\d|\\D]+")) {
//        return maestroDrawable;
//    } else if (mNumber.matches("^5[1-5][\\d|\\D]+")) {
//        return masterDrawable;
//    } else if (mNumber.matches("^3[47][\\d|\\D]+")) {
//        return amexDrawable;
//    } else if (mNumber.startsWith("36") || mNumber.matches("^30[0-5][\\d|\\D]+")) {
//        return dinerDrawable;
//    } else if (mNumber.matches("2(014|149)[\\d|\\D]+")) {
//        return dinerDrawable;
//    } else if (mNumber.matches("^35(2[89]|[3-8][0-9])[\\d|\\D]+")) {
//        return jcbDrawable;
//    }
//    return cardsDrawable;
//}
//
//public static DatePickerDialog customDatePicker(Activity activity, DatePickerDialog.OnDateSetListener mDateSetListener, int mYear, int mMonth, int mDay) {
//    DatePickerDialog dpd = new DatePickerDialog(activity, mDateSetListener, mYear, mMonth, mDay);
//    //        dpd.getDatePicker().setMinDate(new Date().getTime() - 1000);
//    if (Build.VERSION.SDK_INT >= 11) {
//        dpd.getDatePicker().setMinDate(System.currentTimeMillis() - 1000);
//    }
//    try {
//        Field[] datePickerDialogFields = dpd.getClass().getDeclaredFields();
//        for (Field datePickerDialogField : datePickerDialogFields) {
//            if (datePickerDialogField.getName().equals("mDatePicker")) {
//                datePickerDialogField.setAccessible(true);
//                DatePicker datePicker = (DatePicker) datePickerDialogField.get(dpd);
//                Field datePickerFields[] = datePickerDialogField.getType().getDeclaredFields();
//                for (Field datePickerField : datePickerFields) {
//                    if ("mDayPicker".equals(datePickerField.getName()) || "mDaySpinner".equals(datePickerField.getName())) {
//                        datePickerField.setAccessible(true);
//                        ((View) datePickerField.get(datePicker)).setVisibility(View.GONE);
//                    }
//                }
//            }
//        }
//    } catch (Exception ex) {
//    }
//    dpd.setTitle(null);
//    return dpd;
//}
//
//}
