//
//  KPhotoView.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KPhotoView.h"
#import "KPhotoViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "JKImagePickerController.h"
#import "Const.h"

@interface KPhotoView () <JKImagePickerControllerDelegate , UICollectionViewDataSource , UICollectionViewDelegate >

@end

@implementation KPhotoView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {

        UIImage  *img = [UIImage imageNamed:@"jia"];
        UIButton   *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //CGFloat collectionY = CGRectGetMaxY(self.collectionView.frame);
        button.frame = CGRectMake(15, 70, img.size.width+10, img.size.height+10);
        [button setBackgroundImage:img forState:UIControlStateNormal];
        button.layer.borderColor = kBGDefaultColor.CGColor;
        button.layer.borderWidth = 1.f;
        self.addButton = button;
        [self addSubview:button];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        UIImage  *img = [UIImage imageNamed:@"jia"];
        UIButton   *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //CGFloat collectionY = CGRectGetMaxY(self.collectionView.frame);
        button.frame = CGRectMake(15, 70, img.size.width+10, img.size.height+10);
        [button setBackgroundImage:img forState:UIControlStateNormal];
        button.layer.borderColor = kBGDefaultColor.CGColor;
        button.layer.borderWidth = 1.f;
        self.addButton = button;
        [self addSubview:button];

     }
    return self;
    
}

-(void)runInMainQueue:(void (^)())queue{
    dispatch_async(dispatch_get_main_queue(), queue);
}

-(void)runInGlobalQueue:(void (^)())queue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), queue);
}

-(void)setAssetsArray:(NSMutableArray *)assetsArray {
    
    _assetsArray = assetsArray;
    
    
    self.selectedPhotos = assetsArray;
}

static NSString *kPhotoCellIdentifier = @"KPhotoCell";

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.assetsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellIdentifier forIndexPath:indexPath];
    
    cell.asset = [self.assetsArray objectAtIndex:[indexPath row]];
    cell.deletePhotoButton.tag = indexPath.row;
    cell.indexpath = indexPath;
    [cell.deletePhotoButton addTarget:self action:@selector(deleteView:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

- (void)deleteView:(id)sender{
    
    NSInteger deletedPhoto = ((UIButton *)sender).tag;
    for (KPhotoViewCell *currentCell in [self.collectionView subviews]){
        
        if (deletedPhoto == currentCell.indexpath.row){
            
            if (self.assetsArray.count > 0){
                [self.assetsArray removeObjectAtIndex:deletedPhoto];
                [UIView animateWithDuration:1 animations:^{
                    
                    currentCell.frame = CGRectMake(currentCell.frame.origin.x, currentCell.frame.origin.y + 100, 0, 0);
                    [currentCell removeFromSuperview];
                }completion:^(BOOL finished) {
                    
                }];
                
            }
            
        }
        
        if (deletedPhoto < currentCell.indexpath.row){
            currentCell.deletePhotoButton.tag -= 1;
        }
        
    }
    [self.collectionView reloadData];
    
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5.0;
        layout.minimumInteritemSpacing = 5.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 15, CGRectGetWidth(self.frame)-30, 50) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[KPhotoViewCell class] forCellWithReuseIdentifier:kPhotoCellIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_collectionView];
        
    }
    return _collectionView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
