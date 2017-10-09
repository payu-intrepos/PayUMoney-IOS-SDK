//
//  ViewController.m
//  CitrusGraphicsExample
//
//  Created by Mukesh Patil on 11/8/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import "ViewController.h"

#import <CitrusGraphics/CitrusGraphics.h>

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = [NSString stringWithFormat:@"Citrus Graphics Demo v%@", CITRUSGRAPHICS_VERSION];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self.tableView reloadData];
}

#pragma mark - TableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    //
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 1;
    }
    else if (section == 2) {
        return 1;
    }
    else if (section == 3) {
        return 1;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Card Scheme";
    }
    else if(section == 1){
        return @"Card Large Scheme";
    }
    else if(section == 2) {
        return @"Bank Logo";
    }
    else if(section == 3){
        return @"Bank Large Logo";
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    static NSString *CellIdentifier = @"CellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.contentView viewWithTag:1000].layer.cornerRadius = 5;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (indexPath.section == 0){
            cell.textLabel.text = @"VISA Card";
            [cell.imageView setSystemActivity];
            [cell.imageView loadCitrusCardWithCardScheme:@"VISA"];
        }
        else if (indexPath.section == 1){
            cell.textLabel.text = @"VISA Card";
            [cell.imageView setSystemActivity];
            [cell.imageView loadCitrusLargeCardWithCardScheme:@"VISA"];
        }
        else if (indexPath.section == 2){
            cell.textLabel.text = @"ICICI Bank";
            [cell.imageView setSystemActivity];
            [cell.imageView loadCitrusBankWithBankCID:@"CID001"];
        }
        else if (indexPath.section == 3){
            cell.textLabel.text = @"ICICI Bank";
            [cell.imageView setSystemActivity];
            [cell.imageView loadCitrusLargeBankWithBankCID:@"CID001"];
        }
    });
    
    
    return cell;
}


@end
