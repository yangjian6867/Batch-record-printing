//
//  SGNewAddressCell.m
//  Enterprise
//
//  Created by 杨健 on 2019/4/3.
//  Copyright © 2019 com.sofn.lky.enterprise. All rights reserved.
//

#import "SGNewAddressCell.h"

@interface SGNewAddressCell ()

@property (weak, nonatomic) IBOutlet UILabel *addressNameLabel;
@end

@implementation SGNewAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.addressNameLabel.textColor = selected ? [UIColor colorWithRed:48.0/255.0 green:177.0/255.0 blue:122.0/255.0 alpha:1.0] : [UIColor blackColor];
}


-(void)setModel:(SGSelectAreaModel *)model{
    _model = model;
    self.addressNameLabel.text = model.name;
}

@end
