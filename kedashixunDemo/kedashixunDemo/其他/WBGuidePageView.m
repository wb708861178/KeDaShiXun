//
//  WBGuidePageView.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBGuidePageView.h"
#import "CATransition+PageChangeAnimation.h"

@interface WBGuidePageView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *imageNameArr;
@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation WBGuidePageView

- (instancetype)initWithFrame:(CGRect)frame withImageNameArr:(NSArray *)imageNameArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageNameArr = imageNameArr;
        
        [CATransition transitionWithAnimationType:Fade WithSubtype:kCATransitionFromLeft ForView:self.mainScrollView];
        [self createMainScrollView];
        
        
    }
    return self;
}


- (void)createMainScrollView
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    
    _mainScrollView.delegate = self;
    [self addSubview:_mainScrollView];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.contentSize = CGSizeMake(self.bounds.size.width* self.imageNameArr.count, 0);
   
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    
    _mainScrollView.bounces = NO;
    
    
    for (int i = 0; i < self.imageNameArr.count; i++) {
        UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        tempImageView.image = [UIImage imageNamed:self.imageNameArr[i]];
        [_mainScrollView addSubview:tempImageView];
        //最后一页加按钮
        if (i==self.imageNameArr.count -1) {
            CGFloat tempBtnW = self.bounds.size.width * 140 / 375;
            CGFloat tempBtnH = self.bounds.size.height * 39 / 667;
            CGFloat tempBtnX =  i *self.bounds.size.width +  (self.bounds.size.width - tempBtnW) * 0.5;
            CGFloat tempBtnY = self.bounds.size.height - self.bounds.size.height * 83 / 667 - tempBtnH;
            UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(tempBtnX, tempBtnY, tempBtnW, tempBtnH)];
//            [tempBtn setTitle:@"立即体验" forState:UIControlStateNormal];
//            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            tempBtn.layer.borderWidth = 2;
//            tempBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            [tempBtn addTarget:self action:@selector(jumpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_mainScrollView addSubview:tempBtn];
            tempBtn.backgroundColor = [UIColor clearColor];
        }
    }
    
}

#pragma mark--UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


- (void)jumpBtnAction:(UIButton *)sender
{
    self.jumpMainVCBlock();

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
