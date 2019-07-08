//
//  SGPictureAndVideoController.m
//  Enterprise
//
//  Created by SG on 2018/10/22.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import "SGPictureAndVideoController.h"

#import "SGPictureAndVideoCell.h"

#define kPictureVideoitemW (UIScreen.screen_width - 30)/2

@interface SGPictureAndVideoController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
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
   
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake(kPictureVideoitemW, kPictureVideoitemW);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SGPictureAndVideoCell" bundle:nil] forCellWithReuseIdentifier:SGPictureAndVideoCellID];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewItems)];

    [self.view addSubview:self.collectionView];
     [self loadNewItems];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
}

-(void)saveAction{
    
    NSMutableArray *selectedArr = [NSMutableArray array];
    for (SGImageAndVideoModel *model in self.imageAndVideos) {
        if (model.isSelected) {
            [selectedArr addObject: [model.resourceType containsString:@"video"] ? model.fileImage :  model.resourceUrl];
        }
    }
    
    if (self.type == 0) {
        if (selectedArr.count>3) {
            [SVProgressHUD showErrorWithStatus:@"最多选择3张照片"];
            return;
        }
    }else {
        if (selectedArr.count>1) {
            [SVProgressHUD showErrorWithStatus:@"最多选择1部视频"];
            return;
        }
    }
    
    
    
    self.refreshDataBlock(selectedArr);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadNewItems{

    Account *account = [FXUserTool sharedFXUserTool].account;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:account.userId forKey:@"userId"];
    [dict setValue:@"1" forKey:@"pageNum"];
    [dict setValue:@"10" forKey:@"pageSize"];
    [self.imageAndVideos removeAllObjects];
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:getMediaPageInfo parms:dict success:^(id JSON) {
        NSArray *arr = [SGImageAndVideoModel mj_objectArrayWithKeyValuesArray:JSON[@"data"][@"list"]];
        
        for (SGImageAndVideoModel *model in arr) {
            if (self.type == 0) {
                if ([model.resourceType isEqualToString:@"image"]) {
                    [self.imageAndVideos addObject:model];
                }
            }else{
                if ([model.resourceType isEqualToString:@"video"]) {
                    [self.imageAndVideos addObject:model];
                }
            }
        }
        
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } :^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SGPictureAndVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SGPictureAndVideoCellID forIndexPath:indexPath];
    cell.model =self.imageAndVideos[indexPath.item];
    cell.selectedResourceBlock = ^(NSString * _Nonnull resourceUrl) {
        [collectionView reloadData];
    };
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
