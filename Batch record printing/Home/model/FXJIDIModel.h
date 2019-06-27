//
//  FXJIDIModel.h
//  Batch record printing
//
//  Created by SG on 2019/6/25.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXJIDIModel : NSObject
@property (nonatomic, copy) NSString *ADDRESS; // 基地地址
@property (nonatomic, copy) NSString *ADDRESS_CODE; //
@property (nonatomic, copy) NSString *ADDRESS_NAME; //所属区域
@property (nonatomic, copy) NSString *AREA; // 基地面积
@property (nonatomic, copy) NSString *CREATE_BY; //
@property (nonatomic, copy) NSString *CREATE_TIME; //
@property (nonatomic, copy) NSString *DEL_FLAG; //
@property (nonatomic, copy) NSString *ENTITY_IDCODE; //
@property (nonatomic, copy) NSString *ID; //
@property (nonatomic, copy) NSString *LATITUDE; //纬度
@property (nonatomic, copy) NSString *LONGITUDE; //经度
@property (nonatomic, copy) NSString *MANAGER; //基地负责人
@property (nonatomic, copy) NSString *NAME; // 基地名称
@property (nonatomic, copy) NSString *NUM; //
@property (nonatomic, copy) NSString *PHONE; //
@property (nonatomic, copy) NSString *PICTURE; // 图片接口
@property (nonatomic, copy) NSString *PICTURE_TWO; // 第二张图片接口
@property (nonatomic, copy) NSString *PRODUCT_NAMES; // 主要产品
@property (nonatomic, copy) NSString *STATUS; // 基地状态
@property (nonatomic, copy) NSString *UPDATE_BY; //

@property (nonatomic, copy) NSString *UPDATE_TIME; //
@property (nonatomic, copy) NSString *USER_IDCODE; //
@property (nonatomic, copy) NSString *DICT_NAME;
@property (nonatomic,assign)BOOL selected;
@end

NS_ASSUME_NONNULL_END
