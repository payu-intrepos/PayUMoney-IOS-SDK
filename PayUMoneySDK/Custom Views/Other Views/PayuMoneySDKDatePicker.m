//
//  DatePicker.m
//  payuSDK
//
//  Created by Honey Lakhani on 8/25/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKDatePicker.h"


@implementation PayuMoneySDKDatePicker

NSInteger ii , xx;
int noOfRows;


-(PayuMoneySDKDatePicker *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.datePicker.delegate = self;
    self.datePicker.dataSource = self;
    [self yearsValues];
    if(self)
    {
//        
//        self.datePickerView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        if (CGRectIsEmpty(frame)) {
//            self.bounds = self.datePickerView.bounds;
//        }
//       [self.datePickerView addSubview:self.datePicker];
//
        [self addSubview:self.datePicker];
    }
    
  
   
    return self;
    
}

-(void)yearsValues
{
    self.years = [[NSMutableArray alloc]init];
    NSDateFormatter *yf = [[NSDateFormatter alloc]init];
    self.months = [yf standaloneMonthSymbols];
    NSLog(@"=====%@",self.months);
    [yf setDateFormat:@"MM"];
    ii = [[yf stringFromDate:[NSDate date]]integerValue];
    noOfRows = 12 - ii + 1;
    NSLog(@" iiii %ld",(long)ii);
    [yf setDateFormat:@"yyyy"];
    
    
    for(int j = [[ yf stringFromDate:[NSDate date]] intValue];j<=[[ yf stringFromDate:[NSDate date]] intValue] + 30;j++)
    {
        [self.years addObject:[NSString stringWithFormat:@"%d",j]];
        //  NSLog(@"---------------- %@",self.years);
    }
     NSLog(@"$$$$$$ %@",self.years);
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0  )
    {
        return noOfRows;
    }
    
    
        
    else
        return 25;
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        if([pickerView selectedRowInComponent:1]!= 0)
        {
            if (((row +1) % 12) == 0 )
            {
            return @"12";
            }
            return [NSString stringWithFormat:@"%d", ((row + 1)  % 12 ) ];

        }
        if (((row + ii) % 12) == 0 ) {
            return @"12";
        }
        return [NSString stringWithFormat:@"%d", ((row + ii) % 12 ) ];
        
        
    }
    else
    {
        
        return [self.years objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self doneButtonPressedFromToolBar];

    
    switch (component) {
        case 0:
            
            break;
            case 1:
            if ([pickerView selectedRowInComponent:1] != 0) {
                    
                noOfRows = 12;
                 [pickerView reloadComponent:0];
            }
            else
            {
                noOfRows = 12 - ii + 1;
                [pickerView reloadComponent:0];
                [pickerView selectRow:0 inComponent:0 animated:YES];
            }
            
            break;
        default:
            break;
    }
    }


-(void)doneButtonPressedFromToolBar
{
    NSInteger index = [self.datePicker selectedRowInComponent:1];
    // NSString *title= [[self.datePicker delegate]pickerView:self.datePicker titleForRow:index forComponent:1];
    NSString *yr = [self.years objectAtIndex:index];
  
    NSString *dateStr = [NSString stringWithFormat:@"%@/%@",[self pickerView:self.datePicker titleForRow:[self.datePicker selectedRowInComponent:0] forComponent:0],yr];
    if (self.datePickerDelegate != nil && [self.datePickerDelegate respondsToSelector:@selector(selectedDate :)]) {
        [self.datePickerDelegate selectedDate : dateStr];
    }
}




@end
