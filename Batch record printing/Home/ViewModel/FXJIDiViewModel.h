//
//  FXJIDiViewModel.h
//  Batch record printing
//
//  Created by SG on 2019/6/25.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXJIDIModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FXJIDiViewModel : NSObject

+(void)getJIDiList:(void (^)(NSArray<FXJIDIModel*> *))completionHandler;

@end

NS_ASSUME_NONNULL_END
