//
//  AllCityPickView.h
//  Lnspection
//
//  Created by MySun0919 on 2016/12/29.
//  Copyright © 2016年 com.sofn.lky.lnspection. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AllCityPickViewDelegate <NSObject>

- (void)allCityDataWithStr:(NSString *)cityStr withCityID:(NSString *)cityID withRemove:(BOOL)isRemove;

@end

//地址选择器
@interface AllCityPickView : UIView
@property (nonatomic, weak) id<AllCityPickViewDelegate> delegate;
@end
