 //
//  LoginView.m
//  PayU SDK
//
//  Created by Honey Lakhani on 10/14/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import "PayuMoneySDKLoginView.h"
#import "PayuMoneySDKValidations.h"
#import "UITextField+Keyboard.h"
#import "PayuMoneySDKLoginService.h"
#define kgenericTag 888
@implementation PayuMoneySDKLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
int currentExpandedSection,notExpandable = -1;
UITextField *activeTextField,*currentTextField;
PayuMoneySDKSession *session;
CGFloat loc;
-(PayuMoneySDKLoginView *)initWithFrame : (CGRect)frame withArray : (NSArray *)cellArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.loginView = [[[NSBundle mainBundle]loadNibNamed:@"PayuMoneySDKLoginView" owner:self options:nil]firstObject];
        self.loginView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        if(CGRectIsEmpty(frame))
            self.bounds = self.loginView.bounds;
    
        [self addSubview:self.loginView];
       // [self registerForKeyboardNotifications];
       // self.emailTextField.text = @"honeylakhani@gmail.com";
        self.loginParams = cellArr;
        currentExpandedSection = -1;
//        if (self.loginParams.count == 0) {
//            [self.loginTableView setHidden:YES];
//            UITextField *passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.emailTextField.frame.origin.x, self.emailTextField.frame.origin.y + self.emailTextField.frame.size.height  +30,self.emailTextField.frame.size.width, self.emailTextField.frame.size.height)];
//            [self.loginView addSubview:passwordTextField];
//            passwordTextField.placeholder = @"Password";
//            passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
//        }
       // activeTextField.text = @"";
    }
      return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return self.loginParams.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40.0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    UIView *vwHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    
    if(section == self.loginParams.count)
    {
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame = CGRectMake(vwHeader.frame.size.width/2 - 30, 10, 60, 30);
        [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(loginViewBtnClicked :) forControlEvents:1];
        [vwHeader addSubview:loginBtn];
    }
    else
    {
        //vwHeader.backgroundColor = [UIColor lightGrayColor];
    UIButton *btnExpand = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnExpand setBackgroundImage:[UIImage imageNamed:@"unselectedradio"] forState:UIControlStateNormal];
    [btnExpand setBackgroundImage:[UIImage imageNamed:@"selectedradio"] forState:UIControlStateSelected];
    btnExpand.frame = CGRectMake(10, 10, 25, 25);
    btnExpand.tag = kgenericTag+section;
    [btnExpand addTarget:self action:@selector(btnExpandClicked:) forControlEvents:1];
    [vwHeader addSubview:btnExpand];
    
    UILabel *lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, vwHeader.frame.size.width-20, vwHeader.frame.size.height)];
    lblHeaderTitle.text = self.loginParams[section];
        if ([lblHeaderTitle.text isEqual:@"Guest Login"]) {
            notExpandable = section;
        }
    lblHeaderTitle.textColor = [UIColor blackColor];
    lblHeaderTitle.font = [UIFont systemFontOfSize:15.0];
    [vwHeader addSubview:lblHeaderTitle];
    lblHeaderTitle = nil;
    
  
    btnExpand.selected = currentExpandedSection == section;
    }
    return vwHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        if(indexPath.row==  rowExpanded)
//            return 150.0f;
//        else
//            return 100.0f;
//    }
    if ([self.loginParams[indexPath.section] isEqual:@"Login With Password"]) {
        return 80.0f;
    }
    return 50.0f;
    
    //    if (indexPath.row == rowExpanded) {
    //        return 300.0f;
    //    }
    //    else
    //        return 50.0f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(currentExpandedSection == section && currentExpandedSection != notExpandable)
        return 1;
