//
//  SGPictureAndVideoCell.h
//  Enterprise
//
//  Created by SG on 2018/10/22.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGImageAndVideoModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface SGPictureAndVideoCell : UICollectionViewCell
@property(nonatomic,strong)SGImageAndVideoModel *model;
@property(nonatomic,copy)void (^selectedResourceBlock) (NSString *resourceUrl);
@property(nonatomic,strong)NSArray *selectedModels;
@property(nonatomic,assign)BOOL isFromMe;

@end

NS_ASSUME_NONNULL_END
