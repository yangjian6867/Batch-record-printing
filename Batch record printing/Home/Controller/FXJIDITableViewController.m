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
    
    self.title = @"基地详情";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction)];
    
    [self.tableView registerNib:[UINib nibWithNibName:FXJIDITableViewCellID bundle:nil] forCellReuseIdentifier:FXJIDITableViewCellID];
    self.tableView.rowHeight = 70;
    
    [FXJIDiViewModel getJIDiList:^(NSArray<FXJIDIModel *> * models) {
        [self.jidiListArr addObjectsFromArray:models];
        [self.tableView reloadData];
    }];
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
