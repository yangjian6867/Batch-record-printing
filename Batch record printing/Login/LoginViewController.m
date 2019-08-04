//
//  LoginViewController.m
//  Batch record printing
//
//  Created by 杨健 on 2019/6/18.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "LoginViewController.h"
#import "Account.h"
#import "FXUserTool.h"
#import "AddBatchViewController.h"
#import "RegisterViewController.h"
#import "HomeTableViewController.h"
#import "MainNavigationController.h"
#import "LeftSortsViewController.h"
#import "MainNavigationController.h"
#import "LeftSlideViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *AccountTF;
@property (nonatomic,copy)NSString *UUID;
@property (nonatomic,copy)NSString *code;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) MainNavigationController *mainNavigationController;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    //self.AccountTF.text = @"test053_003";
    //self.passwordTF.text = @"12345678";
    //self.AccountTF.text = @"nmg1";
    //self.passwordTF.text = @"Abc123456";
}

- (IBAction)loginAction:(id)sender {
    
    if (self.AccountTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }else if (self.passwordTF.text.length <=0){
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    [self getUUIDs];
}

- (void)getUUIDs{
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypeGET urlString:UUIDUrl parms:nil success:^(id JSON) {
        NSString *code = JSON[@"code"];
        NSString *uuid = JSON[@"uuid"];
        [self loginServiceWith:uuid andCode:code];
    } :^(NSError *error) {
        
    }];
}

-(void)loginServiceWith:(NSString *)uuid andCode:(NSString *)code{
    NSDictionary *param = @{
                            @"userName":self.AccountTF.text,
                            @"account":self.AccountTF.text,
                            @"password":self.passwordTF.text,
                            @"uuid": uuid,
                            @"code": code //测试里可以直接用 @"8888" self.code
                            };
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:LoginUrl parms:param success:^(id JSON) {
        Account *account = [Account mj_objectWithKeyValues:JSON[@"data"]];
        account.token = JSON[@"token"];
        [[FXUserTool sharedFXUserTool]saveAccount:account];
       
        
         AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [tempAppDelegate changeRootVC];
        
    } :^(NSError *error) {
        
    }];
}

- (IBAction)registreAction:(id)sender {
    RegisterViewController *regvc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:regvc animated:YES];
}

@end
