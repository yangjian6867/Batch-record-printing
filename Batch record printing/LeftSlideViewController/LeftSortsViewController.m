//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "SGPictureAndVideoController.h"
#import "SGPageInfoController.h"
#import "FXJIDITableViewController.h"
#import "CWTableViewInfo.h"
#import "UIViewController+CWLateralSlide.h"
#import <SDWebImage/SDImageCache.h>
#import "LeftHeaderView.h"
#import "AboutViewController.h"
//#import "otherViewController.h"

@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];

    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"产品管理";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"基地管理";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"上传图片";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"上传视频";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"清理缓存";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"关于我们";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"分享应用";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (indexPath.row == 0) {
        SGPageInfoController *infoVC = [[SGPageInfoController alloc]init];
        [self pushVC:infoVC andDelegate:tempAppDelegate];
    }else if (indexPath.row == 1){
        FXJIDITableViewController *jidiVC = [[FXJIDITableViewController alloc]init];
        jidiVC.fromMe = YES;
        [self pushVC:jidiVC andDelegate:tempAppDelegate];
    }else if (indexPath.row == 2 || indexPath.row == 3) {
        SGPictureAndVideoController *pictureVC = [[SGPictureAndVideoController alloc]init];
        pictureVC.type = (indexPath.row == 2) ? FXZSBatchTypePicture : FXZSBatchTypeVideo;
        pictureVC.isFromMe = YES;
        [self pushVC:pictureVC andDelegate:tempAppDelegate];
    }else if (indexPath.row == 4){
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
            [SVProgressHUD showSuccessWithStatus:@"清理完成"];
        }];
        [SVProgressHUD showSuccessWithStatus:@"清理成功"];
    }else if (indexPath.row == 5){
        AboutViewController *aboutVc = [[AboutViewController alloc]init];
        [self pushVC:aboutVc andDelegate:tempAppDelegate];
    }else if (indexPath.row == 6){
        UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[@"分享给你",[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1474062110"]] applicationActivities:nil];
        [self presentViewController:avc animated:YES completion:nil];
    }else if (indexPath.row == 7){
        NSString *appURL = @"https://itunes.apple.com/cn/app/id1474062110?action=write-review";
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appURL] options:@{} completionHandler:nil];
    }
    
    
   
}

-(void)pushVC:(UIViewController *)vc andDelegate:(AppDelegate *)tempAppDelegate{
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
    
    [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end
