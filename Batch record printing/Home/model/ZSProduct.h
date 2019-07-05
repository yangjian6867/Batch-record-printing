//
//  ZSProduct.h
//  Batch record printing
//
//  Created by SG on 2019/7/5.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSProduct : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *TYPE_NAME;
@property (nonatomic, copy) NSString *NAME;
@property (nonatomic, copy) NSString *PRODUCT_CODE;
@end

NS_ASSUME_NONNULL_END
