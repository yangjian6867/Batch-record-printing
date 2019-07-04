//
//  SGAddFarmActivitiyCell.h
//  SGRetrospect
//
//  Created by SG on 2018/11/26.
//  Copyright © 2018 com.sofn.lky.retrospect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSBatch.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^ZSBatchCellBlock)(NSString *);

@interface FXZSBatchViewCell : UITableViewCell
@property (nonatomic,strong)ZSBatch *batch;
@property (nonatomic,copy)ZSBatchCellBlock block;

@end

NS_ASSUME_NONNULL_END
