//
//  HomeDetailViewController.m
//  Batch record printing
//
//  Created by SG on 2019/7/10.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "ZSBatch.h"
#import "FXPiCiInfo.h"
#import "FXPiCiInfoSource.h"
#import "FXZSBatchViewCell.h"
#import "FXZSBatchPictureCell.h"
#import "NSObject+Runtime.h"

@interface HomeDetailViewController ()
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)NSMutableArray *details;
@property(nonatomic,strong)NSMutableArray *sources;
@property(nonatomic,strong)FXPiCiInfo *piciInfo;
@property(nonatomic,assign)BOOL havePicutre;
@property(nonatomic,assign)NSInteger haveVideo;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"批次详情";
    
    NSArray *arr = [NSArray readLocalFileWithName:@"PiciInfo"];
    self.datas =  [ZSBatch mj_objectArrayWithKeyValuesArray:arr];
    
    [self.tableView registerNib:[UINib nibWithNibName:FXZSBatchViewCellID bundle:nil] forCellReuseIdentifier:FXZSBatchViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:FXZSBatchPictureCellID bundle:nil] forCellReuseIdentifier:FXZSBatchPictureCellID];
    self.tableView.rowHeight = 55;
    
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:getproductInfo parms:@{@"id":self.productID} success:^(id JSON) {
        
        NSLog(@"JSON = %@",JSON);
        self.piciInfo = [FXPiCiInfo mj_objectWithKeyValues:JSON[@"data"]];
        
        //获取整个对象的所有属性值组成一个数组
        self.details = [self getPropertValues:self.piciInfo];
        NSTimeInterval harvestTime = [self.details[2]doubleValue];
        
        NSString *harvestTimeStr = [NSDate getDateStrFromTimeStamp:harvestTime format:@"yyyy-MM-dd"];
        [self.details replaceObjectAtIndex:2 withObject:harvestTimeStr];
        
        //获取图片视频数据
        self.sources = [FXPiCiInfoSource mj_objectArrayWithKeyValuesArray:JSON[@"batchSources"]];
        
        if (self.sources.count == 0) {
            [self.datas removeObjectsInRange:NSMakeRange(self.datas.count - 2, 2)];
        }else{
           
            NSString *videoUrl;
            NSMutableString *pictureUrl = [NSMutableString string];
            for (FXPiCiInfoSource *source in self.sources) {
                if ([source.sourceType isEqualToString:@"image"]) {
                    [pictureUrl appendFormat:@"%@,",source.sourcePath];
                    self.havePicutre = YES;
                }else{
                    videoUrl = source.sourcePath;
                    self.haveVideo = YES;
                }
            }
            
            if (self.haveVideo && !self.havePicutre) {//有视频没有图片
                [self.datas removeObjectsInRange:NSMakeRange(self.datas.count - 1, 1)];
                [self.details addObject:videoUrl];
            }else if (!self.haveVideo && self.havePicutre){
                [pictureUrl deleteCharactersInRange:NSMakeRange(pictureUrl.length - 1, 1)];
                [self.datas removeLastObject];
                [self.details addObject: pictureUrl];
            }else if (self.haveVideo && self.havePicutre){
                [pictureUrl deleteCharactersInRange:NSMakeRange(pictureUrl.length - 1, 1)];
                [self.details addObject: pictureUrl];
                [self.details addObject:videoUrl];
            }
        }
        
        for (int i = 0; i<self.datas.count; i++) {
            ZSBatch *batch = self.datas[i];
            batch.detail = self.details[i];
            batch.showInfo = YES;
        }
        [self.tableView reloadData];
        
    } :^(NSError *error) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZSBatch *batch = self.datas[indexPath.row];
    return batch.height ? batch.height : 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
