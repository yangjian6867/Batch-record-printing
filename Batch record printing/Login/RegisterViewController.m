//
//  RegisterViewController.m
//  Batch record printing
//
//  Created by SG on 2019/7/15.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title= @"注册";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)suare:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
