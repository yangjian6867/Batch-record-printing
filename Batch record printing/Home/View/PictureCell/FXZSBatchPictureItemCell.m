//
//  SlaughterImagItemCell.m
//  Enterprise
//
//  Created by SG on 2018/11/20.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import "FXZSBatchPictureItemCell.h"

@interface FXZSBatchPictureItemCell ()



@end

@implementation FXZSBatchPictureItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    if ([imageUrl isEqualToString:@"AddMedia"]) {
        self.iconView.image = [UIImage imageNamed:@"AddMedia"];
    }else{
         NSString *dwonLoadUrl = [NSString stringWithFormat:@"%@%@%@",MaiURL,kImagePre,imageUrl];
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:dwonLoadUrl] placeholderImage:[UIImage imageNamed:@"AddMedia"]];
    }
}

- (IBAction)deletedAciton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sgFarmActivitiyPictureItemCellDelted:)]) {
        [self.delegate sgFarmActivitiyPictureItemCellDelted:self];
    }
}

@end

