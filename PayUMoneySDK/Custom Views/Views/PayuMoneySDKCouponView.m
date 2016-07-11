//
//  CouponView.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/2/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKCouponView.h"

#define btnTag 1111
@interface PayuMoneySDKCouponView()
{
    NSArray *couponArray;
    NSDictionary *selectedCoupon;
    int rowSelected;
}

@end

@implementation PayuMoneySDKCouponView

-(PayuMoneySDKCouponView *)initWithFrame : (CGRect)frame withArray : (NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.couponView = [[[NSBundle mainBundle]loadNibNamed:@"PayuMoneySDKCouponView" owner:self options:nil]firstObject];
        self.couponView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
       // [self.couponView setBackgroundColor:[UIColor blackColor]];
        //[self.couponView setBackgroundColor:[UIColor blueColor]];
        if(CGRectIsEmpty(frame))
            self.bounds = self.couponView.frame;
        [self addSubview:self.couponView];
    }
  
        couponArray = arr;
  
    
    rowSelected = -1;
    self.couponView.availableCouponLbl.font = SDK_FONT_BOLD(20.0);
    [self.couponView.cancelBTn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.couponView.cancelBTn.layer.cornerRadius = 3.0;
    [self.couponView.okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.couponView.okBtn.layer.cornerRadius = 3.0;
    self.couponTableView.delegate = self;
    self.couponTableView.dataSource = self;
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return couponArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
      UITableViewCell *cell;
  
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        
    NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:[couponArray objectAtIndex:indexPath.row]];
    NSString *date = [dict valueForKey:@"expiryDate"];
    double ldate = [date longLongValue];
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:(ldate / 1000)];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    

    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"selectedradio"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"unselectedradio"] forState:UIControlStateNormal];
    [btn setTag:btnTag +indexPath.row ];
    [btn addTarget:self action:@selector(radioBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(cell.frame.origin.x + 3, cell.frame.size.height/2 - 10, 20, 20)];
    //[btn setBackgroundColor:[UIColor orangeColor]];
    [cell.contentView addSubview:btn];
    UILabel *couponName = [[UILabel alloc]init];
    couponName.text = [dict valueForKey:@"couponString"];
    [couponName setFont:SDK_FONT_NORMAL(15.0)];
    CGSize size = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"couponString"]] sizeWithAttributes:@{NSFontAttributeName: SDK_FONT_NORMAL(15.0)}];
    [couponName setFrame:CGRectMake(btn.frame.origin.x + btn.frame.size.width + 5, cell.frame.size.height/2 - size.height / 2, size.width, size.height)];
   // [couponName setBackgroundColor:[UIColor orangeColor]];
    [cell.contentView addSubview:couponName];
    size = [[NSString stringWithFormat:@"%@",@"Valid Upto"] sizeWithAttributes:@{NSFontAttributeName: SDK_FONT_NORMAL(15.0)}];
    UILabel *validUptoLbl = [[UILabel alloc]init];
    validUptoLbl.text = @"Valid Upto";
    [validUptoLbl setFont:SDK_FONT_NORMAL(15.0)];
    [validUptoLbl setFrame:CGRectMake(tableView.frame.size.width - size.width - 10, couponName.frame.origin.y, size.width, size.height)];
    //[validUptoLbl setBackgroundColor:[UIColor orangeColor]];
    [cell.contentView addSubview:validUptoLbl];
    UILabel *dateLbl = [[UILabel alloc]init];
    dateLbl.text =[df stringFromDate:dt];
    [dateLbl setFont:SDK_FONT_NORMAL(13.0)];
    size = [[NSString stringWithFormat:@"%@",dateLbl.text] sizeWithAttributes:@{NSFontAttributeName: SDK_FONT_NORMAL(13.0)}];
    [dateLbl setFrame:CGRectMake(tableView.frame.size.width - size.width - 10, couponName.frame.origin.y + couponName.frame.size.height + 3, size.width, size.height)];
   // [dateLbl setBackgroundColor:[UIColor orangeColor]];
    [cell.contentView addSubview:dateLbl];
    }
    return cell;
}

-(void)radioBtnClicked : (UIButton *)sender
{
    for (int i =0 ; i<couponArray.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:btnTag + i];
        if (btn != sender && btn.selected) {
            btn.selected = !btn.selected;
        }
    }
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        rowSelected = sender.tag - btnTag;
    }
    else
        rowSelected = -1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (IBAction)cancelBtnClicked:(UIButton *)sender {
    selectedCoupon = nil;
//    UITableView *tableView = (UITableView *)self.superview.superview;
//    [tableView setScrollEnabled:YES];

    [self.superview removeFromSuperview];

    [self removeFromSuperview];
}

- (IBAction)okBtnClicked:(UIButton *)sender {
//    UITableView *tableView = (UITableView *)self.superview.superview;
//    [tableView setScrollEnabled:YES];

    if (rowSelected != -1) {
        
    
            selectedCoupon = [couponArray objectAtIndex:rowSelected];
    }
        //NSLog(@"selected coupon ======= %@",selectedCoupon);
        

    if((selectedCoupon != nil)&& (self.couponDelegate != nil && [self.couponDelegate respondsToSelector:@selector(sendSelectedCoupon :)]))
    {
        [self.couponDelegate sendSelectedCoupon : selectedCoupon];
    }
    [self.superview removeFromSuperview];
    [self removeFromSuperview];
}
@end
