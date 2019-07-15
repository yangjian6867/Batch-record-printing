//
//  FXJIDITableViewController.h
//  Batch record printing
//
//  Created by SG on 2019/6/25.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXJIDIModel;
NS_ASSUME_NONNULL_BEGIN

@interface FXJIDITableViewController : UITableViewController
@property (nonatomic,copy) void (^callBackBlock) (FXJIDIModel *model);
@property(nonatomic,assign)BOOL fromMe;
@end

NS_ASSUME_NONNULL_END
