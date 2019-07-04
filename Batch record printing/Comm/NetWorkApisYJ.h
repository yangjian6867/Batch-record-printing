//
//  NetWorkAposYJ.h
//  ChongZhouPrint
//
//  Created by SG on 2019/7/3.
//  Copyright © 2019 com.sofn.lky. All rights reserved.
//

#ifndef NetWorkApisYJ_h
#define NetWorkApisYJ_h

#define kUserId [SGAccountTool sharedSGAccountTool].account.userid

//获取用户产品
static NSString *const getUserProductList= @"/sysUserProduct/getUserProductList";
//获取行业
static NSString *const getSysDictLists=@"/syaDict/getSysDictLists";
//根据行业获取对应产品
static NSString *const getSysArgiProductList=@"/sysArgiProduct/getSysArgiProductList";
//添加产品
static NSString *const saveUserProduct=@"/sysUserProduct/saveUserProduct";
//更新产品
static NSString *const showUserProduct=@"/sysUserProduct/showUserProduct";
//删除产品
static NSString *const delUserProduct=@"/sysUserProduct/delUserProduct";

//生产人
static NSString *const getProductPersonList=@"/sysProductPerson/getProductPersonList";
//删除生产人
static NSString *const delProductPerson=@"/sysProductPerson/delProductPerson";
//修改生产人
static NSString *const modifyProductPerson=@"/sysProductPerson/modifyProductPerson";
//显示生产人
static NSString *const showProductPerson=@"/sysProductPerson/showProductPerson";


static NSString *const FXZSBatchViewCellID = @"FXZSBatchViewCell";
static NSString *const FXZSBatchPictureCellID = @"FXZSBatchPictureCell";
static NSString *const FXZSBatchRemarkCellID = @"FXZSBatchRemarkCell";


#endif /* NetWorkAposYJ_h */
