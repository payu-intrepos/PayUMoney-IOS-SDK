//
//  NetBanking.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/16/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKNetBanking.h"

#import "UITextField+Keyboard.h"
@interface PayuMoneySDKNetBanking()<UIPickerViewDataSource,UIPickerViewDelegate>
{
   
    NSArray *bankArray;
    NSString *bankcode;
    CGFloat value;
    UIPickerView *bankPicker;
}
@end
@implementation PayuMoneySDKNetBanking
bool var = false;


-(PayuMoneySDKNetBanking *)initWithList:(NSArray *)bankArrayList withFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
   bankArray = bankArrayList;

    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    //numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    self.selectBankTextField.inputAccessoryView = numberToolbar;
    [self.nbView.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nbView.payBtn.layer.cornerRadius = 3.0;
    bankPicker = [[UIPickerView alloc]init];
    bankPicker.delegate = self;
    bankPicker.dataSource = self;\
    bankPicker.showsSelectionIndicator = YES;
    if (bankArrayList.count) {
        
    
    self.selectBankTextField.inputView = bankPicker;
    }
    else
        ALERT(@"There are currently no banks available", @"");
   [self.selectBankTextField setTintColor:[UIColor clearColor]];
    [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.nbView.payBtn];
    [self registerForKeyboardNotifications];
    return self;
}



-(PayuMoneySDKNetBanking *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.nbView = [[[NSBundle mainBundle]loadNibNamed:@"PayuMoneySDKNetBanking" owner:self options:nil]firstObject];
        self.nbView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        if (CGRectIsEmpty(frame)) {
            self.bounds = self.nbView.bounds;
        }
        [self addSubview:self.nbView];
        
    }
    return self;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return bankArray.count/2;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return bankArray[2 * row + 1];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.font = [UIFont systemFontOfSize:16];
        
        pickerLabel.textAlignment=NSTextAlignmentCenter;
    }
    [pickerLabel setText:[bankArray objectAtIndex:2 * row + 1]];
    
    return pickerLabel;
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
   
    if(self.nbDelegate != nil && [self.nbDelegate respondsToSelector:@selector(changeTableContentOffset:)])
    {
        
        value = [self.selectBankTextField checkForKeyboard:self.selectBankTextField.frame.origin.y + self.loc withTextFieldHeight:self.selectBankTextField.frame.size.height withNotification :aNotification];
        [self.nbDelegate changeTableContentOffset :value];
    }
   
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
       if(self.nbDelegate != nil && [self.nbDelegate respondsToSelector:@selector(changeTableContentOffset:)])
    {
              [self.nbDelegate changeTableContentOffset : 0.0f];
        value = 0.0f;
    }
}
-(void)cancelNumberPad{
    [self.selectBankTextField resignFirstResponder];
    self.selectBankTextField.text = @"";
    [PayuMoneySDKAppConstant setSDKButtonDisbaled:self.nbView.payBtn];
 }

-(void)doneWithNumberPad{
    self.selectBankTextField.text = [bankArray objectAtIndex:2 * [bankPicker selectedRowInComponent:0] + 1];
  
    [self.selectBankTextField resignFirstResponder];
    [PayuMoneySDKAppConstant setSDKButtonEnabled:self.nbView.payBtn];
}

- (IBAction)payNowBtnClicked:(UIButton *)sender {
    //NSLog(@"%@",self.selectBankTextField.text);
    if (![self.selectBankTextField.text isEqual:@""]) {
        
    
    if(self.nbDelegate != nil && [self.nbDelegate respondsToSelector:@selector(dataFromNetBankingwithMode : withData:)])
    {
        NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
        [data setValue:[bankArray objectAtIndex:2 * [bankPicker selectedRowInComponent:0]] forKey:@"bankcode"];
        [self.nbDelegate goToPayment:data : @"NB"];
    }
    }
    else
        ALERT(@"Bank not selected", @"Please select bank first");
}
@end
