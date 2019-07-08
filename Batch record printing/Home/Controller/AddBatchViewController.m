//
//  HomeTableViewController.m
//  Batch record printing
//
//  Created by 杨健 on 2019/6/13.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "AddBatchViewController.h"
#import "ZSBatch.h"
#import "FXJIDIModel.h"
#import "FXZSBatchViewCell.h"
#import "NetWorkTools.h"
#import "FXJIDITableViewController.h"
#import "FXZSBatchPictureCell.h"
#import "FXZSBatchRemarkCell.h"
#import "ZSProduct.h"
#import "ZSProductUnit.h"

@interface AddBatchViewController ()<UIDocumentPickerDelegate,UIDocumentInteractionControllerDelegate,KXPickerViewDelegate,KXDatePickerViewDelegate>
@property (nonatomic,strong)NSArray *productes;
@property (nonatomic,strong)NSArray *productUnits;
@end

@implementation AddBatchViewController

-(NSMutableDictionary *)uploadDict{
    if (_uploadDict == nil) {
        _uploadDict = [NSMutableDictionary dictionary];
    }
    return _uploadDict;
}

-(KXDatePickerView *)datePickView{
    if (!_datePickView) {
        _datePickView = [[KXDatePickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, 200)titleColor:MAINCOLOR];
        _datePickView.delegate = self;
    }
    return _datePickView;
}

-(KXPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[KXPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, 200) titleColor:MAINCOLOR];
        _pickView.delegate = self;
    }
    return _pickView;
}

-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _coverView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeCoverView)];
        [_coverView addGestureRecognizer:tap];
        _coverView.alpha = 0.4;
    }
    return _coverView;
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"批次管理";
    
    [self getDataFromFile:@"PlantHarvest"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FXZSBatchViewCell" bundle:nil] forCellReuseIdentifier:FXZSBatchViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FXZSBatchPictureCell" bundle:nil] forCellReuseIdentifier:FXZSBatchPictureCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FXZSBatchRemarkCell" bundle:nil] forCellReuseIdentifier:FXZSBatchRemarkCellID];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
}


-(void)getDataFromFile:(NSString *)name{
    NSArray *array = [NSArray readLocalFileWithName:name];
    self.datas = [ZSBatch mj_objectArrayWithKeyValuesArray:array];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    ZSBatch *batch = self.datas[indexPath.row];

    if ([batch.type isEqualToString:@"collectionView"]) {//如果是图片cell
        FXZSBatchPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:FXZSBatchPictureCellID forIndexPath:indexPath];
        cell.rootVC = self;
        cell.type = [batch.name containsString:@"图片"] ? FXZSBatchTypePicture : FXZSBatchTypeVideo;
        cell.batch = batch;
        return cell;
    }else if ([batch.type isEqualToString:@"textView"]){//如果是备注cell
        FXZSBatchRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:FXZSBatchRemarkCellID forIndexPath:indexPath];
        cell.batch = batch;
        return cell;
    }else{//普通cell
        FXZSBatchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FXZSBatchViewCellID forIndexPath:indexPath];
        cell.batch = batch;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZSBatch *batch = self.datas[indexPath.row];
    return batch.height ? batch.height : 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    self.selectedBatch = self.datas[indexPath.row];
    self.selectedIndexPath = indexPath;
    NSString *behavior = self.selectedBatch.behavior;
    if ([behavior isEqualToString:@"pop"]) {
         if (indexPath.row == 0){
            [self requestProduct];
         }else if (indexPath.row == 1) {
            [kWindown addSubview:self.coverView];
            [kWindown addSubview:self.datePickView];
        }else if (indexPath.row == 3){
            [self requestUnit];
        }else{
            self.pickView.dataArray = self.selectedBatch.popvalues;
            [self showPickView];
        }
    }else if ([behavior isEqualToString:@"next"]){
        if ([self.selectedBatch.nextValue isEqualToString:@"FXJIDITableViewController"]) {
            FXJIDITableViewController *jidiVC = [[FXJIDITableViewController alloc]init];;
            jidiVC.callBackBlock = ^(FXJIDIModel * _Nonnull model) {
                [self.uploadDict setValue:model.ID forKey:@"harvestBaseid"];
                [self.uploadDict setValue:model.name forKey:@"harvestBasename"];
                self.selectedBatch.detail = model.NAME;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:jidiVC animated:YES];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark -- 弹出选择框
-(void)showPickView{
    [kWindown addSubview:self.coverView];
    [kWindown addSubview:self.pickView];
}

#pragma mark -- 请求产品种类
-(void)requestProduct{
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:getProductByTerm parms:@{@"industry":@"01",@"start":@"1",@"length":@"10",@"entity_id":[FXUserTool sharedFXUserTool].account.userId} success:^(id JSON) {
        
        self.productes = [ZSProduct mj_objectArrayWithKeyValuesArray:JSON[@"data"][@"list"]];
        self.selectedBatch.popvalues = self.productes;
        self.pickView.dataArray = [self.productes valueForKeyPath:@"NAME"];;
        [self showPickView];
        
    } :^(NSError *error) {
        
    }];
}

#pragma mark -- 请求单位
-(void)requestUnit{
  
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:getUnits parms:@{@"id":@"33a6dbab71c04079a8a41d5e725d2b3d100ec0d3dbc44f67963ffb54014fb607"} success:^(id JSON) {
        
        self.productUnits = [ZSProductUnit mj_objectArrayWithKeyValuesArray:JSON];
        self.selectedBatch.popvalues = self.productUnits;
        self.pickView.dataArray = [self.productUnits valueForKeyPath:@"dictName"];;
        [self showPickView];
        
    } :^(NSError *error) {
        
    }];
}


