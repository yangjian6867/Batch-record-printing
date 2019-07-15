//
//  SGPageInfoController.m
//  Batch record printing
//
//  Created by SG on 2019/7/12.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "SGPageInfoController.h"
#import "SGPageInfo.h"
#import "SGPageInfoViewCell.h"

@interface SGPageInfoController ()
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableDictionary *requestDict;
@end

@implementation SGPageInfoController

static NSString *const SGPageInfoViewCellID = @"SGPageInfoViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的产品";
    
    self.datas = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:SGPageInfoViewCellID bundle:nil] forCellReuseIdentifier:SGPageInfoViewCellID];
    self.tableView.rowHeight = 80;
    
    [self loadNewItems];
}

- (void)loadNewItems{
    
    Account *account = [FXUserTool sharedFXUserTool].account;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:account.userId forKey:@"id"];
    [dict setValue:@"1" forKey:@"start"];
    [dict setValue:@"10" forKey:@"length"];
    [self.datas removeAllObjects];
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:getPageInfo parms:dict success:^(id JSON) {
        NSArray *arr = [SGPageInfo mj_objectArrayWithKeyValuesArray:JSON[@"data"][@"list"]];
        
        for (SGPageInfo *model in arr) {
            if ([model.SLAUGHTER_STATUS integerValue] == 1) {
                [self.datas addObject:model];
            }
        }
        [self.tableView reloadData];
    } :^(NSError *error) {
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SGPageInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SGPageInfoViewCellID forIndexPath:indexPath];
    cell.pageInfo = self.datas[indexPath.row];
    
    return cell;
}

@end
