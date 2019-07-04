//
//  HomeTableViewController.m
//  Batch record printing
//
//  Created by SG on 2019/7/4.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "HomeTableViewController.h"
#import "AddBatchViewController.h"

@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
}



- (IBAction)addBatchAction:(id)sender {
    
    AddBatchViewController *addVc = [[AddBatchViewController alloc]init];
    [self.navigationController pushViewController:addVc animated:YES];
    
}

@end
