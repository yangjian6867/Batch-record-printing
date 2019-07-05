//
//  SGAddFarmActivitiyCell.m
//  SGRetrospect
//
//  Created by SG on 2018/11/26.
//  Copyright © 2018 com.sofn.lky.retrospect. All rights reserved.
//

#import "FXZSBatchViewCell.h"
@interface FXZSBatchViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *arrowWidthCons;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldView;
@end

@implementation FXZSBatchViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.accessoryView.contentMode = UIViewContentModeRight;
    self.textFieldView.delegate = self;
    [self.textFieldView addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
}


-(void)textField1TextChange:(UITextField *)textField{
    if (textField.keyboardType == UIKeyboardTypeDecimalPad) {

        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
            [SVProgressHUD showErrorWithStatus:@"最多输入11位数字"];
            return;
        }

    }else{
        if (textField.text.length >= 30) {
            textField.text = [textField.text substringToIndex:30];
            [SVProgressHUD showErrorWithStatus:@"搜索框最多输入30个汉字或字母"];
            return;
        }
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.batch.detail = textField.text;
}

-(void)setBatch:(ZSBatch *)batch{
    _batch = batch;
    
    [self.titleButton setTitle:batch.name forState:UIControlStateNormal];
    [self.titleButton setImage:[UIImage imageNamed:batch.icon] forState:UIControlStateNormal];
    self.detailLabel.text = batch.detail;
    
    NSString *type = batch.type;
    if ([type isEqualToString:@"textLabel"]) {
        self.textFieldView.hidden = YES;
        self.detailLabel.hidden = NO;
        self.detailLabel.text = batch.detail ? batch.detail : [NSString stringWithFormat:@"请选择%@",batch.name];
        self.detailLabel.textColor = batch.detail ? [UIColor blackColor] : [UIColor lightGrayColor];
        self.arrowView.hidden = batch.showInfo;
    }else{
        self.textFieldView.hidden = NO;
        self.detailLabel.hidden = YES;
        self.arrowWidthCons.constant = 0;
        self.textFieldView.placeholder = [NSString stringWithFormat:@"请输入%@",batch.name];
        self.textFieldView.text = batch.detail ? batch.detail : nil;
        self.textFieldView.userInteractionEnabled = !batch.detail;
    }
    
    
}


//-(void)setFarmActivitiy:(SGAddFarmActivitiy *)farmActivitiy{
//    _farmActivitiy = farmActivitiy;
//    [self.titleButton setImage:[UIImage imageNamed:farmActivitiy.icon] forState:UIControlStateNormal];
//
//    if (!farmActivitiy.isDetail) {
//        [self.titleButton setTitle:[NSString stringWithFormat:@"%@*",farmActivitiy.name] forState:UIControlStateNormal];
//        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.titleButton.currentTitle];
//        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(self.titleButton.currentTitle.length-1, 1)];
//        [self.titleButton.titleLabel setAttributedText:attrStr];
//    }else{
//        [self.titleButton setTitle:farmActivitiy.name forState:UIControlStateNormal];
//    }
//
//
//    if ([farmActivitiy.type isEqualToString:@"textLabel"]) {
//        self.detailLabel.hidden = NO;
//        self.textFieldView.hidden = YES;
//        self.detailLabel.text = farmActivitiy.detail;
//        self.collectionView.hidden = YES;
//        self.detailLabel.textColor = [farmActivitiy.detail hasPrefix:@"选择"] ? [UIColor darkGrayColor] : [UIColor blackColor];
//        self.selectedBtn.hidden = YES;
//    }else if ([farmActivitiy.type isEqualToString:@"textField"]){
//        self.detailLabel.hidden = YES;
//        self.textFieldView.hidden = NO;
//        self.collectionView.hidden = YES;
//        if ([farmActivitiy.detail hasPrefix:@"输入"]) {
//            self.textFieldView.placeholder = farmActivitiy.detail;
//            self.textFieldView.text = nil;
//            self.textFieldView.textColor = [UIColor darkGrayColor];
//        }else{
//            self.textFieldView.text = farmActivitiy.detail;
//            self.textFieldView.textColor = [UIColor blackColor];
//        }
//        self.textFieldView.keyboardType = [farmActivitiy.name containsString:@"量"] ? UIKeyboardTypeDecimalPad : UIKeyboardTypeDefault;
//        self.selectedBtn.hidden = !farmActivitiy.behavior;
//
//    }else if ([farmActivitiy.type isEqualToString:@"switch"]){
//        self.detailLabel.hidden = YES;
//        self.textFieldView.hidden = YES;
//        self.detailLabel.text = nil;
//        self.collectionView.hidden = NO;
//        self.selectedBtn.hidden = YES;
//        [self.switchModels removeAllObjects];
//        NSArray *arr = [self.farmActivitiy.tempName componentsSeparatedByString:@","];
//        for (NSString *title in arr) {
//            SGFarmSwitchModel *model = [[SGFarmSwitchModel alloc]init];
//            model.name = title;
//            model.isSelected = [farmActivitiy.detail isEqualToString:model.name];
//            if (model.isSelected) {
//                self.tempModel = model;
//            }
//            [self.switchModels addObject:model];
//        }
//
//        self.collectionViewWcons.constant = farmActivitiy.width;
//        [self.collectionView reloadData];
//    }
//    self.accessoryType = farmActivitiy.accessory ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
//    self.rightMarginCons.constant = farmActivitiy.accessory ? 0 : 20;
//    if ([farmActivitiy.name isEqualToString:@"供应商名称"]) {
//        self.accessoryType = UITableViewCellAccessoryNone;
//        self.selectedBtnWCons.constant = 40;
//    }else{
//        self.selectedBtnWCons.constant = 0;
//    }
//}


@end

