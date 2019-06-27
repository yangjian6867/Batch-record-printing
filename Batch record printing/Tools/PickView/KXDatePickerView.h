//
//  KXDatePickerView.h
//  Enterprise
//
//  Created by SG on 2017/8/2.
//  Copyright © 2017年 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol KXDatePickerViewDelegate <NSObject>

// 确定选中行
- (void)kxDatePickerdidSelectedPickerViewRow:(NSString *)selectedDateString;
@optional
- (void)kxDatePickerCancelSelectedPickerView;
@end


@interface KXDatePickerView : UIView

@property (nonatomic, weak) id<KXDatePickerViewDelegate> delegate;

@property (nonatomic, strong) void (^cancelBlock) (void);
@property (nonatomic, strong) void (^sureBlock) (NSString *dateString);

- (instancetype)initWithFrame:(CGRect)frame titleColor:(UIColor *)titleColor;


@end
