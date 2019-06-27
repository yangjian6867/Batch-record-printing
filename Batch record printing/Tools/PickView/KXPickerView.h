//
//  KXPickerView.h
//  Enterprise
//
//  Created by SG on 2017/12/5.
//  Copyright © 2017年 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KXPickerViewDelegate <NSObject>

// 确定选中行
- (void)kxPickerViewDidSelectedPickerViewRow:(NSInteger)selectedRow;
@optional
- (void)kxPickerViewCancelPickerViewRow;

@end

@interface KXPickerView : UIView

@property (nonatomic, weak) id<KXPickerViewDelegate> delegate;

@property (nonatomic, strong) void (^sureBlock) (NSInteger selectRow);

@property (nonatomic, strong) NSArray *dataArray;
- (instancetype)initWithFrame:(CGRect)frame titleColor:(UIColor *)titleColor;


@end
