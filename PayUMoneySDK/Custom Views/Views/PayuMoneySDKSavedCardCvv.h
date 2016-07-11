//
//  SavedCardCvv.h
//  payuSDK
//
//  Created by Honey Lakhani on 9/24/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayuSDKTextField.h"
@protocol SavedCardCvvDelegate < NSObject>

-(void)payBtnClicked : (NSString *)text  index : (int)index;
@end
@interface PayuMoneySDKSavedCardCvv : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet PayuSDKTextField *cvvTextField;
@property PayuMoneySDKSavedCardCvv *cvv;
@property int cvvLen;
@property NSString *cardType;
- (IBAction)payBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;


@property id<SavedCardCvvDelegate> delegate;
@property int index;
-(PayuMoneySDKSavedCardCvv *)initWithFrame : (CGRect)frame withCardType : (NSString *)type;
@end
