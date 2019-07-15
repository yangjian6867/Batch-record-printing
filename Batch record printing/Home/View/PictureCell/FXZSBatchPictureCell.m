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
#import "SGPictureAndVideoController.h"

#define kAddImage [UIImage imageNamed:@"AddMedia"]

@interface FXZSBatchPictureCell()<UICollectionViewDelegate,UICollectionViewDataSource,sgFarmActivitiyPictureItemCellDelegate,TZImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *topButton;

@property (nonatomic,strong)NSIndexPath *selectedIndexPath;
@property (nonatomic,strong)NSMutableArray *imageUrls;
@end

@implementation FXZSBatchPictureCell

static NSString *const FXZSBatchPictureItemCellID= @"FXZSBatchPictureItemCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageUrls = [NSMutableArray array];
    [self.collectionView registerNib:[UINib nibWithNibName:FXZSBatchPictureItemCellID bundle:nil] forCellWithReuseIdentifier:FXZSBatchPictureItemCellID];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(70, 70);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FXZSBatchPictureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FXZSBatchPictureItemCellID forIndexPath:indexPath];
    cell.imageUrl = self.imageUrls[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageUrls.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *imageUrl = self.imageUrls[indexPath.row];
    if (!self.fromPiCi) {
        [self addPicture];
        return;
    }
    
    SGPictureAndVideoController *videoVC = [[SGPictureAndVideoController alloc]init];
    videoVC.refreshDataBlock = ^(NSArray * _Nonnull selectedModels) {
         NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, selectedModels.count)];
        [self.imageUrls removeAllObjects];
      
        [self.imageUrls addObject: @"AddMedia"];
        
        NSArray * resourceUrls = [selectedModels valueForKeyPath:@"resourceUrl"];
        
        if (self.type) {
            SGImageAndVideoModel *model = selectedModels.firstObject;
            [self.imageUrls replaceObjectAtIndex:0 withObject:model.fullPath];
            self.batch.detail = model.ID;
        }else{
            [self.imageUrls insertObjects:resourceUrls atIndexes:indexSet];
            
            NSMutableString *imageID = [NSMutableString string];
            for (SGImageAndVideoModel *model in selectedModels) {
                [imageID appendFormat:@"%@,",model.ID];
            }
            self.batch.detail = imageID;
        }
        
        if (self.imageUrls.count >= 4) {
            [self.imageUrls removeLastObject];
        }
        [collectionView reloadData];
    };
    
    videoVC.type =self.type;
    
    [self.rootVC.navigationController pushViewController:videoVC animated:YES];
    
}

-(void)addPicture{
    TZImagePickerController *imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickController.allowPickingVideo = NO;
    
    [self.rootVC presentViewController:imagePickController animated:YES completion:nil];
}

#pragma mark -- TZImagePickerController代理方法
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    NSMutableArray *fileNames = [NSMutableArray array];
    NSMutableArray *fileUrls = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    
    [SVProgressHUD show];
        NSData *data = UIImagePNGRepresentation(photos[0]);
        NSString *fileName = [assets[0]valueForKeyPath:@"filename"];
        [fileNames addObject:fileName];
        dispatch_group_enter(group);
        [[NetWorkTools sharedNetWorkTools]uploadFileWithPath:upload fileData:data fileName:fileName progress:^(NSProgress *progress) {
            //NSLog(@"第%d张图片上传进度:%.2f",i+1,1.0 * progress.completedUnitCount / progress.totalUnitCount);
        } success:^(NSString *filePath) {
            NSLog(@"图片成功路径是filePath = %@",filePath);
            [self.imageUrls replaceObjectAtIndex:0 withObject:filePath];
            self.batch.detail = filePath;
            [self.collectionView reloadData];
            [SVProgressHUD dismiss];
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
            [SVProgressHUD dismiss];
        }];
    
}

-(void)setBatch:(ZSBatch *)batch{
    _batch = batch;
    [self.topButton setTitle:batch.name forState:UIControlStateNormal];
    [self.topButton setImage:[UIImage imageNamed:batch.icon] forState:UIControlStateNormal];
    [self.imageUrls removeAllObjects];

    NSArray *arr = [batch.detail componentsSeparatedByString:@","];
    if (arr.count) {
        [self.imageUrls addObjectsFromArray:arr];
    }else{
        [self.imageUrls addObject:batch.detail];
    }
    self.type = [batch.name containsString:@"图片"] ? FXZSBatchTypePicture : FXZSBatchTypeVideo;
    [self.collectionView reloadData];
}


-(void)sgFarmActivitiyPictureItemCellDelted:(FXZSBatchPictureItemCell *)itemCell{
    NSIndexPath *path = [self.collectionView indexPathForCell:itemCell];
    if ([self.delegate respondsToSelector:@selector(sgFarmActivitiyPictureCellDeleted:)]) {
        [self.delegate fXZSBatchPictureCellDeleted:path];
    }
}



@end
