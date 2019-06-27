//
//  HomeTableViewController.h
//  Batch record printing
//
//  Created by 杨健 on 2019/6/13.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KXDatePickerView.h"
#import "KXPickerView.h"
#import "ZSBatch.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewController : UITableViewController
@property (nonatomic, strong)KXPickerView *pickView;
@property (nonatomic, strong)KXDatePickerView *datePickView;
@property (nonatomic, strong)UIView *coverView;
@property (nonatomic,strong)NSMutableDictionary *uploadDict;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic, strong)ZSBatch *selectedBatch;
@property (nonatomic,assign)BOOL haveFile;
@property (nonatomic,assign)NSUInteger selectedRow;
@end

NS_ASSUME_NONNULL_END
