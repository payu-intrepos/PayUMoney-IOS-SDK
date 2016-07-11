//
//  FinalViewController.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/25/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKFinalViewController.h"

@interface PayuMoneySDKFinalViewController ()

@end

@implementation PayuMoneySDKFinalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.msgLbl.text = self.msg;
    UIBarButtonItem *backBTn = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClicked :)];
    self.navigationItem.leftBarButtonItem = backBTn;
    

    //self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backBtnClicked : (UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
