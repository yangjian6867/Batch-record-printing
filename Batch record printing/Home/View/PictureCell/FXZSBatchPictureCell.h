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


typedef enum : NSUInteger {
    FXZSBatchTypePicture,
    FXZSBatchTypeVideo,
} FXZSBatchType;

@protocol FXZSBatchPictureCellDelegate <NSObject>

-(void)fXZSBatchPictureCellClick:(NSIndexPath *_Nonnull)indexPath;

-(void)fXZSBatchPictureCellDeleted:(NSIndexPath *_Nonnull)indexPath;
@end


NS_ASSUME_NONNULL_BEGIN

@interface FXZSBatchPictureCell : UITableViewCell
@property (nonatomic,assign)id<FXZSBatchPictureCellDelegate> delegate;
@property (nonatomic,strong)ZSBatch *batch;
@property (nonatomic,strong)UIViewController *rootVC;
@property (nonatomic,assign)FXZSBatchType type;
@property (nonatomic,assign)BOOL fromPiCi;
@end

NS_ASSUME_NONNULL_END
