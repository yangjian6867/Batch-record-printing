//
//  SGHomeCollectionCell.m
//  Batch record printing
//
//  Created by 杨健 on 2019/7/24.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "SGHomeCollectionCell.h"

@interface SGHomeCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SGHomeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setPici:(FXPICI *)pici{
    
    
    self.nameLabel.text = pici.PRODUCT_NAME;
    
    NSString *iconName;
    if ([pici.PRODUCT_NAME containsString:@"大米"]) {
        iconName = @"dami";
    }else if ([pici.PRODUCT_NAME containsString:@"早籼稻谷"]) {
        iconName = @"zaoxiandaogu";
    }else if ([pici.PRODUCT_NAME containsString:@"粳稻谷"]) {
        iconName = @"gengdaogu";
    }else if ([pici.PRODUCT_NAME containsString:@"籼糯稻谷"]) {
        iconName = @"xiannuodaogu";
    }else if ([pici.PRODUCT_NAME containsString:@"晚籼稻谷"]) {
        iconName = @"wanxiandaogu";
    }else{
        iconName = @"dami";
    }
    self.iconView.image = [UIImage imageNamed:iconName];
    
}


@end
