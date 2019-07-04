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

@interface AddBatchViewController ()<UIDocumentPickerDelegate,UIDocumentInteractionControllerDelegate,KXPickerViewDelegate,KXDatePickerViewDelegate>
@property (nonatomic,strong)NSArray *productes;
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
    self.selectedBatch = self.datas[indexPath.row];
    self.selectedRow = indexPath.row;
    NSString *behavior = self.selectedBatch.behavior;
    if ([behavior isEqualToString:@"pop"]) {
        if (indexPath.row == 1) {
            [kWindown addSubview:self.coverView];
            [kWindown addSubview:self.datePickView];
        }else{
            [self showPickView];
        }
    }else if ([behavior isEqualToString:@"next"]){
        if ([self.selectedBatch.nextValue isEqualToString:@"FXJIDITableViewController"]) {
            FXJIDITableViewController *jidiVC = [[FXJIDITableViewController alloc]init];;
            jidiVC.callBackBlock = ^(FXJIDIModel * _Nonnull model) {
                [self.uploadDict setValue:model.ID forKey:@"harvestBaseid"];
                self.selectedBatch.detail = model.NAME;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:jidiVC animated:YES];
        }
    }
}


#pragma mark -- 弹出选择框
-(void)showPickView{
    self.pickView.dataArray = self.selectedBatch.popvalues;
    [kWindown addSubview:self.coverView];
    [kWindown addSubview:self.pickView];
}


- (void)kxPickerViewDidSelectedPickerViewRow:(NSInteger)selectedRow{
    [self removeCoverView];
    self.selectedBatch.detail = self.selectedBatch.popvalues[selectedRow];
    [self refreshDataWithRow:self.selectedRow];
}

-(void)kxDatePickerdidSelectedPickerViewRow:(NSString *)selectedDateString{
    [self removeCoverView];
    self.selectedBatch.detail = selectedDateString;
    [self refreshDataWithRow:1];
}

-(void)refreshDataWithRow:(NSInteger)row{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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

@end
