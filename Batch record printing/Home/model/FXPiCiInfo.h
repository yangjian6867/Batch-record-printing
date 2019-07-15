//
//  FXPiCiInfo.h
//  Batch record printing
//
//  Created by SG on 2019/7/10.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXPiCiInfo : NSObject
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *productSort;
@property(nonatomic,assign)NSTimeInterval harvestTime;
@property(nonatomic,copy)NSString *productAmount;
@property(nonatomic,copy)NSString *storeCount;
@property(nonatomic,copy)NSString *harvestUnit;
@property(nonatomic,copy)NSString *productPc;
@property(nonatomic,copy)NSString *productSource;
@property(nonatomic,copy)NSString *mediCheck;
@property(nonatomic,copy)NSString *mediResult;
@property(nonatomic,copy)NSString *harvestBasename;
@property(nonatomic,copy)NSString *freezeCount;
@end

NS_ASSUME_NONNULL_END
