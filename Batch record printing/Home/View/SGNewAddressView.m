//
//  SGNewAddressView.m
//  Enterprise
//
//  Created by 杨健 on 2019/4/3.
//  Copyright © 2019 com.sofn.lky.enterprise. All rights reserved.
//

#import "SGNewAddressView.h"
#import "SGSelectAreaModel.h"
#import "SGNewAddressCell.h"


typedef enum : NSUInteger {
    SelectedProvince,
    SelectedCity,
    SelectedArea,
} SelectedType;


@interface SGNewAddressView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray<SGSelectAreaModel*> *datas;
@property (nonatomic,assign)SelectedType selectedType;
@property(nonatomic,strong)SGSelectAreaModel *selectedModel;
@property(nonatomic,strong)SGSelectAreaModel *selectedProvinceModel;
@property(nonatomic,strong)SGSelectAreaModel *selectedCityModel;
@property(nonatomic,strong)SGSelectAreaModel *selectedAreaModel;
@property (weak, nonatomic) IBOutlet UIButton *provinceBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *areBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableDictionary *dicts;

@end

@implementation SGNewAddressView

static  NSString* const SGNewAddressCellID = @"SGNewAddressCell";


-(NSMutableArray<SGSelectAreaModel*> *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


-(NSMutableDictionary *)dicts{
    if (_dicts == nil) {
        _dicts = [NSMutableDictionary dictionary];
    }
    return _dicts;
}

+(instancetype)addressView{
    return [[[NSBundle mainBundle]loadNibNamed:@"SGNewAddressView" owner:self options:nil]lastObject];
}

+(instancetype)initWithXib:(CGRect)frame{
    SGNewAddressView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    view.frame = frame;
    [view awakeFromNib];
    
    return view;
}

//1、正在准备初始化 -- loadNibName 之后会调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configeData];
    }
    return self;
}
//2、初始化完毕`（若想初始化时做点事情，最好在这个方法里面实现）`
- (void)awakeFromNib {
    [super awakeFromNib];
    
}



-(void)configeData{
    
    [self loadProviceData];
}

-(void)loadProviceData{
    
   [ [NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:provinceRegionCodeList parms:nil success:^(id JSON) {
       self.datas = [SGSelectAreaModel mj_objectArrayWithKeyValuesArray:JSON[@"data"]];
       [self.tableView reloadData];
    } :^(NSError *error) {
        
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SGNewAddressCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SGNewAddressCellID];
    }
    cell.textLabel.text = self.datas[indexPath.row].name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedModel = self.datas[indexPath.row];
    [self setTopBtnTitle];
}


-(void)setTopBtnTitle{
    switch (self.selectedType) {
        case SelectedProvince:
            [self.provinceBtn setTitle:self.selectedModel.name forState:UIControlStateNormal];
            [self loadSubRegion:self.selectedModel.code];
            self.selectedProvinceModel = self.selectedModel;
            self.cityBtn.hidden = NO;
            self.selectedType = SelectedCity;
            self.provinceBtn.selected = YES;
            break;
        case SelectedCity:
            [self.cityBtn setTitle:self.selectedModel.name forState:UIControlStateNormal];
            self.selectedCityModel = self.selectedModel;
            self.areBtn.hidden = NO;
            self.selectedType = SelectedArea;
            [self loadSubRegion:self.selectedModel.code];
            self.cityBtn.selected = YES;
            break;
        case SelectedArea:
            [self.areBtn setTitle:self.selectedModel.name forState:UIControlStateNormal];
            self.selectedAreaModel = self.selectedModel;
            self.cityBtn.selected = YES;
            break;
        default:
            break;
    }
}


-(void)loadSubRegion:(NSString *)code{
    
    [[NetWorkTools sharedNetWorkTools]requestWithType:RequesTypePOST urlString:subRegionCodeList parms:@{@"parentRegionCode":code} success:^(id JSON) {
        self.datas = [SGSelectAreaModel mj_objectArrayWithKeyValuesArray:JSON[@"data"]];
        [self.tableView reloadData];
    } :^(NSError *error) {
        
    }];
}


- (IBAction)topBtnAction:(UIButton *)sender {
    self.selectedType = sender.tag;
    
    if (sender.tag == 0) {
        [self loadProviceData];
        self.cityBtn.hidden = YES;
        self.areBtn.hidden = YES;
        [self.cityBtn setTitle:@"请选择市" forState:UIControlStateNormal];
        [self.areBtn setTitle:@"请选择区县" forState:UIControlStateNormal];
        [self.provinceBtn setTitle:@"请选择省" forState:UIControlStateNormal];
        self.cityBtn.selected = NO;
        self.areBtn.selected = NO;
        self.selectedProvinceModel = nil;
        self.selectedCityModel = nil;
        self.selectedAreaModel = nil;
    }else if (sender.tag == 1){
        self.areBtn.hidden = YES;
        self.areBtn.selected = NO;
        [self.areBtn setTitle:@"请选择区县" forState:UIControlStateNormal];
        [self.cityBtn setTitle:@"请选择市" forState:UIControlStateNormal];
        self.cityBtn.selected = NO;
        [self loadSubRegion:self.selectedProvinceModel.code];
        self.selectedCityModel = nil;
        self.selectedAreaModel = nil;
    }
    
}


- (IBAction)okAction:(id)sender {
    
    if (self.selectedProvinceModel) {
        [self.dicts setObject:self.selectedProvinceModel forKey:@"Province"];
    }
    
    if (self.selectedCityModel) {
        [self.dicts setObject:self.selectedCityModel forKey:@"city"];
    }
    
    if (self.selectedAreaModel) {
         [self.dicts setObject:self.selectedAreaModel forKey:@"area"];
    }
    
    if(self.dicts.allKeys.count !=3){
        [SVProgressHUD showErrorWithStatus:@"请选择完整的省市区"];
        return;
    }
    
    
    if (self.dicts.allKeys.count) {
        if ([self.delegate respondsToSelector:@selector(getTheLastModels:)]) {
            [self.delegate getTheLastModels:self.dicts];
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"请选择省"];
    }
}


@end
