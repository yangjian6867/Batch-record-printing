//
//  KXPickViewLoadMoreView.h
//  Enterprise
//
//  Created by patrikstar on 2018/5/14.
//  Copyright © 2018年 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol KXPickViewLoadMoreViewDelegate <NSObject>

// 确定选中行
- (void)kxPickViewLoadMoreViewDelegateDidSelectedPickerViewRow:(NSInteger)selectedRow;

// 加载更多的数据
- (void)kxPickViewLoadMoreViewDelegateLoadMoreData;

@end

@interface KXPickViewLoadMoreView : UIView

@property (nonatomic, weak) id<KXPickViewLoadMoreViewDelegate> delegate;

@property (nonatomic, strong) void (^sureBlock) (NSInteger selectRow);

@property (nonatomic, strong) void (^getMoreDateBlcok) (void); // 查看更多

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray titleColor:(UIColor *)titleColor;

- (void)updateAllCompentsWithAddDataAraay:(NSArray *)array;


@end
