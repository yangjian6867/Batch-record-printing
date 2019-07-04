//
//  SGFarmRemarkCell.m
//  SGRetrospect
//
//  Created by SG on 2018/12/14.
//  Copyright © 2018 com.sofn.lky.retrospect. All rights reserved.
//

#import "FXZSBatchRemarkCell.h"

@interface FXZSBatchRemarkCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;

@end

@implementation FXZSBatchRemarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBatch:(ZSBatch *)batch{
    _batch = batch;
    [self.topBtn setTitle:batch.name forState:UIControlStateNormal];
    [self.topBtn setImage:[UIImage imageNamed:batch.icon] forState:UIControlStateNormal];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.batch.detail = textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return textView.text.length + (text.length - range.length) <= 200;
}


@end
