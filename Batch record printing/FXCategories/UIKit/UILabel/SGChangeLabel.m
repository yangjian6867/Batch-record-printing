//
//  SGChangeLabel.m
//  LawEnforcing
//
//  Created by djh on 2018/7/19.
//  Copyright © 2018年 com.sofn.lky.lawenforcing. All rights reserved.
//

#import "SGChangeLabel.h"

@implementation SGChangeLabel
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews
{
    [super layoutSubviews];
    if ([self.text containsString:@"*"]) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(self.text.length-1, 1)];
        self.attributedText = attrStr;
    } else {
        
    }
}
@end
