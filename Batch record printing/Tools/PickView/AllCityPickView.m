//
//  AllCityPickView.m
//  Lnspection
//
//  Created by MySun0919 on 2016/12/29.
//  Copyright © 2016年 com.sofn.lky.lnspection. All rights reserved.
//

#import "AllCityPickView.h"

@interface AllCityPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickView;
//地址字典
@property (nonatomic , strong) NSDictionary *dic;
//地址数组
@property (nonatomic , strong) NSArray *fistArray;
@property (nonatomic , strong) NSMutableArray *secondArray;
@property (nonatomic , strong) NSMutableArray *threeArray;
@property (nonatomic , strong) NSMutableArray *selectArray;

@property (nonatomic , copy) NSString *firstStr;
@property (nonatomic , copy) NSString *secondStr;
@property (nonatomic , copy) NSString *threeStr;

@end

@implementation AllCityPickView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        //创建子视图
        [self createSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //创建子视图
        [self createSubViews];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
        //创建子视图
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews
{    
    self.dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"allCityDic"];

    if (self.dic)
    {
        self.fistArray = self.dic.allKeys;
        self.secondArray = [NSMutableArray array];
        self.threeArray = [NSMutableArray array];
        self.selectArray = [NSMutableArray array];
        if (self.fistArray.count >0)
        {
            NSArray *array = [self.dic objectForKey:[self.fistArray objectAtIndex:0]];
            self.selectArray=[self.dic objectForKey:[self.fistArray objectAtIndex:0]];
            
            for (NSDictionary *fiDic in array)
            {
                [self.secondArray addObject:[fiDic.allKeys objectAtIndex:0]];
            }
        }
        if (self.secondArray.count>0)
        {
            NSArray *array = [self.dic objectForKey:[self.fistArray objectAtIndex:0]];
            for (NSDictionary *fiDic in array)
            {
                self.threeArray = [fiDic objectForKey:[fiDic.allKeys objectAtIndex:0]];
            }
        }
    }
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToRemove:)]];
    
    
    UIView *allCityPickView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-200, self.frame.size.width, 200)];
    allCityPickView.backgroundColor = [UIColor whiteColor];
    [self addSubview:allCityPickView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [allCityPickView addSubview:lineView];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    leftButton.tag = 0;
    [leftButton addTarget:self action:@selector(clickToAllCity:) forControlEvents:UIControlEventTouchUpInside];
    [allCityPickView addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-50-10, 10, 50, 30)];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    rightButton.tag = 1;
    [rightButton addTarget:self action:@selector(clickToAllCity:) forControlEvents:UIControlEventTouchUpInside];
    [allCityPickView addSubview:rightButton];

    UIPickerView *pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(leftButton.frame)+10,self.frame.size.width, allCityPickView.frame.size.height-CGRectGetMaxY(leftButton.frame)-10)];
    self.pickView = pickView;
    pickView.delegate = self;
    pickView.dataSource = self;
    [allCityPickView addSubview:pickView];
}
- (void)clickToAllCity:(UIButton *)btn
{
    if (btn.tag == 0)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(allCityDataWithStr:withCityID:withRemove:)])
        {
            [self.delegate allCityDataWithStr:@"" withCityID:@"" withRemove:NO];
        }
    }
    else
    {
        NSString *cityStr = [NSString stringWithFormat:@"%@  %@  %@",[self.firstStr componentsSeparatedByString:@"and"].firstObject,[self.secondStr componentsSeparatedByString:@"and"].firstObject,[self.threeStr componentsSeparatedByString:@"and"].firstObject];

        NSString *cityIDStr = [NSString stringWithFormat:@"%@and%@or%@",[self.firstStr componentsSeparatedByString:@"and"].lastObject,[self.secondStr componentsSeparatedByString:@"and"].lastObject,[self.threeStr componentsSeparatedByString:@"and"].lastObject];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(allCityDataWithStr:withCityID:withRemove:)])
        {
            [self.delegate allCityDataWithStr:cityStr withCityID:cityIDStr withRemove:YES];
        }
    }
}
- (void)clickToRemove:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(allCityDataWithStr:withCityID:withRemove:)])
    {
        [self.delegate allCityDataWithStr:@"" withCityID:@"" withRemove:NO];
    }
}
#pragma mark -- UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.fistArray.count;
    }
    else if (component == 1)
    {
        return self.secondArray.count;
    }
    else
    {
        return self.threeArray.count;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        NSString *str = [self.fistArray objectAtIndex:row];
        self.firstStr = str;
        return [str componentsSeparatedByString:@"and"].firstObject;
    }
    if (component==1)
    {
        NSString *str = [self.secondArray objectAtIndex:row];
        self.secondStr = str;
        return [str componentsSeparatedByString:@"and"].firstObject;
    }
    if (component==2)
    {
        NSString *str = [self.threeArray objectAtIndex:row];
        self.threeStr = str;
        return [str componentsSeparatedByString:@"and"].firstObject;
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0)
    {
        self.selectArray=[self.dic objectForKey:[self.fistArray objectAtIndex:row]];
        if (self.fistArray.count >0)
        {
            NSArray *array = [self.dic objectForKey:[self.fistArray objectAtIndex:row]];
            [self.secondArray removeAllObjects];
            for (NSDictionary *fiDic in array)
            {
                [self.secondArray addObject:[fiDic.allKeys objectAtIndex:0]];
            }
        }
        if (self.secondArray.count>0)
        {
            NSArray *array = [self.dic objectForKey:[self.fistArray objectAtIndex:row]];
            NSDictionary *fiDic = [array objectAtIndex:0];
            for (NSString *fiStr in fiDic.allKeys)
            {
                self.threeArray = (NSMutableArray *)[fiDic objectForKey:fiStr];
            }
        }
        else
        {
            self.threeArray = [NSMutableArray array];
        }
    }
    if (component==1)
    {
        if (self.fistArray.count>0 && self.secondArray.count>0)
        {
            self.threeArray=[[self.selectArray objectAtIndex:row] objectForKey:[self.secondArray objectAtIndex:row]];
        }
        else
        {
            self.threeArray = [NSMutableArray array];
        }
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    [pickerView reloadAllComponents];
}
@end
