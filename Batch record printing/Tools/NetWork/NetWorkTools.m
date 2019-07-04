//
//  NetWorkTools.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/3/30.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "NetWorkTools.h"

@implementation NetWorkTools

single_implementation(NetWorkTools)


-(void)requestWithType:(RequesType)type urlString:(NSString *)urlStr parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure {
    
    //[AFJSONResponseSerializer serializer].removesKeysWithNullValues = YES;
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",@"application/x-www-form-urlencoded;charset=utf-8",nil];
    
    //传的参数是否是json
    //self.requestSerializer = [AFJSONRequestSerializer serializer];
    //self.responseSerializer = [AFJSONResponseSerializer serializer];
   
    
    
    //需不需要加token
    Account *account = [FXUserTool sharedFXUserTool].account;
    if (account) {
        [self.requestSerializer setValue:account.token forHTTPHeaderField:@"token"];
    }
    
    
    NSString *requestUrl = [MaiURL stringByAppendingString:urlStr];
    NSLog(@"requestUrl = %@ parms = %@",requestUrl,parms);
    [SVProgressHUD show];
    void(^sccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            [SVProgressHUD dismiss];
           success(responseObject);
        };
    
    void(^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        failure(error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    };
    
    if (type == RequesTypeGET) {
        [self GET:requestUrl parameters:parms progress:nil success:sccessBlock failure:failureBlock];
    }else {
        [self POST:requestUrl parameters:parms progress:nil success:sccessBlock failure:failureBlock];
    }
}


-(void)downloadWithPath:(NSString *)path completionHandler:(void (^)(NSURL *filePath, NSError *error))completionHandler{
    
    //需不需要对汉字进行编码
    //NSString *transcodingPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    NSURLSessionDownloadTask *downLoadTsk = [self downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //计算文件的下载进度
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *fullpath = [[NSFileManager cachesPath] stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:fullpath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completionHandler(filePath,error);
    }];
    
    [downLoadTsk resume];
}

@end

