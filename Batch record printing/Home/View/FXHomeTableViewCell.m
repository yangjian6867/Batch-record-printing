//
//  FXHomeTableViewCell.m
//  Batch record printing
//
//  Created by SG on 2019/7/10.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "FXHomeTableViewCell.h"

@interface FXHomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *zhuisumaLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end

@implementation FXHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPici:(FXPICI *)pici{
    
    if ([pici.PRODUCT_INDUSTRY isEqualToString:@"01"]) {
        // 种植业
        self.iconView.image = [UIImage imageNamed:@"icon_zhongzhi"];
        
    }else if ([pici.PRODUCT_INDUSTRY isEqualToString:@"02"]) {
        // 畜牧业
        self.iconView.image = [UIImage imageNamed:@"icon_xumu"];
    }else if ([pici.PRODUCT_INDUSTRY isEqualToString:@"03"]) {
        // 水产品
        self.iconView.image = [UIImage imageNamed:@"icon_shuichan"];
    }
    
    self.nameLabel.text = pici.PRODUCT_NAME;
    self.zhuisumaLabel.text = [NSString stringWithFormat:@"追溯码:%@",pici.PRODUCT_PC];
    self.unitLabel.text = [NSString stringWithFormat:@"收获数量(%@)",pici.HARVEST_UNIT];
    self.numberLabel.text = pici.PRODUCT_AMOUNT;
}


@end
