//
//  SGNewAddressView.h
//  Enterprise
//
//  Created by 杨健 on 2019/4/3.
//  Copyright © 2019 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SGNewAddressViewDelegate <NSObject>

-(void)getTheLastModels:(NSDictionary *)dict;

@end

typedef void(^addressBlock)(NSDictionary *dicts);

@interface SGNewAddressView : UIView

+(instancetype)initWithXib:(CGRect)frame;
@property(nonatomic,copy)addressBlock block;
@property(nonatomic,assign)id<SGNewAddressViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
