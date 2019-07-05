//
//  SGPictureAndVideoController.h
//  Enterprise
//
//  Created by SG on 2018/10/22.
//  Copyright © 2018 com.sofn.lky.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshDataBlock)();

NS_ASSUME_NONNULL_BEGIN

@interface SGPictureAndVideoController : UICollectionViewController
- (void)loadDataFromHttp;
@property(nonatomic,strong)NSMutableArray *imageAndVideos;
@property (nonatomic,assign)BOOL isFromDeleted;
@property (nonatomic,assign)refreshDataBlock block;
@end

NS_ASSUME_NONNULL_END
