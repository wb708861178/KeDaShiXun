//
//  KTopicDetailHeader.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/11.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTopicDetailHeader.h"
#import <UIImageView+WebCache.h>

@interface KTopicDetailHeader ()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *namelbl;
@property (nonatomic, strong) UILabel *timelbl;
@property (nonatomic, strong) UILabel *contentlbl;

@property (nonatomic, strong) UIImageView *locationImgView;
@property (nonatomic, strong) UILabel *locationlbl;
@property (nonatomic, strong) UILabel *viewCountlbl;
@property (nonatomic, strong) UIButton *praiseBtn;
@property (nonatomic, strong) UIButton *commentBtn;



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
        _commentBtn = [[UIButton alloc] init];
        [_commentBtn setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
        
        [self addSubview:_iconImgView];
        [self addSubview:_namelbl];
        [self addSubview:_timelbl];
        [self addSubview:_contentlbl];
        [self addSubview:_locationImgView];
        [self addSubview:_locationlbl];
        [self addSubview:_viewCountlbl];
        [self addSubview:_praiseBtn];
        [self addSubview:_commentBtn];
        
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
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.frame = CGRectFromString(topicHeaderFrameModel.imagesFrameArr[i]);
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:topicHeaderFrameModel.imagesFrameArr[i]]];
        [self addSubview:imageView];
    }

   
    
    _locationImgView.frame = topicHeaderFrameModel.locationImgViewFrame;
    
    _locationlbl.frame = topicHeaderFrameModel.locationlblFrame;
    _locationlbl.text = topicModel.location;
    
    _viewCountlbl.frame = topicHeaderFrameModel.viewCountFrame;
    _viewCountlbl.text = [NSString stringWithFormat:@"%@人浏览",topicModel.viewCount];
    _praiseBtn.frame = topicHeaderFrameModel.praiseFrame;
    _commentBtn.frame = topicHeaderFrameModel.commentFrame;

    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
