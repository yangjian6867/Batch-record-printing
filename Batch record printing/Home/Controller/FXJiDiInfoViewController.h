//
//  FXJiDiInfoViewController.h
//  Batch record printing
//
//  Created by SG on 2019/7/4.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXJIDIModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FXJiDiInfoViewController : UITableViewController
@property (nonatomic,strong)FXJIDIModel *selectedJiDi;
@end

NS_ASSUME_NONNULL_END
