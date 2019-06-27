//
//  FXVertButton.m
//  jingdiansaomiaoAPP
//
//  Created by SG on 2018/9/20.
//  Copyright © 2018 com.lky.zyt. All rights reserved.
//

#import "SGVertButton.h"

@implementation SGVertButton


-(void)layoutSubviews {
    [super layoutSubviews];

         // image center
   CGPoint center;
   center.x = self.frame.size.width/2;
   center.y = self.imageView.frame.size.height/2;
   self.imageView.center = center;

   //text
   CGRect newFrame = [self titleLabel].frame;
   newFrame.origin.x = 0;
   newFrame.origin.y = self.imageView.frame.size.height + 5;
   newFrame.size.width = self.frame.size.width;

   self.titleLabel.frame = newFrame;
   self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:11.0];
}



@end
