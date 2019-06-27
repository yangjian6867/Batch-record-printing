//
//  FXJIDiViewModel.m
//  Batch record printing
//
//  Created by SG on 2019/6/25.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "FXJIDiViewModel.h"

@implementation FXJIDiViewModel

+(void)getJIDiList:(void (^)(NSArray<FXJIDIModel *> * _Nonnull))completionHandler{
    
    NSString *userId = [FXUserTool sharedFXUserTool].account.userId;
    
    NSDictionary *parms = @{@"start":@"0",
                            @"length":@"10",
                            @"id":userId,
                            @"status":@"Y"
                            };
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:BaseListUrl parms:parms success:^(id JSON) {
        
        NSArray *arr = [FXJIDIModel mj_objectArrayWithKeyValuesArray:JSON[@"data"][@"list"]];
        completionHandler(arr);
        
    } :^(NSError *error) {
        
    }];
}


@end
