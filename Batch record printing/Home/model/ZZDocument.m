//
//  ZZDocument.m
//  Batch record printing
//
//  Created by 杨健 on 2019/6/14.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "ZZDocument.h"

@implementation ZZDocument
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    self.data = contents;
    return YES;
}

@end
