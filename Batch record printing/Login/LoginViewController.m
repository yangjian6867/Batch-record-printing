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
#import "HomeTableViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *AccountTF;
@property (nonatomic,copy)NSString *UUID;
@property (nonatomic,copy)NSString *code;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    self.title = @"aaaa";
}

- (IBAction)loginAction:(id)sender {
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
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[HomeTableViewController alloc]init]];
        [UIApplication changeRootVC:nav];
    } :^(NSError *error) {
        
    }];
}


@end
