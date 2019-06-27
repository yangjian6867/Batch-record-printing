//
//  Account.h
//  CityCook
//
//  Created by yang on 16/3/1.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>

@property (nonatomic, copy) NSString *account; // 账号
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userIdcode; //主体用户码
@property (nonatomic, copy) NSString *entityIdcode;  //主体身份码

@property (nonatomic, copy) NSString *enterpriseName; // 企业名称
@property (nonatomic, copy) NSString *entityScale;
@property (nonatomic, copy) NSString *entityScaleName; //主体组织形式字典名称
@property (nonatomic, copy) NSString *entityProperty; //主体属性
@property (nonatomic, copy) NSString *entityPropertyName; //主体属性字典名称
@property (nonatomic, copy) NSString *entityType; //主体类型
@property (nonatomic, copy) NSString *entityTypeName; //主体类型字典名称
@property (nonatomic, copy) NSString *entityIndustry; // 主体行业
@property (nonatomic, copy) NSString *entityIndustryName; //主体行业字典名称
@property (nonatomic, copy) NSString *cardType; //企业证件类型 （三证合一 / 独立组织）
@property (nonatomic,copy)NSString *legalIdCardType; //法人身份证类型
@property (nonatomic, copy) NSString *area; // 区域
@property (nonatomic, copy) NSString *address; // 地址
@property (nonatomic, copy) NSString *longitude; //经度竖着的那条线
@property (nonatomic, copy) NSString *latitude; //纬度是横着的
@property (nonatomic, assign) BOOL     isLong; // 是否长期
@property (nonatomic, copy) NSString *businessOperationStart; // 开始时间
@property (nonatomic, copy) NSString *businessOperationEnd; // 结束时间

@property (nonatomic, copy) NSString *creditCode; // 企业注册号
@property (nonatomic, copy) NSString *organizationCode; // 组织机构代码

@property (nonatomic, copy) NSString *legalName; //法人姓名
@property (nonatomic, copy) NSString *legalIdnumber; //法人身份证号码
@property (nonatomic, copy) NSString *legalPhone; //法人电话
@property (nonatomic, copy) NSString *legalImages; //法人相关照片
@property (nonatomic, copy) NSString *contactName; //联系人姓名
@property (nonatomic, copy) NSString *contactPhone; //联系人电话
@property (nonatomic, copy) NSString *contactEmail; //联系人邮箱
@property (nonatomic, copy) NSString *faxNumber; // 传真
@property (nonatomic, copy) NSString *realName; // 真实姓名


@property (nonatomic, copy) NSString *positiveIdcardeimg; // 身份证正面
@property (nonatomic, copy) NSString *negativeIdcardimg; // 身份证反面
@property (nonatomic, copy) NSString *handIdcardimg; // 手持身份证
@property (nonatomic, copy) NSString *businessLicenceimg; // 营业执照
@property (nonatomic, copy) NSString *organizationCertificateimg; // 组织机构代码照片

@property (nonatomic, copy) NSString *childWhetherPassword;// 子账号是是否为第一次登陆

@property (nonatomic, copy) NSString *childName;
@property (nonatomic, copy) NSString *childPhone;
@property (nonatomic, copy) NSString *childDelFlag;
@property (nonatomic, copy) NSString *delFlag;
@property (nonatomic, copy) NSString *childEmail;

@property (nonatomic, copy) NSString *annualOutput; // 种植业年产量
@property (nonatomic, copy) NSString *annualOutputS; // 水产品
@property (nonatomic, copy) NSString *annualOutputX; // 畜牧业
@property (nonatomic, copy) NSString *unit; //企业种植业年产量单位
@property (nonatomic, copy) NSString *unitS;
@property (nonatomic, copy) NSString *unitX;
@property (nonatomic, copy) NSString *unitName; // 种植业
@property (nonatomic, copy) NSString *unitNameS; //企业水产品年产量单位名称
@property (nonatomic, copy) NSString *unitNameX; //企业畜牧业年产量单位名称

@property (nonatomic, copy) NSString *approveName; //审批人姓名
@property (nonatomic, copy) NSString *approveOpinion; //审批意见
@property (nonatomic, copy) NSString *approveStatus; // 审批状态
@property (nonatomic, copy) NSString *approveUserIdcode; //审批人主体用户码

@property (nonatomic, copy) NSString *isMain;
//@property (nonatomic, assign) NSInteger approveTime;
@property (nonatomic, strong) NSString *idcode; //个人身份证号
@property (nonatomic, assign) NSInteger registerTime; // 注册时间
@property (nonatomic, assign) NSInteger createTime; // 创建时间

@property (nonatomic, copy) NSString *spybLicType; //认证情况 （以逗号分割）
@property (nonatomic, copy) NSString *token;
@end
