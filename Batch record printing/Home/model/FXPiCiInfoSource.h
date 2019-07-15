//
//  FXPiCiInfoSource.h
//  Batch record printing
//
//  Created by SG on 2019/7/10.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXPiCiInfoSource : NSObject
@property(nonatomic,copy)NSString *sourcePath;
@property(nonatomic,copy)NSString *sourceName;
@property(nonatomic,copy)NSString *sourceType;
@end

NS_ASSUME_NONNULL_END
