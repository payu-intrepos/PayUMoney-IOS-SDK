//
//  CardView.m
//  payuSDK
//
//  Created by Honey Lakhani on 8/17/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKCardView.h"
#import "PayuMoneySDKSetUpCardDetails.h"
#import "PayuMoneySDKLuhn.h"
#import "PayuMoneySDKDatePicker.h"
#import "UITextField+Keyboard.h"
@interface PayuMoneySDKCardView()
{
    UITextField *activeTextField;
    CGFloat value;
    NSString *cardType;
    int cvvLen;
}
@end
@implementation PayuMoneySDKCardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)awakeFromNib
//{
//    [self registerForKeyboardNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeFor:) name:UITextFieldTextDidChangeNotification object:nil];
//}


PayuMoneySDKDatePicker *datePicker;
bool isCardValidated;
NSInteger i,x;


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.cardNumberTextField ){
        if (isCardValidated == false && ![self.cardNumberTextField.text isEqual:@""])
    {
        imgCardIcon.image = [UIImage imageNamed:@"action_close"];
        imgCardIcon.contentMode = UIViewContentModeScaleAspectFit;
        [imgCardIcon setNeedsDisplay];

    }
        else if (isCardValidated == true && [cardType isEqualToString:@"MAES"] )
        {
            [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];
//            [self.payNowBtn setUserInteractionEnabled:YES];
            self.expiryTextField.placeholder = @"Optional";
            self.cvvTextField.placeholder = @"Optional";
        }
        else
        {
            
            [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.payNowBtn];

            self.expiryTextField.placeholder = @"Expiry";
            self.cvvTextField.placeholder = @"CVV";

        }
    }
//    else if (textField == self.expiryTextField)
//    {
//        if ([self.cardNumberTextField hasText] && isCardValidated && [self.expiryTextField hasText] && [self.cvvTextField hasText]) {
//             [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];
//            
//        }
//        else
//             [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.payNowBtn];
//    }
    if((![self.cardNumberTextField.text isEqual:@""] ) && (![self.expiryTextField.text isEqual:@""] ) && (self.cvvTextField.text.length == cvvLen) && isCardValidated == true && ![cardType isEqualToString:@"MAES"]){
        [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];

    }
    else if(isCardValidated && [cardType isEqualToString:@"MAES"] )
    {
        if ([self.cvvTextField hasText] && self.cvvTextField.text.length == cvvLen && [self.expiryTextField hasText]) {
            [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];
        }
        else if(![self.cvvTextField hasText] && ![self.expiryTextField hasText])
        [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];
        else
          [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.payNowBtn];
    }
    else{
        [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.payNowBtn];
    }
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
      //activeTextField = nil;
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardWillHideNotification object:nil];

    [textField resignFirstResponder];
     return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeTextField = textField;
//    if (textField == self.cardNumberTextField)
//    {
//         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UITextFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
//    }
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardDidShowNotification object:nil];
    

   
    
}
- (void)registerForKeyboardNotifications
{

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];

}

-(void)removeFromSuperview
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
//    NSDictionary* info = [aNotification userInfo];
//    CGRect kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//
//
//    CGPoint pt = activeTextField.frame.origin;
//    //NSLog(@"==================== %ld",(long)self.loc);
//    pt.y += self.loc;
//    if (pt.y + activeTextField.frame.size.height >= kbSize.origin.y  - kbSize.size.height) {
        if(self.cardViewDelegate != nil && [self.cardViewDelegate respondsToSelector:@selector(changeTableContentOffset:)])
        {
//            [[NSNotificationCenter defaultCenter]removeObserver:self];
            //NSLog(@"%f======",activeTextField.bounds.origin.y);
        CGFloat value1 = value;
        value = [activeTextField checkForKeyboard:activeTextField.frame.origin.y + self.loc withTextFieldHeight:activeTextField.frame.size.height withNotification :aNotification];
            // [activeTextField checkForKeyboardwithTextField:activeTextField withView:self.superview withNotification:aNotification];
            
            [self.cardViewDelegate changeTableContentOffset :value];
        }
  // }
   // }

}


// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
    
    if(self.cardViewDelegate != nil && [self.cardViewDelegate respondsToSelector:@selector(changeTableContentOffset:)])
    {
//                    [[NSNotificationCenter defaultCenter]removeObserver:self];
        [self.cardViewDelegate changeTableContentOffset : 0.0f];
        value = 0.0f;
    }
}

- (void)textDidChangeFor:(NSNotification*)notification
{
    UITextField *textField = notification.object;
    
        if(textField == self.cardNumberTextField)
        {
    if ([Luhn validate:textField.text] && textField.text.length > 11) {
        cardType =  [PayuMoneySDKSetUpCardDetails findIssuer:self.cardNumberTextField.text :self.mode];
        
        imgCardIcon.image = [PayuMoneySDKSetUpCardDetails getCardDrawable:textField.text];
        self.cardNumberTextField.rightViewMode = UITextFieldViewModeAlways;
        
//        self.cardImageView .image =  [SetUpCardDetails getCardDrawable:textField.text];
//        self.cardImageView.clipsToBounds = YES;
        imgCardIcon.contentMode = UIViewContentModeScaleAspectFill;
        isCardValidated = true;
        if ([cardType isEqualToString:@"AMEX"]) {
            cvvLen = 4;
        }
        else
                {
                    cvvLen = 3;
                 }
        
       
        
    }
    else{
       // self.cardNumberTextField.rightViewMode = UITextFieldViewModeNever;
        imgCardIcon.image = [UIImage imageNamed:@"mycards_small"];
        
        
        //        self.cardImageView .image =  [SetUpCardDetails getCardDrawable:textField.text];
        //        self.cardImageView.clipsToBounds = YES;
        imgCardIcon.contentMode = UIViewContentModeScaleAspectFit;
        isCardValidated = false;

    }
            if (isCardValidated && [self.expiryTextField hasText] && [self.cvvTextField hasText]) {
                [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];
            }
            else if([cardType isEqualToString:@"MAES"] && isCardValidated)
            [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];
            else
                [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.payNowBtn];
        }
  
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.cardNumberTextField) {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return newString.length <=19;
    }
    
    if(textField == self.cvvTextField && ![cardType isEqualToString:@"MAES"])
    {
         NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
       // //NSLog(@"starting ========= %@",[self.cardNumberTextField.text substringWithRange:NSMakeRange(0, 2)]);
        //NSLog(@"%@",self.cardNumberTextField.text);
        if(![self.cardNumberTextField.text isEqual:@""])
        {
    if([[self.cardNumberTextField.text substringWithRange:NSMakeRange(0, 2)] isEqual:@"34"] || [[self.cardNumberTextField.text substringWithRange:NSMakeRange(0, 2)] isEqual:@"37"])
    {
        cvvLen = 4;
        if(newString.length >= cvvLen &&  (![self.cardNumberTextField.text isEqual:@""] ) && (![self.expiryTextField.text isEqual:@""] ) && (![self.cvvTextField.text isEqual:@""] ) && isCardValidated == YES)
        {
            //[self.payNowBtn setUserInteractionEnabled:YES];
            [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];
        }
        else
        {
            //[self.payNowBtn setUserInteractionEnabled:NO];
            [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.payNowBtn];
        }
        return (newString.length <= 4);
        
    }
        else
        {
            cvvLen = 3;
            // NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            if(newString.length >= 3 &&  (![self.cardNumberTextField.text isEqual:@""] ) && (![self.expiryTextField.text isEqual:@""] ) && (![self.cvvTextField.text isEqual:@""] ) && isCardValidated == YES)
            {
                //[self.payNowBtn setUserInteractionEnabled:YES];
                [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];
            }
            else
            {
                [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.payNowBtn];
                //[self.payNowBtn setUserInteractionEnabled:NO];
            }

            return (newString.length < 4);
        }
        }
        else
            if(newString.length >= 3 &&  (![self.cardNumberTextField.text isEqual:@""] ) && (![self.expiryTextField.text isEqual:@""] ) && (![self.cvvTextField.text isEqual:@""] ) && isCardValidated == YES)
            {
                //[self.payNowBtn setUserInteractionEnabled:YES];
                [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];

            }
            else
            {
                //[self.payNowBtn setUserInteractionEnabled:NO];
                [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.payNowBtn];

            }
        return (newString.length < 4);
    }
    else if(textField == self.cvvTextField && [cardType isEqualToString:@"MAES"])
    {
        cvvLen = 3;
         NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        [PayuMoneySDKAppConstant setSDKButtonEnabled:self.payNowBtn];
        return newString.length <=3;
    }
        
    return 20;
    
}
//
-(void)btnExpiryClicked
{
    datePicker = [[PayuMoneySDKDatePicker alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 216)];
    datePicker.datePickerDelegate = self;
    [datePicker setBackgroundColor:[UIColor blueColor]];
    [self addSubview:datePicker];

}

