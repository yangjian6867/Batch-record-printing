//
//  iCloudManager.h
//  Batch record printing
//
//  Created by 杨健 on 2019/6/14.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^downloadBlock)(id obj);

@interface iCloudManager : NSObject
+ (BOOL)iCloudEnable;

+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block;

@end

NS_ASSUME_NONNULL_END
