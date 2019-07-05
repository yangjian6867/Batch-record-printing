//
//  SGImageAndVideoModel.h
//  Enterprise
//
//  Created by SG on 2018/10/24.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGImageAndVideoModel : NSObject
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * resourceType;
@property (nonatomic, copy) NSString * resourceName;
@property (nonatomic, copy) NSString * resourceUrl;
@property (nonatomic, copy) NSString * sourcePath;
@property (nonatomic, copy) NSString * sourceName;
@property (nonatomic, copy) NSString * sourceType;
@property (nonatomic,assign)BOOL isSelected;
@property(nonatomic,strong)NSURL *filePath;
@property(nonatomic,strong)UIImage *fileImage;
@property(nonatomic,copy)NSString *fullPath;

@end

NS_ASSUME_NONNULL_END
