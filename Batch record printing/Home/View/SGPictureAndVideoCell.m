//
//  SGPictureAndVideoCell.m
//  Enterprise
//
//  Created by SG on 2018/10/22.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import "SGPictureAndVideoCell.h"
#import "UIimage+XB.h"
#import <AVKit/AVKit.h>
@interface SGPictureAndVideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SGPictureAndVideoCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.playBtn.hidden = YES;
    self.imageView.clipsToBounds = YES;
}

-(void)setModel:(SGImageAndVideoModel *)model{
    _model = model;
    self.titleLabel.text = model.resourceName;
    self.selectedBtn.selected = model.isSelected;
    
    if ([model.resourceType isEqualToString:@"video"]){
        [self isGotoDownload];
    }else{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.resourceUrl] placeholderImage:PlaceholderImage];
    }
}


-(void)isGotoDownload{
    self.model.fullPath = [KCachesPath stringByAppendingPathComponent:self.model.resourceUrl.lastPathComponent];
    if ([kFileManager fileExistsAtPath:self.model.fullPath]) {//如果文件存在
        self.model.filePath = [NSURL fileURLWithPath:self.model.fullPath];
        self.model.fileImage = [UIImage firstFrameWithVideoURL:self.model.filePath];
        self.imageView.image = self.model.fileImage;
        self.playBtn.hidden = NO;
    }else{
        self.playBtn.hidden = YES;
        self.imageView.image = PlaceholderVideo;
        [self download];
    }
}


- (void)download{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.resourceUrl]];
    
    NSURLSessionDownloadTask *loadTask = [manger downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度监听
        //NSLog(@"Progress:----%.2f%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fullPath = [KCachesPath stringByAppendingPathComponent:self.model.resourceUrl.lastPathComponent];
        NSLog(@"fullPath:%@",fullPath);
        NSLog(@"targetPath:%@",targetPath);
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"filePath:%@",filePath);
    
        self.model.filePath = filePath;
        self.model.fileImage =[UIImage firstFrameWithVideoURL:filePath];
        self.imageView.image = self.model.fileImage;
        self.playBtn.hidden = NO;
        
    }];
    [loadTask resume];
}


-(void)setIsFromGuanJia:(BOOL)isFromGuanJia{
    _isFromGuanJia = isFromGuanJia;
}

-(void)setIsHiddenBtn:(BOOL)isHiddenBtn{
    _isHiddenBtn = isHiddenBtn;
    self.selectedBtn.hidden = isHiddenBtn;
}

-(void)setSelectedModels:(NSArray *)selectedModels{
    _selectedModels = selectedModels;
}

- (IBAction)selectedAction:(UIButton *)sender {
    self.model.isSelected = !sender.selected;
    if (self.block) {
        self.block(self.model);
    }
}


- (IBAction)playAction:(UIButton *)sender {
    
}



@end