return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(5, 10, cell.frame.size.width - 20, cell.frame.size.height - 20)];
   // textField.placeholder = @"enter";
    textField.delegate = self;
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
     [cell.contentView addSubview:textField];
    if ([self.loginParams[indexPath.section] isEqual:@"Login With Password"]) {
        textField.secureTextEntry = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"Forgot Password" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //[btn setBackgroundColor:[UIColor blackColor]];
        [btn setTag:1000];
        [btn addTarget:self action:@selector(forgotPassBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(cell.frame.size.width/2 - 100, textField.frame.origin.y + textField.frame.size.height + 3, 200, 30)];
        [cell.contentView addSubview:btn];
    }
    loc = self.superview.frame.origin.y +self.loginTableView.frame.origin.y + textField.frame.size.height + ((indexPath.section + 1) * 50) + textField.frame.origin.y;
    textField.borderStyle = UITextBorderStyleRoundedRect;

   
    cell.clipsToBounds = YES;
    return cell;
}
-(void)btnExpandClicked : (UIButton *)sender
{
    currentExpandedSection = (int) sender.tag - kgenericTag;
    
    if(sender.selected){
        currentExpandedSection = -1;
    }
    else{
        sender.selected = !sender.selected;
        if([[self.loginParams objectAtIndex:currentExpandedSection]isEqual:@"Login with OTP"])
        {
            if ([self.emailTextField hasText]) {
                session =[PayuMoneySDKSession sharedSession];
                session.delegate = self;
            [session fetchResponsefrom:OTP_URL isPost:YES body:[PayuMoneySDKServiceParameters prepareBodyForOTP:self.emailTextField.text] tag:SDK_REQUEST_OTP isAccessTokenRequired:NO];
                
        }
            else
            {
                ALERT(@"Email not entered", @"Please enter email");
                currentExpandedSection = -1;
                
            }
        }
        
    }
   
  
    [self.loginTableView reloadData];
}
-(void)sendResponse:(NSDictionary *)responseDict tag:(SDK_REQUEST_TYPE)tag error:(NSError *)err
{
    session.delegate = nil;
    session = nil;
[PayuMoneySDKAppConstant hideLoader];
    if (err)
    {
//        NSLog(@"%@",err.localizedDescription);
//        if ([err.localizedDescription isEqualToString:@"The operation couldn’t be completed."])
//        {
            ALERT(@"Server Timed Out", @"Try again");
        //}
    }
   else if (tag == SDK_REQUEST_OTP)
    {
        if ([[responseDict valueForKey:@"status"] isEqual:[NSNumber numberWithLong:0]]) {
            ALERT(@"OTP sent to you device", @"please enter OTP");
        }
        else
        ALERT(@"OTP sending Failed", @"Please try again");
    }
    else if (tag == SDK_REQUEST_FORGOT_PASSWORD)
    {
        if ([[responseDict valueForKey:@"status"]isEqual:[NSNumber numberWithLong:0]] && [[responseDict valueForKey:@"message"] isEqual:@"Mail sent"]) {
            ALERT(@"Mail sent to your email id", @"");
        }
        else if ([[responseDict valueForKey:@"message"]isEqualToString:@"User not found"])
        {
            ALERT(@"Invalid User", @"Please enter proper email id");
        }
    }
    
}

-(void)loginViewBtnClicked : (UIButton *)sender
{
    if ([self.emailTextField hasText] && [currentTextField hasText])
    {
        if(![PayuMoneySDKValidations matchRegex:EMAIL_REGEX :self.emailTextField.text])
        {
            ALERT(@"Invalid Email", @"please enter valid email address");
            return;
        }

//    session =[Session sharedSession];
//    session.delegate = self;
        if (SDK_APP_CONSTANT.isServerReachable) {
           
        [PayuMoneySDKAppConstant showLoader_OnView:self];
        PayuMoneySDKLoginService *loginService = [[PayuMoneySDKLoginService alloc]init];
        loginService.delegate = self;
        [loginService hitLoginApi:self.emailTextField.text :currentTextField.text];
        }
       else
       {
           ALERT(@"Internet not connected", @"Please connect");
       }

  //  [session fetchResponsefrom:Login_URL isPost:YES body:[ServiceParameters preparePostBodyForLogin:self.emailTextField.text withPassword:activeTextField.text] tag:REQUEST_LOGIN isAccessTokenRequired:NO];
    }
    else
    ALERT(@"one of field is missing", @"please enter all fields");
   // currentTextField.text = @"";
    //currentTextField = nil;
}
-(void)sendingResponseBack : (NSString *)msg
{
    if ([msg isEqual:@"success"]) {
        [SDK_APP_CONSTANT.keyChain setObject:self.emailTextField.text forKey:(__bridge id)kSecAttrAccount];
        [SDK_APP_CONSTANT.keyChain setObject:activeTextField.text forKey:(__bridge id)kSecValueData];
    }
    if (self.logindelegate != nil && [self.logindelegate respondsToSelector:@selector(goBackToController:)]) {
        
        [self.logindelegate goBackToController:msg];
    }
}
-(void)changeTableContentOffset : (CGFloat)value
{
    [self.loginTableView setContentOffset:CGPointMake(0, value)];
}

-(void)forgotPassBtnClicked:(UIButton *)sender
{
    if ([self.emailTextField hasText]) {
        if (SDK_APP_CONSTANT.isServerReachable) {
            
        
        session = [PayuMoneySDKSession sharedSession];
        session.delegate = self;
        
        [session fetchResponsefrom:Forgot_Password_URL isPost:YES body:[PayuMoneySDKServiceParameters prepareBodyForForgotPassword:self.emailTextField.text] tag:SDK_REQUEST_FORGOT_PASSWORD isAccessTokenRequired:NO];
        }
        else
        {
            ALERT(@"Internet not connected", @"Please connect");
        }
    }
    else
    {
        ALERT(@"Please enter email id", @"");
    }
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
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (activeTextField != self.emailTextField) {
        
    
    
   [self changeTableContentOffset :[activeTextField checkForKeyboard:activeTextField.frame.origin.y + loc withTextFieldHeight:activeTextField.frame.size.height withNotification :aNotification]];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if (activeTextField != self.emailTextField) {
        
    
        [self changeTableContentOffset : 0.0f];
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField != self.emailTextField) {
        
    
        currentTextField = textField;
    }
     activeTextField = textField;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
  // activeTextField = nil;
    return YES;
}
-(void)removeNotifications
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.loginTableView = nil;
    activeTextField.text = @"";
    activeTextField = nil;
    currentTextField.text = @"";
    currentTextField = nil;
}


@end