-(PayuMoneySDKDatePicker*)prepareDatePicker
{
    datePicker = [[PayuMoneySDKDatePicker alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 216)];
    datePicker.datePickerDelegate = self;
    //[datePicker setBackgroundColor:[UIColor blueColor]];
    return datePicker;
}

-(PayuMoneySDKCardView *)initWithFrame:(CGRect)frame withDelegate:(id)callBack
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.cardViewDelegate = callBack;
        self.cardView = [[[NSBundle mainBundle]loadNibNamed:@"PayuMoneySDKCardView" owner:self options:nil]firstObject];
        
        
        self.cardView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        imgCardIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mycards_small"]];
        imgCardIcon.frame = CGRectMake(0, 0, 80, 40);
        imgCardIcon.contentMode = UIViewContentModeScaleAspectFit;
        self.cardNumberTextField.rightView = imgCardIcon;
       self.cardNumberTextField.rightViewMode = UITextFieldViewModeAlways;
        self.checkboxButton.selected = YES;
        [self.cardLabelTextField setHidden:NO];
        
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar"]];
        imgView.frame = CGRectMake(0, 0, 40, 40);
        self.expiryTextField.rightView = imgView;
        self.expiryTextField.rightViewMode = UITextFieldViewModeAlways;

        self.expiryTextField.inputView = [self prepareDatePicker];
        
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
       // numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad )]];
        [numberToolbar sizeToFit];
        self.expiryTextField.inputAccessoryView = numberToolbar;
        self.cardNumberTextField.inputAccessoryView = numberToolbar;
        self.cvvTextField.inputAccessoryView = numberToolbar;
         [self.expiryTextField setTintColor:[UIColor clearColor]];
        [self.payNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.payNowBtn.layer.cornerRadius = 3.0;
        [self registerForKeyboardNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeFor:) name:UITextFieldTextDidChangeNotification object:nil];

        
        if (CGRectIsEmpty(frame)) {
            self.bounds = self.cardView.bounds;
        }
        [self addSubview:self.cardView];
    }
   
//    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar"]];
//    [self.expiryTextField.rightView addSubview:imgView];
       //[self.payNowBtn setUserInteractionEnabled: NO];
    [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.payNowBtn];

 
    self. cardNumberTextField.delegate = self;
    self.cvvTextField.delegate  = self;
    self.cardLabelTextField.delegate = self;
    // [self registerForKeyboardNotifications];
    
    //[self.cardLabelTextField setHidden:YES];
    return self;
}

-(void)cancelNumberPad{
     activeTextField.text = @"";
    [activeTextField resignFirstResponder];
   
}

