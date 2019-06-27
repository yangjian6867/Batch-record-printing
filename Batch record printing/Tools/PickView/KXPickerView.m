//
//  KXPickerView.m
//  Enterprise
//
//  Created by SG on 2017/12/5.
//  Copyright © 2017年 com.sofn.lky.enterprise. All rights reserved.
//

#import "KXPickerView.h"

@interface KXPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;


@property (nonatomic, assign) NSInteger selectRow;

@end

@implementation KXPickerView



- (instancetype)initWithFrame:(CGRect)frame  titleColor:(UIColor *)titleColor {
    
    self = [super initWithFrame:frame];
    if (self) {

        [self creatAndAddSubViews:frame WithTitleColor:titleColor];
    }

    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
     self.selectRow = 0;
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
}


- (void)creatAndAddSubViews:(CGRect)frame WithTitleColor:(UIColor *)titleColor  {

    CGFloat hight = 206;


    // 透明视图
    UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-hight)];
    [self addSubview:clearView];
    clearView.alpha = 0.3;
    clearView.backgroundColor = [UIColor lightGrayColor];

    //图像添加点击事件（手势方法）
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
    [clearView addGestureRecognizer:PrivateLetterTap];

    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, frame.size.height-hight, SCREEN_WIDTH, 44)];
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
    [toolbar setBarTintColor:[UIColor whiteColor]];

    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, frame.size.height-hight+44, SCREEN_WIDTH, 162)];
    [self addSubview:_pickerView];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.showsSelectionIndicator = YES;

}

- (void)cancelTimeAction {
    if (_delegate) {
        [self removeFromSuperview];
        [self.delegate kxPickerViewCancelPickerViewRow];
    }
}

- (void)sureItemAction {
    if (_delegate) {
        [self removeFromSuperview];
        [self.delegate kxPickerViewDidSelectedPickerViewRow:self.selectRow];
    }
}



- (void)hideView {

    [self removeFromSuperview];

}

#pragma mark - picker view delgate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return [self.dataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    self.selectRow = row;

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor lightGrayColor];
        }
    }

    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.text = self.dataArray[row];
    genderLabel.textColor = [UIColor blackColor];
    genderLabel.font = [UIFont systemFontOfSize:20];
    return genderLabel;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

@end
