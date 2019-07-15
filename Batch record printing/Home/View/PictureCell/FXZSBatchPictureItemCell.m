//
//  SlaughterImagItemCell.m
//  Enterprise
//
//  Created by SG on 2018/11/20.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import "FXZSBatchPictureItemCell.h"

@interface FXZSBatchPictureItemCell ()


@property (weak, nonatomic) IBOutlet UIImageView *bofangBtn;

@end

@implementation FXZSBatchPictureItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    
    if ([imageUrl isEqualToString:@"AddMedia"]) {
        self.iconView.image = [UIImage imageNamed:@"AddMedia"];
    }else if ([imageUrl hasPrefix:@"http"]) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    }else if ([imageUrl.pathExtension isEqualToString:@"mp4"]){
        imageUrl = [NSString stringWithFormat:@"%@%@%@",MaiURL,fileUrl,imageUrl];
        [self isGotoDownload:imageUrl];
        self.bofangBtn.hidden = NO;
    }else{
        imageUrl = [NSString stringWithFormat:@"%@%@%@",MaiURL,fileUrl,imageUrl];
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]] options:SDWebImageRetryFailed];
    }
}


-(void)isGotoDownload:(NSString *)path{

    NSString *fullPath = [[NSFileManager cachesPath] stringByAppendingPathComponent:path.lastPathComponent];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {//如果文件存在
        self.iconView.image = [UIImage firstFrameWithVideoURL:[NSURL fileURLWithPath:fullPath]];
    }else{
        self.iconView.image = [UIImage imageWithColor:[UIColor lightGrayColor]];
        [self download:path];
    }
}


- (void)download:(NSString *)path{
    
    [[NetWorkTools sharedNetWorkTools]downloadWithPath:path completionHandler:^(NSURL *filePath, NSError *error) {
        self.iconView.image =[UIImage firstFrameWithVideoURL:filePath];
    }];
}


- (IBAction)deletedAciton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sgFarmActivitiyPictureItemCellDelted:)]) {
        [self.delegate sgFarmActivitiyPictureItemCellDelted:self];
    }
}

@end