-(void)doneWithNumberPad{
    
    if (activeTextField == self.expiryTextField) {
    [datePicker doneButtonPressedFromToolBar];
    }
    [activeTextField resignFirstResponder];
}



- (IBAction)checkBoxBtnClicked:(UIButton *)sender {
    //self.checkboxButton.selected = !self.checkboxButton.selected;
          self.checkboxButton.selected = !self.checkboxButton.selected;
    if(self.checkboxButton.selected)
    {
      
        [self.cardLabelTextField setHidden:NO];
    }
    else
    {
                        [self.cardLabelTextField setHidden:YES];
    }
 
        
}


- (IBAction)payNowBtnClicked:(UIButton *)sender {
    if (self.cvvTextField.text.length != cvvLen && ![cardType isEqualToString:@"MAES"]) {
        ALERT(SDK_APP_TITLE, @"Incomplete CVV");
        return;
    }
    NSMutableDictionary *cardData = [[NSMutableDictionary alloc]init];
    if([self.cvvTextField isEqual:NULL] || ![self.cvvTextField hasText])
        [cardData setValue:@"123" forKey:@"cvv"];
    else
          [cardData setValue:self.cvvTextField.text forKey:@"ccvv"];
      [cardData setValue:self.cardNumberTextField.text forKey:@"ccnum"];
           // //NSLog(@"ssssss %@", [self.expiryTextField.text substringFromIndex:[self.expiryTextField.text rangeOfString:@"/"].location + 1]);
    if (![self.expiryTextField.text isEqual:@""]) {
        
    
      [cardData setValue: [self.expiryTextField.text substringToIndex:[self.expiryTextField.text rangeOfString:@"/"].location] forKey:@"ccexpmon"];
      [cardData setValue:[self.expiryTextField.text substringFromIndex:[self.expiryTextField.text rangeOfString:@"/"].location + 1] forKey:@"ccexpyr"];
    }
    else
    {
        [cardData setValue:@"7" forKey:@"ccexpmon"];
        [cardData setValue:@"2025" forKey:@"ccexpyr"];
    }
//    if ([[SetUpCardDetails findIssuer:self.cardNumberTextField.text :self.mode] isEqual:@"AMEX"]) {
//        [cardData setValue:@"AMEX" forKey:@"bankcode"];
//    }
//    else
    NSString *tempIssuer = [PayuMoneySDKSetUpCardDetails findIssuer:self.cardNumberTextField.text :self.mode];
    
    if ([self.mode isEqualToString:@"CC"] && (![tempIssuer isEqualToString:@"/"] || ![tempIssuer isEqualToString:@"DINR"] || ![tempIssuer isEqualToString:@"CC"] || ![tempIssuer isEqualToString:@"CC-C"] || ![tempIssuer isEqualToString:@"CC-M"] || ![tempIssuer isEqualToString:@"CC-O"]))
        tempIssuer = @"CC";

    [cardData setValue:tempIssuer forKey:@"bankcode"];
    
    if(self.checkboxButton.selected)
    {
        if([self.cardLabelTextField.text isEqual:@""])
        {
            [cardData setValue:@"payu" forKey:@"card_name"];
            [cardData setValue:@"1" forKey:@"store_card"];
        }
        else
        {
            [cardData setValue:[self.cardLabelTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"card_name"];
            [cardData setValue:@"1" forKey:@"store_card"];
        }
        
    }
    ////NSLog(@" card data dict ======= %@",cardData);
//    if([self.mode isEqual:@"Credit Card"])
//        self.mode = @"CC";
//    else
//        self.mode = @"DC";
    
    if(self.cardViewDelegate != nil && [self.cardViewDelegate respondsToSelector:@selector(goToPayment : :)])
        
        [self.cardViewDelegate goToPayment:cardData :self.mode];
        
}


-(void)selectedDate : (NSString *)date
{
    self.expiryTextField.text = date;
}

@end
