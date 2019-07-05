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

@interface FXJiDiInfoViewController ()
@property (nonatomic,strong)NSArray *datas;
@property (nonatomic,strong)NSArray *details;
@end

@implementation FXJiDiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"基地详情";
    
    NSArray *arr = [NSArray readLocalFileWithName:@"JIDI"];
    self.datas =  [ZSBatch mj_objectArrayWithKeyValuesArray:arr];
  
    [self.tableView registerNib:[UINib nibWithNibName:FXZSBatchViewCellID bundle:nil] forCellReuseIdentifier:FXZSBatchViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:FXZSBatchPictureCellID bundle:nil] forCellReuseIdentifier:FXZSBatchPictureCellID];
    self.details = @[self.selectedJiDi.NAME,self.selectedJiDi.ADDRESS_NAME,self.selectedJiDi.ADDRESS,self.selectedJiDi.AREA,self.selectedJiDi.MANAGER,self.selectedJiDi.PHONE,[self.selectedJiDi.STATUS isEqualToString:@"Y"] ? @"启用" : @"停用",self.selectedJiDi.PICTURE];
    
    for (int i = 0; i<self.details.count; i++) {
        ZSBatch *batch = self.datas[i];
        batch.detail = self.details[i];
        batch.showInfo = YES;
    }
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.details.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZSBatch *batch = self.datas[indexPath.row];
    return batch.height ? batch.height : 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZSBatch *batch = self.datas[indexPath.row];
    
    if ([batch.type isEqualToString:@"collectionView"]) {//如果是图片cell
        FXZSBatchPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:FXZSBatchPictureCellID forIndexPath:indexPath];
        cell.batch = batch;
        return cell;
    }else{//普通cell
        FXZSBatchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FXZSBatchViewCellID forIndexPath:indexPath];
        cell.batch = batch;
        return cell;
    }
    
}

@end
