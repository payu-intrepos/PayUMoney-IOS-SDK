
#import "PayuMoneySDKSavedCardCvv.h"
#import "UITextField+Keyboard.h"
@interface PayuMoneySDKSavedCardCvv()
{
    UITextField *activeField;
}
@end
@implementation PayuMoneySDKSavedCardCvv


-(PayuMoneySDKSavedCardCvv *)initWithFrame : (CGRect)frame withCardType : (NSString *)type
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.cvv = [[[NSBundle mainBundle]loadNibNamed:@"PayuMoneySDKSavedCardCvv" owner:self options:nil]firstObject];
        self.cvv.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        if(CGRectIsEmpty(frame))
            self.bounds = self.cvv.bounds;
        
    }
    [self.cvv setBackgroundColor:[UIColor whiteColor]];
    self.cvv.layer.cornerRadius = 3.0;
    self.cvv.clipsToBounds = YES;
    self.cvvTextField.delegate = self;
    [self addSubview:self.cvv];
    self.cvv.payBtn.layer.cornerRadius = 3.0;
    
    [self.cvv.payBtn setTitleColor:SDK_WHITE_COLOR forState:UIControlStateNormal];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
   // numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    self.cvvTextField.inputAccessoryView = numberToolbar;
    self.cardType = type;
    if ([self.cardType isEqualToString:@"MAES"]) {
        [self.cvvTextField setPlaceholder:@"Optional"];
        [PayuMoneySDKAppConstant setSDKButtonEnabled:self.cvv.payBtn];
        
    }
    else
        [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.cvv.payBtn];
//    [self.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.payBtn.userInteractionEnabled = NO;
    


    [self registerForKeyboardNotifications];
    return self;
}
-(void)cancelNumberPad{
    [self.cvvTextField resignFirstResponder];
    self.cvvTextField.text = @"";
    if ([self.cardType isEqualToString:@"MAES"]) {
        [self.cvvTextField setPlaceholder:@"Optional"];
        [PayuMoneySDKAppConstant setSDKButtonEnabled:self.cvv.payBtn];
        
    }
    else
        [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.cvv.payBtn];
}

-(void)doneWithNumberPad{
    
    [self.cvvTextField resignFirstResponder];
    if ([self.cvvTextField hasText]) {
        [PayuMoneySDKAppConstant setSDKButtonEnabled:self.cvv.payBtn];
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    activeField = nil;
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
     NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    if (range.length == 0 && range.location == 0 && [newString isEqualToString:@"0"]) {
//        return NO;
//    }
//    else
    if(newString.length == self.cvvLen)
        [PayuMoneySDKAppConstant setSDKButtonEnabled:self.cvv.payBtn];
        return (newString.length <= self.cvvLen);
}
-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardShown : (NSNotification *)notification
{
   // [activeField checkForKeyboardwithTextFieldForSuperView:activeField withView:self.superview withNotification:notification];
   // [activeField checkForKeyboardwithTextField:activeField withView:self withNotification:notification];
    [activeField checkForKeyboardForSavedCardwithTextField:activeField withView:self withNotification:notification];
}
-(void)keyboardHide : (NSNotification *)notification
{
    [activeField keyboardHideWithTextFieldwithView:activeField withNotification:notification withView:self];
}
- (IBAction)payBtnClicked:(UIButton *)sender {
    if (![self.cardType isEqualToString:@"MAES"]) {
        
        if(![self.cvvTextField hasText])
        {
            ALERT(@"please enter cvv first", @"");
            return;
        }
    }
    
    if ([self.cvvTextField hasText] && [self.cvvTextField.text length] < self.cvvLen)
    {
        ALERT(@"Incomplete CVV", @"Please enter complete cvv");
        return;
    }
    
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(payBtnClicked :index:)])
    {
       
        [self.delegate payBtnClicked : self.cvvTextField.text index : self.index];
    }
    
    
    //    else
    //    {
    //        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(payBtnClicked :index:)])
    //        {
    //            [self.delegate payBtnClicked : self.cvvTextField.text index : self.index];
    //        }
    //    }
}

- (IBAction)viewDetailsBtnClicked:(UIButton *)sender {
    [self removeFromSuperview];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
