//
//  FXJIDITableViewCell.m
//  Batch record printing
//
//  Created by SG on 2019/6/25.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "FXJIDITableViewCell.h"

@interface FXJIDITableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic,strong)FXJIDIModel *tempModel;
@end


@implementation FXJIDITableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(FXJIDIModel *)model{
    _model = model;
    
    self.nameLabel.text = model.NAME;
    self.addressLabel.text = model.ADDRESS_NAME;
    self.selectedBtn.selected = model.selected;
    self.selectedBtn.hidden = model.fromMe;
    NSString *dwonLoadUrl = [NSString stringWithFormat:@"%@%@%@",MaiURL,kImagePre,model.PICTURE];
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:dwonLoadUrl] placeholderImage:[UIImage imageNamed:@"hezuoshe"] options:(SDWebImageRetryFailed | SDWebImageLowPriority)];
}


- (IBAction)selectedBtnAction:(UIButton *)sender {
    
    self.model.selected = !sender.selected;
    if (self.clickBlock) {
        self.clickBlock(self.model);
    }
}

@end
