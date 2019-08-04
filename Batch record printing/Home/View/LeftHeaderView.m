//
//  LeftHeaderView.m
//  Batch record printing
//
//  Created by 杨健 on 2019/7/24.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "LeftHeaderView.h"

@interface LeftHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation LeftHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.nameLabel.text = [FXUserTool sharedFXUserTool].account.enterpriseName;
}

+(instancetype)leftHeaderView{
    return [[[NSBundle mainBundle]loadNibNamed:@"LeftHeaderView" owner:nil options:nil]lastObject];
}

@end

