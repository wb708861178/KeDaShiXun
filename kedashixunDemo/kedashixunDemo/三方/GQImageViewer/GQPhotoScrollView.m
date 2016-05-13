//
//  PhotoScrollView.m
//  Sunshine_mall
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 GQ. All rights reserved.
//

#import "GQPhotoScrollView.h"
#import "UIImageView+WebCache.h"
#import "GQImageViewer.h"
#import <MBProgressHUD.h>

@implementation GQPhotoScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.backgroundColor = [UIColor clearColor];
        //让图片等比例适应图片视图的尺寸
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        //设置最大放大倍数
        self.maximumZoomScale = 2.5;
        self.minimumZoomScale = 1.0;
        
        //隐藏滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.delegate = self;
        
        //单击手势
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap1];
        
        //双击放大缩小手势
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        //双击
        tap2.numberOfTapsRequired = 2;
        //手指的数量
        tap2.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap2];
        
        //tap1、tap2两个手势同时响应时，则取消tap1手势
        [tap1 requireGestureRecognizerToFail:tap2];
        
        
        //长按手势
        UILongPressGestureRecognizer *tap3=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapLong:)];
        
        [self addGestureRecognizer:tap3];
        
    }
    return self;
}
//长按手势保存图片
-(void)tapLong:(UILongPressGestureRecognizer*)sender{
    if (sender.state==UIGestureRecognizerStateBegan) {
        UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存" otherButtonTitles:nil, nil];
        [action showInView:self];
    }
    
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        });
        
    }
    
}



-(void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    
    
    NSString *message=@"保存成功";
    if (!error) {
        NSLog(@"%@",message);
        
//        [MBProgressHUD showSuccess:@"保存成功" toView:self];
        
        
    }else{
        NSLog(@"失败");
//        [MBProgressHUD showError:@"保存失败" toView:self];
//
    }
    
    
}


- (void)setData:(id)data{
    if ([data isKindOfClass:[UIImage class]]) {
        _imageView.image = data;
    }else if ([data isKindOfClass:[NSString class]]){
        [_imageView sd_setImageWithURL:[NSURL URLWithString:data]];
    }else if ([data isKindOfClass:[NSURL class]]){
        [_imageView sd_setImageWithURL:data];
    }else if ([data isKindOfClass:[UIImageView class]]){
        UIImageView *imageView = (UIImageView *)data;
        _imageView.image = imageView.image;
    }else{
        _imageView.image = nil;
    }
}

#pragma mark - UIScrollView delegate
//返回需要缩放的子视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (tap.numberOfTapsRequired == 1) {
        [[GQImageViewer sharedInstance] dissMiss];
    }
    else if(tap.numberOfTapsRequired == 2) {
        if (self.zoomScale > 1) {
            [self setZoomScale:1 animated:YES];
        } else {
            [self setZoomScale:3 animated:YES];
        }
    }
}

@end