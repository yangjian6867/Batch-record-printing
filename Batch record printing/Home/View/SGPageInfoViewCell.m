//
//  SGPageInfoViewCell.m
//  Batch record printing
//
//  Created by SG on 2019/7/12.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "SGPageInfoViewCell.h"


@interface SGPageInfoViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *sortLabel;
@end

@implementation SGPageInfoViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPageInfo:(SGPageInfo *)pageInfo{
    _pageInfo = pageInfo;
    
    self.nameLabel.text = pageInfo.NAME;
    self.sortLabel.text = @"种植业";
    self.statusLabel.text = [pageInfo.STATUS boolValue] ? @"已启用" : @"已停用";
}


@end
