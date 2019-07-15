//
//  SGPictureAndVideoController.h
//  Enterprise
//
//  Created by SG on 2018/10/22.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXZSBatchPictureCell.h"
#import "SGImageAndVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SGPictureAndVideoController : UIViewController
@property(nonatomic,strong)NSMutableArray *imageAndVideos;
@property (nonatomic,assign)BOOL isFromMe;
@property (nonatomic,copy)void (^refreshDataBlock)(NSArray *selectedModels);
@property (nonatomic,assign)FXZSBatchType type;
@end

NS_ASSUME_NONNULL_END
