//
//  KXDatePickerView.m
//  Enterprise
//
//  Created by SG on 2017/8/2.
//  Copyright © 2017年 com.sofn.lky.enterprise. All rights reserved.
//

#import "KXDatePickerView.h"

@interface KXDatePickerView ()

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, assign) NSInteger selectRow;

@end

@implementation KXDatePickerView

- (instancetype)initWithFrame:(CGRect)frame titleColor:(UIColor *)titleColor {
    
    self = [super initWithFrame:frame];
    if (self) {


        [self creatAndAddSubViews:frame WithTitleColor:titleColor];
    }

    return self;
}

- (void)creatAndAddSubViews:(CGRect)frame WithTitleColor:(UIColor *)titleColor {

//    // 透明视图
//    UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-206)];
//    [self addSubview:clearView];
//    //clearView.alpha = 0.3;
//    clearView.backgroundColor = [UIColor redColor];
//    //图像添加点击事件（手势方法）
//    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
//    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
//    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
//    [clearView addGestureRecognizer:PrivateLetterTap];


    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
    [self addSubview:toolbar];
    toolbar.alpha = 1.0;

    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTimeAction)];

    UIBarButtonItem *sureItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureItemAction)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 20;

    NSArray *array = @[fixedSpace,cancelItem, flexibleSpace, sureItem, fixedSpace];
    toolbar.items = array;
    [toolbar setTintColor:titleColor];
    [toolbar setBackgroundColor:[UIColor whiteColor]];

    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, frame.size.width, frame.size.height - 44)];
    [self addSubview:_datePicker];

    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    _datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
    _datePicker.backgroundColor = [UIColor whiteColor];

}

- (void)cancelTimeAction {
    //    if (_cancelBlock) {
    //        _cancelBlock();
    //    }
    if (_delegate) {
        [self.delegate kxDatePickerCancelSelectedPickerView];
    }
}

- (void)sureItemAction {
    NSDate *chooseDate = [self.datePicker date];
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"YYYY-MM-dd"; // 设置时间和日期的格式

    // 把date类型转为设置好格式的string类型
    NSString *chooseDateString = [selectDateFormatter stringFromDate:chooseDate];

    if (_sureBlock) {
        _sureBlock(chooseDateString);
    }
    [self hideView];
    if (_delegate) {
        [self.delegate kxDatePickerdidSelectedPickerViewRow:chooseDateString];
    }
}

- (void)hideView {

    [self removeFromSuperview];

}



@end
