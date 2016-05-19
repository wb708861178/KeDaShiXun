//
//  KPhotoView.h
//  kedashixunDemo
//
//  Created by KZL on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPhotoView : UIView

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray *assetsArray;
@property (nonatomic , strong) UIButton *addButton;
@property (nonatomic , strong) NSArray *selectedPhotos;

@end
