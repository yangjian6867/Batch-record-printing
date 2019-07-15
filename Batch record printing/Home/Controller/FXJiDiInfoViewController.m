//
//  FXJiDiInfoViewController.m
//  Batch record printing
//
//  Created by SG on 2019/7/4.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "FXJiDiInfoViewController.h"
#import "ZSBatch.h"
#import "FXZSBatchViewCell.h"
#import "FXZSBatchPictureCell.h"
#import "SGNewAddressView.h"
#import "SGSelectAreaModel.h"

@interface FXJiDiInfoViewController ()<SGNewAddressViewDelegate,KXPickerViewDelegate>
@property (nonatomic,strong)NSArray *datas;
@property (nonatomic,strong)NSArray *details;
@property (nonatomic,strong)NSMutableDictionary *uploadDict;
@property(nonatomic,strong)SGNewAddressView *addressView;
@property(nonatomic,strong)UIView *coverView;
@property(nonatomic,strong)NSIndexPath *selectedIndexPath;
@property(nonatomic,strong)ZSBatch *selectedBatch;
@end

@implementation FXJiDiInfoViewController


-(KXPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[KXPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, 200) titleColor:MAINCOLOR];
        _pickView.delegate = self;
    }
    return _pickView;
}


-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.screen_width, UIScreen.screen_height)];
        _coverView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeCoverView)];
        [_coverView addGestureRecognizer:tap];
        _coverView.alpha = 0.4;
    }
    return _coverView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.uploadDict = [NSMutableDictionary dictionary];
    NSArray *arr = [NSArray readLocalFileWithName:@"JIDI"];
    self.datas =  [ZSBatch mj_objectArrayWithKeyValuesArray:arr];
    
    [self.tableView registerNib:[UINib nibWithNibName:FXZSBatchViewCellID bundle:nil] forCellReuseIdentifier:FXZSBatchViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:FXZSBatchPictureCellID bundle:nil] forCellReuseIdentifier:FXZSBatchPictureCellID];
    
    if (self.fromMe) {
        self.title = @"新增基地";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(addJidiAciton)];
    }else{
        self.title = @"基地详情";
     self.details=@[self.selectedJiDi.NAME,self.selectedJiDi.ADDRESS_NAME,self.selectedJiDi.ADDRESS,self.selectedJiDi.AREA,self.selectedJiDi.MANAGER,self.selectedJiDi.PHONE,[self.selectedJiDi.STATUS isEqualToString:@"Y"] ? @"启用" : @"停用",self.selectedJiDi.PICTURE];
        
        for (int i = 0; i<self.details.count; i++) {
            ZSBatch *batch = self.datas[i];
            batch.detail = self.details[i];
            batch.showInfo = YES;
        }
    }
    
    [self.tableView reloadData];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZSBatch *batch = self.datas[indexPath.row];
    return batch.height ? batch.height : 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    
    self.selectedIndexPath = indexPath;
    self.selectedBatch = self.datas[indexPath.row];
    if ([self.selectedBatch.name hasPrefix:@"所属区域"]) {
        self.addressView = [SGNewAddressView initWithXib:CGRectMake(0, UIScreen.screen_height - 407, UIScreen.screen_width, 407)];
        self.addressView.delegate = self;
        [kWindown addSubview:self.coverView];
        [kWindown addSubview:self.addressView];
    }else if ([self.selectedBatch.name hasPrefix:@"基地状态"]){
        self.pickView.dataArray = @[@"启用",@"停用"];
        [kWindown addSubview:self.coverView];
        [kWindown addSubview:self.pickView];
    }
}

-(void)getTheLastModels:(NSDictionary *)dict{
    SGSelectAreaModel *provinceModel = dict[@"Province"];
    SGSelectAreaModel *cityModel = dict[@"city"];
    SGSelectAreaModel *areaModel = dict[@"area"];
    self.selectedBatch.detail = [NSString stringWithFormat:@"%@%@%@", provinceModel.name, cityModel.name, areaModel.name];
    [self reloadCurrentIndexPath];
    self.uploadDict[@"addressCode"] = areaModel.code;
    [self removeCoverView];
}

- (void)kxPickerViewDidSelectedPickerViewRow:(NSInteger)selectedRow{
    self.selectedBatch.detail = self.pickView.dataArray[selectedRow];
    self.selectedBatch.detailID = [self.selectedBatch.detail isEqualToString:@"启用"] ? @"Y" : @"N";
    [self reloadCurrentIndexPath];
    [self removeCoverView];
}

- (void)kxPickerViewCancelPickerViewRow{
    [self removeCoverView];
}

-(void)reloadCurrentIndexPath{
    [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)removeCoverView{
    [self.coverView removeFromSuperview];
    [self.addressView removeFromSuperview];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZSBatch *batch = self.datas[indexPath.row];
    
    if ([batch.type isEqualToString:@"collectionView"]) {//如果是图片cell
        FXZSBatchPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:FXZSBatchPictureCellID forIndexPath:indexPath];
        cell.batch = batch;
        cell.rootVC = self;
        return cell;
    }else{//普通cell
        FXZSBatchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FXZSBatchViewCellID forIndexPath:indexPath];
        cell.batch = batch;
        return cell;
    }
    
}


-(void)addJidiAciton{
    
    for (ZSBatch *batch in self.datas) {
        if (!batch.detail) {
            NSString *popMessage = [NSString stringWithFormat:@"请%@%@",[batch.type isEqualToString:@"textLabel"] ? @"选择":@"输入",batch.name];
            [SVProgressHUD showErrorWithStatus:popMessage];
            return;
        }
    }
    
    for (ZSBatch *batch in self.datas) {
        
        [self.uploadDict setValue: batch.detailID ? batch.detailID : batch.detail forKey:batch.key];
       
    }
    
    self.uploadDict[@"dictName"] = @"圈";
    self.uploadDict[@"latitude"] = @"39.88682";
    self.uploadDict[@"longitude"] = @"116.45388";
    
    Account *account = [FXUserTool sharedFXUserTool].account;
    NSString *lastUrl = [NSString stringWithFormat:@"%@?id=%@",addTtsScltxxcjBase,account.userId];
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:lastUrl parms:self.uploadDict success:^(id JSON) {
        NSLog(@"JSON = %@",JSON);
        [SVProgressHUD showSuccessWithStatus:@"添加成功"];
        self.refreshDataBlock();
        [self.navigationController popViewControllerAnimated:YES];
    } :^(NSError *error) {
        
    }];
}



@end
