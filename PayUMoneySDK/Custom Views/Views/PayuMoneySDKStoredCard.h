//
//  StoredCard.h
//  payuSDK
//
//  Created by Honey Lakhani on 9/24/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol StoredCardProtocol <NSObject>
//-(void)changeTableContentOffset;
//@end
@interface PayuMoneySDKStoredCard : UIView


   @property NSInteger j;


@property (weak, nonatomic) IBOutlet UILabel *cardName;
@property (weak, nonatomic) IBOutlet UILabel *cardNo;
@property (weak, nonatomic) IBOutlet UIButton *btnCardSavedFor;

//@property (weak, nonatomic) IBOutlet UITextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UIImageView *cardTypeImg;
@property (nonatomic,strong) PayuMoneySDKStoredCard *storedCard;
//@property id<StoredCardProtocol> storedCardDelegate;
-(PayuMoneySDKStoredCard *)initWithFrame : (CGRect)frame;
@end
