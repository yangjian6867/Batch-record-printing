//
//  SGImageAndVideoModel.m
//  Enterprise
//
//  Created by SG on 2018/10/24.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import "SGImageAndVideoModel.h"

@implementation SGImageAndVideoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

- (void)setResourceUrl:(NSString *)resourceUrl{
    _resourceUrl = [NSString stringWithFormat:@"%@%@%@", MaiURL, kImagePre, resourceUrl];
}

- (void)setSourcePath:(NSString *)sourcePath{
    _sourcePath = [NSString stringWithFormat:@"%@%@%@", MaiURL, kImagePre, sourcePath];
}

@end
