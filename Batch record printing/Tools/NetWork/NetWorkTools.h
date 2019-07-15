//
//  NetWorkTools.h
//  NewHuangguan
//
//  Created by 杨健 on 2017/3/30.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
typedef void(^HttpSuccessBlock)(id JSON);
typedef void(^HttpFailureBlock)(NSError *error);
typedef void(^CallBackBlock)(BOOL success,id data);

typedef enum : NSUInteger {
    RequesTypeGET,
    RequesTypePOST,
} RequesType;


@interface NetWorkTools : AFHTTPSessionManager
single_interface(NetWorkTools)

-(void)requestWithType:(RequesType)type urlString:(NSString *)urlStr parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure;
//下载文件
-(void)downloadWithPath:(NSString *)path completionHandler:(void(^)(NSURL *filePath, NSError *error))completionHandler;
//上传文件

-(void)uploadFileWithPath:(NSString *)path
                 fileData:(NSData *)data
                 fileName:(NSString *)name progress:(nullable void (^)(NSProgress * progress))uploadProgressBlock
                 success:(nullable void (^)(NSString * filePath))success
                 failure:(nullable void (^)(NSError * _Nonnull error))failure;
@end

