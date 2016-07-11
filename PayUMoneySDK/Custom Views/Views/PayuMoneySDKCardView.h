//
//  CardView.h
//  payuSDK
//
//  Created by Honey Lakhani on 8/17/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayuMoneySDKDatePicker.h"
#import "PayuSDKTextField.h"
@protocol CardViewData <NSObject>
-(void)goToPayment : (NSDictionary *)cardData : (NSString *)mode;
-(void)changeTableContentOffset : (CGFloat)value;
@end
@interface PayuMoneySDKCardView : UIView <UITextFieldDelegate,DatePickerDelegate>
{
    UIImageView *imgCardIcon;
}
@property PayuMoneySDKCardView *cardView;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet PayuSDKTextField *expiryTextField;
@property int loc;
@property (weak, nonatomic) IBOutlet PayuSDKTextField *cvvTextField;

@property (weak, nonatomic) IBOutlet UIButton *payNowBtn;
@property NSString *mode;
@property (weak, nonatomic) IBOutlet UIButton *checkboxButton;
@property NSMutableArray *years;
@property id<CardViewData> cardViewDelegate;
- (IBAction)checkBoxBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *cardLabelTextField;
- (IBAction)payNowBtnClicked:(UIButton *)sender;

@property UIPickerView *date;
@property NSArray *months;

-(PayuMoneySDKCardView *)initWithFrame:(CGRect)frame withDelegate:(id)callBack;

@end
