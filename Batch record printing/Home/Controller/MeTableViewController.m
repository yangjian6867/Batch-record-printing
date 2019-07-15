//
//  MeTableViewController.m
//  Batch record printing
//
//  Created by SG on 2019/7/4.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "MeTableViewController.h"
#import "SGPictureAndVideoController.h"
#import "SGPageInfoController.h"
#import "FXJIDITableViewController.h"
#import <SDWebImage/SDImageCache.h>

@interface MeTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的管家";
    
    self.nameLabel.text = [FXUserTool sharedFXUserTool].account.account;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        SGPageInfoController *infoVC = [[SGPageInfoController alloc]init];
        [self.navigationController pushViewController:infoVC animated:YES];
    }else if (indexPath.row == 2){
        FXJIDITableViewController *jidiVC = [[FXJIDITableViewController alloc]init];
        jidiVC.fromMe = YES;
        [self.navigationController pushViewController:jidiVC animated:YES];
    }else if (indexPath.row == 3 || indexPath.row == 4) {
        SGPictureAndVideoController *pictureVC = [[SGPictureAndVideoController alloc]init];
        pictureVC.type = (indexPath.row == 3) ? FXZSBatchTypePicture : FXZSBatchTypeVideo;
        pictureVC.isFromMe = YES;
        [self.navigationController pushViewController:pictureVC animated:YES];
    }else if (indexPath.row == 5){
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
            [SVProgressHUD showSuccessWithStatus:@"清理完成"];
        }];
        [SVProgressHUD showSuccessWithStatus:@"清理成功"];
    }
   
}


@end
