//
//  iCloudManager.m
//  Batch record printing
//
//  Created by 杨健 on 2019/6/14.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "iCloudManager.h"
#import "ZZDocument.h"

@implementation iCloudManager

+ (BOOL)iCloudEnable {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
    
    if (url != nil) {
        return YES;
    }
    
    NSLog(@"iCloud 不可用");
    return NO;
}
+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block {
    
    ZZDocument *iCloudDoc = [[ZZDocument alloc]initWithFileURL:url];
    
    [iCloudDoc openWithCompletionHandler:^(BOOL success) {
        if (success) {
            
            [iCloudDoc closeWithCompletionHandler:^(BOOL success) {
                NSLog(@"关闭成功");
            }];
            
            if (block) {
                block(iCloudDoc.data);
            }
            
        }
    }];
}


@end
