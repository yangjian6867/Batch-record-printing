//
//  SGPictureAndVideoController.m
//  Enterprise
//
//  Created by SG on 2018/10/22.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import "SGPictureAndVideoController.h"
#import "SGImageAndVideoModel.h"
#import "SGPictureAndVideoCell.h"

#define kPictureVideoitemW (UIScreen.screen_width - 30)/2

@interface SGPictureAndVideoController ()

@property (nonatomic,assign)NSUInteger pageNum;
@end

@implementation SGPictureAndVideoController

static NSString *const SGPictureAndVideoCellID = @"SGPictureAndVideoCell";


- (NSMutableArray *)imageAndVideos{
    if (_imageAndVideos == nil) {
        _imageAndVideos =[NSMutableArray array];
    }
    return _imageAndVideos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SGPictureAndVideoCell" bundle:nil] forCellWithReuseIdentifier:SGPictureAndVideoCellID];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake(kPictureVideoitemW, kPictureVideoitemW);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromHttp];
    }];

    [self.collectionView.mj_header beginRefreshing];
}


- (void)loadDataFromHttp{

    Account *account = [FXUserTool sharedFXUserTool].account;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:account.userId forKey:@"userId"];
    [dict setValue:@"1" forKey:@"pageNum"];
    [dict setValue:@"10" forKey:@"pageSize"];
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:getMediaPageInfo parms:dict success:^(id JSON) {
        self.imageAndVideos = [SGImageAndVideoModel mj_objectArrayWithKeyValuesArray:JSON[@"data"][@"list"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } :^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SGPictureAndVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SGPictureAndVideoCellID forIndexPath:indexPath];
    cell.model =self.imageAndVideos[indexPath.item];
    return cell;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageAndVideos.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    SGImageAndVideoModel *model = self.imageAndVideos[indexPath.item];

//    if ([model.sourceType isEqualToString:@"video"]) {
//        SGPlayVideoViewController *videoVC = [[SGPlayVideoViewController alloc]init];
//        videoVC.model = model;
//        videoVC.block = ^{
//            [self loadDataFromHttp];
//        };
//        [self.navigationController pushViewController:videoVC animated:YES];
//    }else{
//        SGPictureAndVideoInfoController *infoVC = [[SGPictureAndVideoInfoController alloc]init];
//        infoVC.model = self.imageAndVideos[indexPath.item];
//        infoVC.block = ^{
//            [self loadDataFromHttp];
//        };
//        [self.navigationController pushViewController:infoVC animated:YES];
//    }



}

@end
