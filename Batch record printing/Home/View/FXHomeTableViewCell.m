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
    
    self.nameLabel.text = pici.PRODUCT_NAME;
    NSString *iconName;
    if ([pici.PRODUCT_NAME containsString:@"大米"]) {
        iconName = @"dami";
    }else if ([pici.PRODUCT_NAME containsString:@"早籼稻谷"]) {
        iconName = @"zaoxiandaogu";
    }else if ([pici.PRODUCT_NAME containsString:@"粳稻谷"]) {
        iconName = @"nuodaogu";
    }else if ([pici.PRODUCT_NAME containsString:@"籼糯稻谷"]) {
        iconName = @"xiannuodaogu";
    }else if ([pici.PRODUCT_NAME containsString:@"晚籼稻谷"]) {
        iconName = @"wanxiandaogu";
    }else{
        iconName = @"dami";
    }
    self.iconView.image = [UIImage imageNamed:iconName];
    
    self.zhuisumaLabel.text = [NSString stringWithFormat:@"追溯码:%@",pici.PRODUCT_PC];
    self.unitLabel.text = [NSString stringWithFormat:@"收获数量(%@)",pici.HARVEST_UNIT];
    self.numberLabel.text = pici.PRODUCT_AMOUNT;
}


@end