- (void)kxPickerViewDidSelectedPickerViewRow:(NSInteger)selectedRow{
    [self removeCoverView];
    self.selectedBatch.detail = self.pickView.dataArray[selectedRow];
    
    if ([self.selectedBatch.name isEqualToString:@"产品名称"]) {
        ZSProduct *product = self.selectedBatch.popvalues[selectedRow];
        self.uploadDict[@"productSort"] = product.TYPE_NAME;
        self.uploadDict[@"productId"] = product.PRODUCT_CODE;
    }else if ([self.selectedBatch.name isEqualToString:@"单位"]){
        ZSProductUnit *unit = self.selectedBatch.popvalues[selectedRow];
        self.selectedBatch.detailID = unit.ID;
    }
    
    
    [self refreshDataWithRow:self.selectedIndexPath];
}

-(void)kxDatePickerdidSelectedPickerViewRow:(NSString *)selectedDateString{
    [self removeCoverView];
    self.selectedBatch.detail = selectedDateString;
    self.uploadDict[@"harvestTime"] = selectedDateString;
    [self refreshDataWithRow:[NSIndexPath indexPathForRow:1 inSection:0]];
}

-(void)refreshDataWithRow:(NSIndexPath *)indexPath{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)kxPickerViewCancelPickerViewRow{
    [self removeCoverView];
}
-(void)kxDatePickerCancelSelectedPickerView{
    [self removeCoverView];
}

#pragma mark -- 取消所有选择
-(void)removeCoverView{
    [self.coverView removeFromSuperview];
    [self.datePickView removeFromSuperview];
    [self.pickView removeFromSuperview];
}


-(void)save{
    
    Account *count = [FXUserTool sharedFXUserTool].account;
    
    
    for (ZSBatch *batch in self.datas) {
        if (!batch.detail) {
            NSString *popMessage = [NSString stringWithFormat:@"请%@%@",[batch.type isEqualToString:@"textLabel"] ? @"选择":@"输入",batch.name];
            [SVProgressHUD showErrorWithStatus:popMessage];
            return;
        }
    }
    
    for (ZSBatch *batch in self.datas) {
        [self.uploadDict setValue:batch.detailID ? batch.detailID : batch.detail forKey:batch.key];
    }
    
    //补充字段
    self.uploadDict[@"joinFlag"] = @"1";
     self.uploadDict[@"productIndustry"] = @"01";
    self.uploadDict[@"tempEnId"] = count.userId;
    NSLog(@"self.uploadDict = %@",self.uploadDict);
    
    
    
}

@end
