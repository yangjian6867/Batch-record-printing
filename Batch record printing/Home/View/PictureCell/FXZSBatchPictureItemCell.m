//
//  SlaughterImagItemCell.m
//  Enterprise
//
//  Created by SG on 2018/11/20.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import "FXZSBatchPictureItemCell.h"

@interface FXZSBatchPictureItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *deletedBtn;

@end

@implementation FXZSBatchPictureItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
   
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"AddMedia"]];
    
}


-(void)setImage:(UIImage *)image{
    _image = image;
    self.iconView.image = image;
}

- (IBAction)deletedAciton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sgFarmActivitiyPictureItemCellDelted:)]) {
        [self.delegate sgFarmActivitiyPictureItemCellDelted:self];
    }
}

@end

