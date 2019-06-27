//
//  KXCustomPickerView.h
//  Enterprise
//
//  Created by SG on 2017/8/1.
//  Copyright © 2017年 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KXCustomPickerViewDelegate <NSObject>

// 确定选中行
- (void)kxCustomDidSelectedPickerViewRow:(NSInteger)selectedRow;

@end

@interface KXCustomPickerView : UIView

@property (nonatomic, weak) id<KXCustomPickerViewDelegate> delegate;

@property (nonatomic, strong) void (^sureBlock) (NSInteger selectRow);

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray titleColor:(UIColor *)titleColor;

- (void)updateAllCompentsWithAddDataAraay:(NSArray *)array;

@end
