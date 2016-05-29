//
//  KTopicDetailHeader.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/11.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTopicDetailHeader.h"
#import <UIImageView+WebCache.h>
#import "KCommentCountView.h"
#import "GQImageViewer.h"

@interface KTopicDetailHeader ()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *namelbl;
@property (nonatomic, strong) UILabel *timelbl;
@property (nonatomic, strong) UILabel *contentlbl;

@property (nonatomic, strong) UIImageView *locationImgView;
@property (nonatomic, strong) UILabel *locationlbl;
@property (nonatomic, strong) UILabel *viewCountlbl;
@property (nonatomic, strong) UIButton *praiseBtn;
@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, strong) KCommentCountView *commentCountView;
@end

@implementation KTopicDetailHeader
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _iconImgView = [[UIImageView alloc] init];
        
        _namelbl = [[UILabel alloc] init];
        _namelbl.font = [UIFont systemFontOfSize:15];
        
        _timelbl = [[UILabel alloc] init];
        _timelbl.font = [UIFont systemFontOfSize:12];
        
        _contentlbl = [[UILabel alloc] init];
        _contentlbl.font = [UIFont systemFontOfSize:14];
        _contentlbl.numberOfLines = 0;
        

        
        _locationImgView = [[UIImageView alloc] init];
        _locationImgView.image = [UIImage imageNamed:@"weizhi"];
        
        _locationlbl = [[UILabel alloc] init];
        _locationlbl.font = [UIFont systemFontOfSize:12];
        
        _viewCountlbl = [[UILabel alloc] init];
        _viewCountlbl.font = [UIFont systemFontOfSize:12];
        
        _praiseBtn = [[UIButton alloc] init];
        [_praiseBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
        [_praiseBtn addTarget:self action:@selector(praiseTopic) forControlEvents:UIControlEventTouchUpInside];
        
        _collectBtn = [[UIButton alloc] init];
        [_collectBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        
        _commentCountView = [[NSBundle mainBundle] loadNibNamed:@"KCommentCountView" owner:nil options:nil].firstObject;
        
        [self addSubview:_iconImgView];
        [self addSubview:_namelbl];
        [self addSubview:_timelbl];
        [self addSubview:_contentlbl];
        [self addSubview:_locationImgView];
        [self addSubview:_locationlbl];
        [self addSubview:_viewCountlbl];
        [self addSubview:_praiseBtn];
        [self addSubview:_collectBtn];
        [self addSubview:_commentCountView];
        
    }
    return self;
}


- (void)setTopicHeaderFrameModel:(KTopicHeaderFrameModel *)topicHeaderFrameModel{
    
    _topicHeaderFrameModel = topicHeaderFrameModel;
    
    KTopicModel *topicModel = topicHeaderFrameModel.topicModel;
    
    _iconImgView.frame = topicHeaderFrameModel.iconFrame;
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:topicModel.iconName]];
    //    ------------------Test
    
    _iconImgView.image = [UIImage imageNamed:@"luntan_icon2"];
    //    ------------------Test
    
    
    _namelbl.frame = topicHeaderFrameModel.nameFrame;
    _namelbl.text = topicModel.name;
    _timelbl.frame = topicHeaderFrameModel.timeFrame;
    _timelbl.text = topicModel.time;
    _contentlbl.frame = topicHeaderFrameModel.contentFrame;
    _contentlbl.text = topicModel.content;
    _contentlbl.numberOfLines = 0;
    
    
    for (int i = 0; i < topicModel.imagesUrlArr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = i;
        imgView.frame = CGRectFromString(topicHeaderFrameModel.imagesFrameArr[i]);
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imgView addGestureRecognizer:tap];
        
        [self addSubview:imgView];

        [imgView sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[i]]];
    }

    
    _locationImgView.frame = topicHeaderFrameModel.locationImgViewFrame;
    
    _locationlbl.frame = topicHeaderFrameModel.locationlblFrame;
    _locationlbl.text = topicModel.location;
    
    _viewCountlbl.frame = topicHeaderFrameModel.viewCountFrame;
    _viewCountlbl.text = [NSString stringWithFormat:@"%@人浏览",topicModel.viewCount];
    _praiseBtn.frame = topicHeaderFrameModel.praiseFrame;
    _collectBtn.frame = topicHeaderFrameModel.commentFrame;


    _commentCountView.frame = topicHeaderFrameModel.commentViewFrame;
}

- (void)setCommentCount:(NSUInteger)commentCount{
    _commentCount = commentCount;
    _commentCountView.commentCount.text = [NSString stringWithFormat:@"评论 %ld",commentCount];

}

//调出图片浏览器

- (void)tap:(UITapGestureRecognizer *)tap{
    
    
    [[GQImageViewer sharedInstance] setImageArray:self.topicHeaderFrameModel.topicModel.imagesUrlArr];
    [GQImageViewer sharedInstance].pageControl = NO;
    [GQImageViewer sharedInstance].index = tap.view.tag;
    
    self.showImageViewer();
}


- (void)praiseTopic{
    
    //判断用户是否赞过
    
    [UIView animateWithDuration:0.2 animations:^{
        _praiseBtn.transform = CGAffineTransformMakeScale(1.5, 1.5);
        _praiseBtn.tintColor = [UIColor orangeColor];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            _praiseBtn.transform = CGAffineTransformMakeScale(1, 1);
        }];
        
    }];
    
    //改变参数
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
