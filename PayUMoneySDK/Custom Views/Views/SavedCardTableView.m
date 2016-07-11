//
//  SavedCardTableView.m
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 2/15/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import "SavedCardTableView.h"
#import "SavedCardTableViewCell.h"
#include <CommonCrypto/CommonDigest.h>
#import "PayuMoneySDKServiceParameters.h"
#import "PayuMoneySDKRequestManager.h"
@interface SavedCardTableView()
{
    NSArray *arrSavedCards;
    UIControl *controlCVV;
    ConfigBO *configBO;
    NSString *userId,*payID;
    
    
}
@end

@implementation SavedCardTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
//*/
//-(void)awakeFromNib
//{
//    self.dataSource = self;
//            self.delegate = self;
//    
//}
-(instancetype)initWithFrame:(CGRect)frame  withArr : (NSArray *)arr withBO : (ConfigBO *)bo withUserId : (NSString *)uid withPaymentId : (NSString *)pid
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"SavedCardTableView" owner:self options:nil]firstObject];
        self.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        if (CGRectIsEmpty(frame)) {
            self.frame = self.bounds;
        }
        self.dataSource = self;
        self.delegate = self;
        arrSavedCards = arr;
        configBO = bo;
        userId  = uid;
        payID = pid;
       // [self registerNib:[UINib nibWithNibName:@"SavedCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [self reloadData];
        
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrSavedCards.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cell";
    SavedCardTableViewCell *cell;
    cell = (SavedCardTableViewCell *)[self dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SavedCardTableViewCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        NSDictionary *dict = [arrSavedCards objectAtIndex:indexPath.row];
        [cell configureCellItems:dict];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSDictionary *dict  = arrSavedCards[indexPath.row];
//  
//    if ([configBO.oneClick isEqualToString:@"1"] && [dict valueForKey:@"oneclickcheckout"]&& [dict valueForKey:@"cardToken"]) {
//        if ([[self checkNullValue:[dict valueForKey:@"oneclickcheckout"]] isEqualToString:@"1"] && [self checkNullValue:[dict valueForKey:@"cardToken"]]) {
//             [self calculateCardHash : [dict valueForKey:@"cardToken"] withIndex :indexPath.row];
//        }
//       
//        
//
//    }
//    else
//    {
    if (self.savedCardTbldelegate != nil && [self.savedCardTbldelegate respondsToSelector:@selector(savedCardSelectedRow:)]) {
        [self.savedCardTbldelegate savedCardSelectedRow:indexPath.row];
        
    }
    //}
    
}
//-(void)calculateCardHash : (NSString *)token withIndex : (NSInteger)index
//{
//    if (configBO && configBO.authorizationSalt && configBO.userId && configBO.userToken)
//    {
//        NSString *hashSeq = [NSString stringWithFormat:@"%@|%@|%@|%@",configBO.userToken,userId,token,configBO.authorizationSalt];
//        NSString *hash = [self hashCal : hashSeq];
//        if (hash && payID && userId) {
//            NSString *requestBody =  [PayuMoneySDKServiceParameters prepareBodyForCardHashWithHash:hash withPaymentId:payID withUserId:configBO.userId ];
//            [self hitApiForSavedCardOneClick:requestBody withIndex:index];
//        }
//        
//    }
//}
//
//-(void)hitApiForSavedCardOneClick : (NSString *)requestBody withIndex : (NSInteger)index
//{
//    PayuMoneySDKRequestManager *request = [[PayuMoneySDKRequestManager alloc]init];
//  [request hitWebServiceForURLWithPostBlock:YES isAccessTokenRequired:YES webServiceURL:KVAULT_TEST_URL withBody:requestBody andTag:SDK_REQUEST_CARD_ONE_CLICK completionHandler:^(id object, SDK_REQUEST_TYPE tag, NSError * err)
//   {
//       if (err == nil)
//       {
//           if([object isKindOfClass:[NSDictionary class]])
//           {
//               if ([object valueForKey:@"result"])
//               {
//                   NSString *result = [self checkNullValue:[object valueForKey:@"result"]];
//                   if (self.savedCardTbldelegate != nil && [self.savedCardTbldelegate respondsToSelector:@selector(oneClickCardHash:withIndex:)])
//                   {
//                       [self.savedCardTbldelegate oneClickCardHash:result withIndex : index];
//                       
//                   }
//                   
//               }
//           }
//       }
//   }];
//    
//}
//
//-(NSString *)hashCal : (NSString *)seq
//{
//
//        const char *s=[seq cStringUsingEncoding:NSASCIIStringEncoding];
//        NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
//        
//        uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
//        CC_SHA256(keyData.bytes, keyData.length, digest);
//        NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
//        NSString *hash=[out description];
//        hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
//        hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
//        hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
//        return hash;
//
//}

-(NSString*)checkNullValue:(id)text
{
    NSString *parsedText = @"";
    if([text isKindOfClass:[NSString class]])
    {
        if([text isEqualToString:@"<null>"])
            parsedText = @"";
        else{
            parsedText = text;
        }
    }
    else if ([text isKindOfClass:[NSNumber class]]){
        parsedText = [text stringValue];
    }
    return parsedText;
}


@end
