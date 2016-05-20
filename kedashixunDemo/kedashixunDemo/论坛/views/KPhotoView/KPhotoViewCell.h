//
//  KPhotoVIewCell.h
//  kedashixunDemo
//
//  Created by KZL on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKAssets.h"


@interface KPhotoViewCell : UICollectionViewCell

@property (nonatomic , strong) JKAssets *asset;
@property (nonatomic , weak) UIButton *deletePhotoButton;
@property (nonatomic , strong) NSIndexPath *indexpath;
@property (nonatomic , strong) UIImageView *imageView;

@end
