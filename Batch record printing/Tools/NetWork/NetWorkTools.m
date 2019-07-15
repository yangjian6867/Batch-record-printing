//
//  NetWorkTools.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/3/30.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "NetWorkTools.h"
#import "LoginViewController.h"
@implementation NetWorkTools

single_implementation(NetWorkTools)


-(void)requestWithType:(RequesType)type urlString:(NSString *)urlStr parms:(NSDictionary *)parms success:(HttpSuccessBlock)success :(HttpFailureBlock)failure {
    
    //[AFJSONResponseSerializer serializer].removesKeysWithNullValues = YES;
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    
    if ([urlStr containsString:addCppcdj] || [urlStr containsString:addTtsScltxxcjBase]) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }else{
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    
    //需不需要加token
    Account *account = [FXUserTool sharedFXUserTool].account;
    if (account) {
        [self.requestSerializer setValue:account.token forHTTPHeaderField:@"token"];
        if ([urlStr isEqualToString:addTtsScltxxcjBase]) {
            [self.requestSerializer setValue:account.userId forHTTPHeaderField:@"id"];
        }
    }
    
    
    NSString *requestUrl = [MaiURL stringByAppendingString:urlStr];
    NSLog(@"requestUrl = %@ parms = %@",requestUrl,parms);
    [SVProgressHUD show];
    void(^sccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            [SVProgressHUD dismiss];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }else{
           NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(responseDict);
        }
    };
    
    void(^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        failure(error);
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *code = [NSString stringWithFormat:@"%@",dict[@"httpCode"]];
        if([code isEqualToString:@"401"]) {
            [SVProgressHUD showErrorWithStatus:@"您的账号已在其他地方登录，请重新登录"];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];;
        }
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    };
    
    if (type == RequesTypeGET) {
        [self GET:requestUrl parameters:parms progress:nil success:sccessBlock failure:failureBlock];
    }else {
        [self POST:requestUrl parameters:parms progress:nil success:sccessBlock failure:failureBlock];
    }
}


-(void)downloadWithPath:(NSString *)path completionHandler:(void (^)(NSURL *filePath, NSError *error))completionHandler{
    
    //需不需要对汉字进行编码这里主要是遇到中文的情况
    //NSString *transcodingPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    NSURLSessionDownloadTask *downLoadTsk = [self downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //计算文件的下载进度
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *fullpath = [[NSFileManager cachesPath] stringByAppendingPathComponent:path.lastPathComponent];
        return [NSURL fileURLWithPath:fullpath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completionHandler(filePath,error);
    }];
    
    [downLoadTsk resume];
}

-(void)uploadFileWithPath:(NSString *)path fileData:(NSData *)data fileName:(NSString *)name progress:(void (^)(NSProgress *))uploadProgressBlock success:(void (^)( NSString *))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *requestUrl = [MaiURL stringByAppendingString:path];
    
    [self POST:requestUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"file" fileName:name mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        uploadProgressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseObjectDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *filePath = responseObjectDict[@"path"];
        success(filePath);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end

