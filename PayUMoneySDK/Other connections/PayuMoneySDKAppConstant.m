//
//  AppConstant.m
//  PayuMoneyApp
//
//  Created by Honey Lakhani on 7/7/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKAppConstant.h"
#import "PayuMoneySDKActivityView.h"
#import "SSKeychain.h"
#import <objc/runtime.h>

//static PayuMoneySDKAppConstant *obj_AppConstants;
@implementation PayuMoneySDKAppConstant

+(PayuMoneySDKAppConstant *)sharedInstance
{
    static PayuMoneySDKAppConstant *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PayuMoneySDKAppConstant alloc] init];
       
        sharedInstance.dictCurrentTxn = [NSMutableDictionary new];
        sharedInstance.keyChain = [[PayuMoneySDKKeychainItemWrapper alloc]initWithIdentifier:SDK_keychain_id accessGroup:nil];
        [sharedInstance configureReachability];
        
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}



#pragma mark- Reachability
#pragma mark-
-(void)configureReachability
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    
    self.serverReachability = [PayuMoneySDKReachability reachabilityForInternetConnection];
    [self.serverReachability startNotifier];
    [self updateInterfaceWithReachability:self.serverReachability];
}

- (void)reachabilityChanged:(NSNotification*)note
{
    PayuMoneySDKReachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [PayuMoneySDKReachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(PayuMoneySDKReachability*)curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable:
            self.isServerReachable = NO;
            break;
        case ReachableViaWWAN:{
            self.isServerReachable = YES;
        }
            break;
        case ReachableViaWiFi:{
            self.isServerReachable = YES;
        }
            break;
    }
}


-(void)noInternetConnectionAvailable
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"You don’t have internet connection. Please check your connectivity." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
}

-(void)cancelTransactionManuallyWithRequestBody:(NSString*)reqeustBody{
    
    if(self.isServerReachable){
        PayuMoneySDKRequestManager *requestManager = [[PayuMoneySDKRequestManager alloc] init];
        [requestManager hitWebServiceForURLWithPostBlock:NO isAccessTokenRequired:NO webServiceURL:Cancel_Transaction_URL withBody:reqeustBody andTag:SDK_REQUEST_CANCEL_TXN_MANUALLY completionHandler:^(id object, SDK_REQUEST_TYPE tag, NSError *error){
            if(tag  == SDK_REQUEST_CANCEL_TXN_MANUALLY){
                if(error == nil){
                    if([object isKindOfClass:[NSDictionary class]]){
                        if([[object objectForKey:@"status"] integerValue] == 0){
                        }
                    }
                }
            }
        }];
    }
}

+ (NSString *) appVersionNew
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}
+(BOOL) validateEmail: (NSString *) strEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:strEmail];
}
+(void)setSDKButtonDisbaled:(UIButton*)btnSelected{
    [btnSelected setBackgroundColor:SDK_LIGHT_BROWN_COLOR];
    btnSelected.alpha = 0.9;
    btnSelected.enabled = NO;
}

+(void)setSDKButtonEnabled:(UIButton*)btnSelected{
    [btnSelected setBackgroundColor:SDK_BROWN_COLOR];
    //    [btnSelected setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    btnSelected.alpha = 1.0;
    btnSelected.enabled = YES;
}

//To validate URL type
+(BOOL) validateURL: (NSString *) urlString
{
    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlPredic = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    BOOL isValidURL = [urlPredic evaluateWithObject:urlString];
    return isValidURL;
}

//Check the object is null type or not.
+(BOOL)checkForEmptyOrNull:(id) object
{
    if([object isKindOfClass:[NSNull class]])
        return YES;
    else if([object isKindOfClass:[NSString class]])
    {
        NSString *str = (NSString *)object;
        if(str.length == 0)
            return YES;
        else
            return NO;
    }
    return YES;
}
+(void)showNetworkError
{
   ALERT(NOINTERNET, NETWORKCONNECTIONMESSAGE);
}

#pragma mark- Loader methds
#pragma mark-
+(void)showLoader_OnView:(UIView *)vwLoader
{
    //    [self hideLoader];
    [PayuMoneySDKActivityView removeViewAnimated:NO];
//    vwLoader = SDK_APP_DELEGATE.window;
    [PayuMoneySDKActivityView activityViewForView:vwLoader withLabel:@"Please wait..."];
}

+(void)hideLoader
{
    [PayuMoneySDKActivityView removeViewAnimated:YES];
}

#pragma mark - Calculate size of string

+ (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}
-(NSString*) appUniqueID{
    // getting the unique key (if present ) from keychain , assuming "your app identifier" as a key
    NSString *retrieveuuid = [SSKeychain passwordForService:SDK_BUNDLE_IDENTIFIER account:SDK_KEYCHAIN_ACCOUNT_KEY];
    if (retrieveuuid == nil) { // if this is the first time app lunching , create key for device
        NSString *strudid  = [self stringUniqueID];
        // save newly created key to Keychain
        [SSKeychain setPassword:strudid forService:SDK_BUNDLE_IDENTIFIER account:SDK_KEYCHAIN_ACCOUNT_KEY];
        // this is the one time process
    }
    
    NSString  *uniqueID = [SSKeychain passwordForService:SDK_BUNDLE_IDENTIFIER account:SDK_KEYCHAIN_ACCOUNT_KEY];
    
    //NSLog(@"PayuMoneyUniqueID = %@",uniqueID);
    
    return uniqueID;
}

- (NSString *)stringUniqueID {
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string ;
}

@end
