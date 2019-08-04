//
//  LeftViewController.m
//  ViewControllerTransition
//
//  Created by 陈旺 on 2017/7/10.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import "LeftViewController.h"
#import "SGPictureAndVideoController.h"
#import "SGPageInfoController.h"
#import "FXJIDITableViewController.h"
#import "CWTableViewInfo.h"
#import "UIViewController+CWLateralSlide.h"
#import <SDWebImage/SDImageCache.h>
#import "LeftHeaderView.h"
#import "AboutViewController.h"
#import <StoreKit/StoreKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface LeftViewController ()<MFMailComposeViewControllerDelegate>

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation LeftViewController
{
    CWTableViewInfo *_tableViewInfo;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHeader];
    [self setupTableView];
    
}

- (void)setupHeader {
    LeftHeaderView *headerView = [LeftHeaderView leftHeaderView];
    headerView.frame = CGRectMake(0, 0, kCWSCREENWIDTH * 0.75, 200);
    [self.view addSubview:headerView];
}

- (void)setupTableView {
    
    _tableViewInfo = [[CWTableViewInfo alloc] initWithFrame:CGRectMake(0, 200, kCWSCREENWIDTH * 0.75, CGRectGetHeight(self.view.bounds)-200) style:UITableViewStylePlain];
    
    for (int i = 0; i < self.titleArray.count; i++) {
        NSString *title = self.titleArray[i];
        NSString *imageName = self.imageArray[i];
        SEL sel = @selector(didSelectCell:indexPath:);
        CWTableViewCellInfo *cellInfo = [CWTableViewCellInfo cellInfoWithTitle:title imageName:imageName target:self sel:sel];
        [_tableViewInfo addCell:cellInfo];
    }
    
    [self.view addSubview:[_tableViewInfo getTableView]];
    [[_tableViewInfo getTableView] reloadData];
}

#pragma mark - cell点击事件
- (void)didSelectCell:(CWTableViewCellInfo *)cellInfo indexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        SGPageInfoController *infoVC = [[SGPageInfoController alloc]init];
        [self cw_pushViewController:infoVC];
    }else if (indexPath.row == 1){
        FXJIDITableViewController *jidiVC = [[FXJIDITableViewController alloc]init];
        jidiVC.fromMe = YES;
        [self cw_pushViewController:jidiVC];
    }else if (indexPath.row == 2 || indexPath.row == 3) {
        SGPictureAndVideoController *pictureVC = [[SGPictureAndVideoController alloc]init];
        pictureVC.type = (indexPath.row == 2) ? FXZSBatchTypePicture : FXZSBatchTypeVideo;
        pictureVC.isFromMe = YES;
        [self cw_pushViewController:pictureVC];
    }else if (indexPath.row == 4){
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
            [SVProgressHUD showSuccessWithStatus:@"清理完成"];
        }];
        [SVProgressHUD showSuccessWithStatus:@"清理成功"];
    }else if (indexPath.row == 5){
        AboutViewController *aboutVc = [[AboutViewController alloc]init];
        [self cw_pushViewController:aboutVc];
    }else if (indexPath.row == 6){
        UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[@"分享给你",[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1474062110"]] applicationActivities:nil];
        [self presentViewController:avc animated:YES completion:nil];
    }else if (indexPath.row == 7){
        NSString *appURL = @"https://itunes.apple.com/cn/app/id1474062110?action=write-review";
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appURL] options:@{} completionHandler:nil];
    }else{
        [self sendByEmail];
    }
}


- (void)sendByEmail{
    MFMailComposeViewController *mailSender = [[MFMailComposeViewController alloc]init];
    mailSender.mailComposeDelegate = self;
    [mailSender setSubject:@""];
    [mailSender setMessageBody:@"" isHTML:NO];
    [mailSender setToRecipients:[NSArray arrayWithObjects:@"xxx@163.com", nil]];
    
    //[mailSender addAttachmentData:datamimeType:mimeTypefileName:fileName];
    [self presentViewController:mailSender animated:YES completion:^{        //
    
    }];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MFMailComposeResultCancelled:
             [SVProgressHUD showInfoWithStatus:@"发送取消"];
            break;
        case MFMailComposeResultSaved:
             [SVProgressHUD showInfoWithStatus:@"存储成功"];
            break;
        case MFMailComposeResultSent:
             [SVProgressHUD showInfoWithStatus:@"发送成功"];;
            break;
        case MFMailComposeResultFailed:
             [SVProgressHUD showInfoWithStatus:@"发送失败"];
            break;
        default:
            break;
    }
}
    

#pragma mark - Getter
- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[@"icon_zhutiname",
                        @"icon_diqu",
                        @"icon_image",
                        @"icon_video",
                        @"weibiaoti",
                        @"guanyuwomen",
                        @"fenxiang",
                        @"pinglun",
                        @"youjian"];
    }
    return _imageArray;
}

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = @[@"产品管理",
                        @"基地管理",
                        @"上传图片",
                        @"上传视频",
                        @"清理缓存",
                        @"关于我们",
                        @"分享应用",
                        @"给我评论",
                        @"联系我们"];
    }
    return _titleArray;
}


@end
