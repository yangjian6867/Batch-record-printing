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

@interface FXJiDiInfoViewController ()
@property (nonatomic,strong)NSArray *datas;
@property (nonatomic,strong)NSArray *details;
@end

@implementation FXJiDiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = [NSArray readLocalFileWithName:@"JIDI"];
    self.datas =  [ZSBatch mj_objectArrayWithKeyValuesArray:arr];
    
     [self.tableView registerNib:[UINib nibWithNibName:FXZSBatchViewCellID bundle:nil] forCellReuseIdentifier:FXZSBatchViewCellID];
    
    NSString *longAndLatitudeStr = [NSString stringWithFormat:@"%@%@",self.selectedJiDi.LATITUDE,self.selectedJiDi.LONGITUDE];
    self.details = @[self.selectedJiDi.NAME,self.selectedJiDi.ADDRESS_NAME,longAndLatitudeStr,self.selectedJiDi.ADDRESS,self.selectedJiDi.PRODUCT_NAMES,self.selectedJiDi.AREA,self.selectedJiDi.MANAGER,self.selectedJiDi.PHONE,self.selectedJiDi.STATUS];
    
    for (int i = 0; i<self.details.count; i++) {
        FXJIDIModel *model = self.datas[i];
        model.detail = self.details[i];
    }
    [self.tableView reloadData];
    self.tableView.rowHeight = 50;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.datas.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXZSBatchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FXZSBatchViewCellID forIndexPath:indexPath];
    cell.batch = self.datas[indexPath.row];
    return cell;
}

@end
