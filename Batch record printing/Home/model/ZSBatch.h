//
//  ZSBatch.h
//  Batch record printing
//
//  Created by 杨健 on 2019/6/13.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSBatch : NSObject
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *detail;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *key;
@property (nonatomic,copy)NSString *behavior;
@property (nonatomic,strong)NSArray *popvalues;
@property (nonatomic,copy)NSString *nextValue;
@end


NS_ASSUME_NONNULL_END
