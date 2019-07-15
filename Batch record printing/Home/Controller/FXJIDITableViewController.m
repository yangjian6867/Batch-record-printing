//
//  FXJIDITableViewController.m
//  Batch record printing
//
//  Created by SG on 2019/6/25.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "FXJIDITableViewController.h"
#import "FXJIDiViewModel.h"
#import "FXJIDIModel.h"
#import "FXJIDITableViewCell.h"
#import "FXJiDiInfoViewController.h"
@interface FXJIDITableViewController ()
@property (nonatomic,strong)NSMutableArray *jidiListArr;
@property (nonatomic,assign)FXJIDIModel *preJiModel;
@property (nonatomic,assign)FXJIDIModel *selectedModel;
@end

@implementation FXJIDITableViewController

-(NSMutableArray *)jidiListArr{
    if (_jidiListArr ==nil) {
        _jidiListArr = [NSMutableArray array];
    }
    return _jidiListArr;
}

static NSString *const FXJIDITableViewCellID = @"FXJIDITableViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.fromMe) {
        self.title = @"基地管理";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addJiDI)];
    }else{
        self.title = @"选择基地";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction)];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:FXJIDITableViewCellID bundle:nil] forCellReuseIdentifier:FXJIDITableViewCellID];
    self.tableView.rowHeight = 70;
    
    [self loadNewItems];
}

-(void)loadNewItems{
    [self.jidiListArr removeAllObjects];
    [FXJIDiViewModel getJIDiList:^(NSArray<FXJIDIModel *> * models) {
        
        for (FXJIDIModel *model in models) {
            model.fromMe = self.fromMe;
        }
        
        [self.jidiListArr addObjectsFromArray:models];
        [self.tableView reloadData];
    }];
}

-(void)addJiDI{
    FXJiDiInfoViewController *infoVc = [[FXJiDiInfoViewController alloc]init];
    infoVc.fromMe = self.fromMe;
    infoVc.refreshDataBlock = ^{
        [self loadNewItems];
    };
    
    [self.navigationController pushViewController:infoVc animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jidiListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXJIDITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FXJIDITableViewCellID forIndexPath:indexPath];
    cell.model = self.jidiListArr[indexPath.row];
    cell.clickBlock = ^(FXJIDIModel * model) {
        self.preJiModel.selected = !self.preJiModel.selected;
        self.selectedModel = model;
        NSMutableArray *reloaIndexPaths = [NSMutableArray array];
        if (self.preJiModel) {
            [reloaIndexPaths addObject:[self getIndexPathWith:self.preJiModel]];
        }
        [reloaIndexPaths addObject:[self getIndexPathWith:model]];

        [tableView reloadRowsAtIndexPaths:reloaIndexPaths withRowAnimation:UITableViewRowAnimationNone];
        self.preJiModel = model;
    };
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    FXJiDiInfoViewController *jidiinfoVC = [[FXJiDiInfoViewController alloc]init];
    jidiinfoVC.selectedJiDi = self.jidiListArr[indexPath.row];
    [self.navigationController pushViewController:jidiinfoVC animated:YES];
}

//根据一个j基地模型返回indexpath;
-(NSIndexPath *)getIndexPathWith:(FXJIDIModel *)model{
    return [NSIndexPath indexPathForRow:[self.jidiListArr indexOfObject:model] inSection:0];
}

-(void)sureAction{
    if (!self.selectedModel) {
        [SVProgressHUD showErrorWithStatus:@"请至少选择一项"];
    }else{
        if (self.callBackBlock) {
           self.callBackBlock(self.selectedModel);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
