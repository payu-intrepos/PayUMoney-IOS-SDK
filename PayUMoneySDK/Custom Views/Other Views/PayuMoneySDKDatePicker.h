//
//  DatePicker.h
//  payuSDK
//
//  Created by Honey Lakhani on 8/25/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickerDelegate <NSObject>
@optional
-(void)selectedDate : (NSString *)date;
@end
@interface PayuMoneySDKDatePicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong,nonatomic) NSArray *months;
@property (strong,nonatomic) NSMutableArray *years;
@property (strong,nonatomic) UIPickerView *datePicker;
@property (strong,nonatomic) PayuMoneySDKDatePicker *datePickerView;
@property (strong,nonatomic) id<DatePickerDelegate>datePickerDelegate;


-(void)doneButtonPressedFromToolBar;
@end
