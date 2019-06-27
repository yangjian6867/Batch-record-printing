//
//  FXJIDITableViewCell.h
//  Batch record printing
//
//  Created by SG on 2019/6/25.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXJIDIModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FXJIDITableViewCell : UITableViewCell
@property (nonatomic,strong)FXJIDIModel *model;
@property (nonatomic,copy) void (^clickBlock) (FXJIDIModel *currentModel);

@end

NS_ASSUME_NONNULL_END
