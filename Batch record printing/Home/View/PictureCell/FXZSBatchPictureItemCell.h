//
//  SlaughterImagItemCell.h
//  Enterprise
//
//  Created by SG on 2018/11/20.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXZSBatchPictureItemCell;

@protocol sgFarmActivitiyPictureItemCellDelegate <NSObject>

-(void)sgFarmActivitiyPictureItemCellDelted:(FXZSBatchPictureItemCell *_Nullable)itemCell;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FXZSBatchPictureItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *deletedBtn;
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,assign)id<sgFarmActivitiyPictureItemCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
