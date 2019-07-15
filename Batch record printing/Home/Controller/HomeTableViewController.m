//
//  HomeTableViewController.m
//  Batch record printing
//
//  Created by SG on 2019/7/4.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "HomeTableViewController.h"
#import "AddBatchViewController.h"
#import "FXPICI.h"
#import "FXHomeTableViewCell.h"
#import "HomeDetailViewController.h"

@interface HomeTableViewController ()
@property (nonatomic,strong)NSMutableArray *picis;
@property (nonatomic,strong)NSMutableDictionary *requestDict;
@end

@implementation HomeTableViewController

-(NSMutableDictionary *)requestDict{
    if (!_requestDict) {
        _requestDict = [NSMutableDictionary dictionary];
        _requestDict[@"length"] = @"10";
        _requestDict[@"entity_id"] = [FXUserTool sharedFXUserTool].account.userId;
    }
    return _requestDict;
}

static NSString *const FXHomeTableViewCellID = @"FXHomeTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"批次管理";
    self.tableView.rowHeight = 80;
    
    [self.tableView registerNib:[UINib nibWithNibName:FXHomeTableViewCellID bundle:nil] forCellReuseIdentifier:FXHomeTableViewCellID];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewItems)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreItems)];
    [self loadNewItems];
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
        [self.tableView reloadData];
    } :^(NSError *error) {
        [self tableViewEndRefresh];
    }];
}

-(void)tableViewEndRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.picis.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FXHomeTableViewCellID forIndexPath:indexPath];
    cell.pici = self.picis[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FXPICI *pici = self.picis[indexPath.row];
    
    HomeDetailViewController *homeDetailVC = [[HomeDetailViewController alloc]init];
    homeDetailVC.productID = pici.ID;
    [self.navigationController pushViewController:homeDetailVC animated:YES];
}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        
        //[self.listArrayremoveObjectAtIndex:indexPath.row];//删除数据源当前行数据
        //[tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(UISwipeActionsConfiguration*)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)){
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self delUserProduct:indexPath];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    UISwipeActionsConfiguration *actions = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
    actions.performsFirstActionWithFullSwipe = NO;
    return actions;
}


#pragma MARK - 删除产品
-(void)delUserProduct:(NSIndexPath *)indexPath{
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:deleteTtsScltxxcjScgl parms:@{@"id":[FXUserTool sharedFXUserTool].account.userId} success:^(id JSON) {
        [SVProgressHUD showSuccessWithStatus:@"删除成功"];
        [self.picis removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    } :^(NSError *error) {
        
    }];
    
}


- (IBAction)addBatchAction:(id)sender {
    
    AddBatchViewController *addVc = [[AddBatchViewController alloc]init];
    addVc.refreshDataBlock = ^{
        [self loadNewItems];
    };
    [self.navigationController pushViewController:addVc animated:YES];
    
}

@end
