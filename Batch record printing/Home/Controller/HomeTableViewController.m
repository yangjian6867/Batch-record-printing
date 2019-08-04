#import "HomeTableViewController.h"
#import "AddBatchViewController.h"
#import "FXPICI.h"
#import "SGHomeCollectionCell.h"
#import "HomeDetailViewController.h"
#import "UIViewController+CWLateralSlide.h"
#import "LeftViewController.h"
#import "HomeHeaderReusableView.h"
#import "AppDelegate.h"

@interface HomeTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray *picis;
@property (nonatomic,strong)NSMutableDictionary *requestDict;
@property (nonatomic,strong) LeftViewController *leftVC; //
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation HomeTableViewController

- (LeftViewController *)leftVC {
    if (_leftVC == nil) {
        _leftVC = [LeftViewController new];
    }
    return _leftVC;
}

-(NSMutableDictionary *)requestDict{
    if (!_requestDict) {
        _requestDict = [NSMutableDictionary dictionary];
        _requestDict[@"length"] = @"10";
        _requestDict[@"entity_id"] = [FXUserTool sharedFXUserTool].account.userId;
    }
    return _requestDict;
}

static NSString *const FXHomeTableViewCellID = @"SGHomeCollectionCell";
static NSString *const HomeHeaderReusableViewID = @"HomeHeaderReusableView";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"种植批次管理";
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((UIScreen.screen_width - 30 ) / 2, 140);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.headerReferenceSize = CGSizeMake(UIScreen.screen_width, 160);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:FXHomeTableViewCellID bundle:nil] forCellWithReuseIdentifier:FXHomeTableViewCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HomeHeaderReusableViewID];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewItems)];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreItems)];
    [self loadNewItems];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImagename:@"caidan" hightImagename:nil title:nil target:self action:@selector(openOrCloseLeftList)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagename:@"tianjia" hightImagename:nil title:nil target:self action:@selector(addBatchAction)];
    
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    [self cw_registerShowIntractiveWithEdgeGesture:YES transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
            [weakSelf defaultAnimationFromLeft];
        }
    }];
}
// 仿QQ从左侧划出
- (void)defaultAnimationFromLeft {
    
    // 强引用leftVC，不用每次创建新的,也可以每次在这里创建leftVC，抽屉收起的时候会释放掉
    [self cw_showDefaultDrawerViewController:self.leftVC];
    // 或者这样调用
    //    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:nil];
}

- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

-(void)loadNewItems{
    self.requestDict[@"start"] = @"0";
    [self loadItems:NO];
}

-(void)loadMoreItems{
    self.requestDict[@"start"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.picis.count];
    [self loadItems:YES];
}

-(void)loadItems:(BOOL)isMore{
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:getCpdjgl parms:self.requestDict success:^(id JSON) {
        if (isMore) {
            NSArray *arr = [FXPICI mj_objectArrayWithKeyValuesArray:JSON[@"data"][@"list"]];
            [self.picis addObjectsFromArray:arr];
        }else{
            self.picis = [FXPICI mj_objectArrayWithKeyValuesArray:JSON[@"data"][@"list"]];
        }
        [self tableViewEndRefresh];
        [self.collectionView reloadData];
    } :^(NSError *error) {
        [self tableViewEndRefresh];
    }];
}

-(void)tableViewEndRefresh{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.picis.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SGHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FXHomeTableViewCellID forIndexPath:indexPath];
    cell.pici = self.picis[indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HomeHeaderReusableViewID forIndexPath:indexPath];
        return headerView;
    }else{
        return [[UICollectionReusableView alloc]init];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FXPICI *pici = self.picis[indexPath.row];
    HomeDetailViewController *homeDetailVC = [[HomeDetailViewController alloc]init];
    homeDetailVC.productID = pici.ID;
    [self.navigationController pushViewController:homeDetailVC animated:YES];
}


#pragma MARK - 删除产品
-(void)delUserProduct:(NSIndexPath *)indexPath{
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:deleteTtsScltxxcjScgl parms:@{@"id":[FXUserTool sharedFXUserTool].account.userId} success:^(id JSON) {
        [SVProgressHUD showSuccessWithStatus:@"删除成功"];
        [self.picis removeObjectAtIndex:indexPath.row];
        [self.collectionView reloadData];
    } :^(NSError *error) {
        
    }];
    
}


- (void)addBatchAction{
    
    AddBatchViewController *addVc = [[AddBatchViewController alloc]init];
    addVc.refreshDataBlock = ^{
        [self loadNewItems];
    };
    [self.navigationController pushViewController:addVc animated:YES];
    
}

@end
