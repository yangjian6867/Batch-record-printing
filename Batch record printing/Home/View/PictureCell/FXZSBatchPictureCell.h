//
//  SlaughterImagAndVideoCell.h
//  Enterprise
//
//  Created by SG on 2018/11/20.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSBatch.h"
@class FXZSBatchPictureCell;


@protocol SGFarmActivitiyPictureCellDelegate <NSObject>

-(void)sgFarmActivitiyPictureCellClick:(NSIndexPath*)indexPath;

-(void)sgFarmActivitiyPictureCellDeleted:(NSIndexPath *)indexPath;
@end


NS_ASSUME_NONNULL_BEGIN

@interface FXZSBatchPictureCell : UITableViewCell
@property (nonatomic,assign)id<SGFarmActivitiyPictureCellDelegate> delegate;
@property (nonatomic,strong)ZSBatch *batch;
@end

NS_ASSUME_NONNULL_END
