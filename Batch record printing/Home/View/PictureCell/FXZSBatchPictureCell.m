//
//  SlaughterImagAndVideoCell.m
//  Enterprise
//
//  Created by SG on 2018/11/20.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import "FXZSBatchPictureCell.h"
#import "FXZSBatchPictureItemCell.h"
#import "TZImagePickerController.h"

#define kAddImage [UIImage imageNamed:@"AddMedia"]

@interface FXZSBatchPictureCell()<UICollectionViewDelegate,UICollectionViewDataSource,sgFarmActivitiyPictureItemCellDelegate,TZImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *topButton;

@property (nonatomic,strong)NSIndexPath *selectedIndexPath;
@property (nonatomic,strong)NSMutableArray *images;
@end

@implementation FXZSBatchPictureCell

static NSString *const FXZSBatchPictureItemCellID= @"FXZSBatchPictureItemCell";

-(NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.images addObject:kAddImage];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FXZSBatchPictureItemCell" bundle:nil] forCellWithReuseIdentifier:FXZSBatchPictureItemCellID];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(70, 70);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FXZSBatchPictureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FXZSBatchPictureItemCellID forIndexPath:indexPath];
    cell.image = self.images[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIImage *image =  self.images[indexPath.row];
    if ([UIImagePNGRepresentation(image) isEqualToData:UIImagePNGRepresentation(kAddImage)]) {
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        [kWindown.rootViewController presentViewController:imagePicker animated:YES completion:nil];
        self.selectedIndexPath = indexPath;
    }
}

#pragma mark -- TZImagePickerController代理方法
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    [self handelphotoData:photos infos:infos];
}

#pragma mark -- 处理选择后的照片数据
-(void)handelphotoData:(NSArray *)photos infos:(NSArray<NSDictionary *> *)infos{
    UIImage *image = photos[0];
    NSString *filePath = infos[0][@"PHImageFileURLKey"];
    NSString *imageName = [filePath lastPathComponent];
    
    [[NetWorkTools sharedNetWorkTools]downloadWithPath:@"" completionHandler:^(NSURL *filePath, NSError *error) {
        NSLog(@"filePath",filePath.absoluteString);
    }];
    
    
//    [NetWorkManagerYJ uploadFileWith:getUpload parms:@{} image:image name:imageName completionHandle:^(id model, NSString *error) {
//        NSArray *arr = model[@"data"][@"IMAGE_URLS"];
//        if (arr.count) {
//            NSString *imagePath = arr[0];
//            self.activitiy.detail = [NSString stringWithFormat:@"%@%@",USER_IMAGE_IP,imagePath];
//            if ([self.delegate respondsToSelector:@selector(sgFarmActivitiyPictureCellClick:)]) {
//                [self.delegate sgFarmActivitiyPictureCellClick:self.selectedIndexPath];
//            }
//        }else{
//            [MBProgressHUD showAlert:@"服务器返回图片地址错误"];
//        }
//    }];
}

-(void)setBatch:(ZSBatch *)batch{
    _batch = batch;
    [self.topButton setTitle:batch.name forState:UIControlStateNormal];
    [self.topButton setImage:[UIImage imageNamed:batch.icon] forState:UIControlStateNormal];
    [self.collectionView reloadData];
}


-(void)sgFarmActivitiyPictureItemCellDelted:(FXZSBatchPictureItemCell *)itemCell{
    NSIndexPath *path = [self.collectionView indexPathForCell:itemCell];
    if ([self.delegate respondsToSelector:@selector(sgFarmActivitiyPictureCellDeleted:)]) {
        [self.delegate sgFarmActivitiyPictureCellDeleted:path];
    }
}



@end
