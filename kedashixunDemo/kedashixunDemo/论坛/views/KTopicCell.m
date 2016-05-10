//
//  KTopicCell.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTopicCell.h"
#import <UIImageView+WebCache.h>

@interface KTopicCell ()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *namelbl;
@property (nonatomic, strong) UILabel *timelbl;
@property (nonatomic, strong) UILabel *contentlbl;

@property (nonatomic, strong) UIImageView *topicTypeImgView;

@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;
@property (nonatomic, strong) UIImageView *imgView3;

@property (nonatomic, strong) UIImageView *locationImgView;
@property (nonatomic, strong) UILabel *locationlbl;


@property (nonatomic, strong) UILabel *viewCountlbl;

@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UIButton *praiseBtn;
@property (nonatomic, strong) UIButton *commentBtn;


@end

@implementation KTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconImgView = [[UIImageView alloc] init];
        [self addSubview:_iconImgView];
        
        _namelbl = [[UILabel alloc] init];
        _namelbl.font = [UIFont systemFontOfSize:17];
        [self addSubview:_namelbl];
        
        _timelbl = [[UILabel alloc] init];
        _timelbl.font = [UIFont systemFontOfSize:14];
        [self addSubview:_timelbl];

        _contentlbl = [[UILabel alloc] init];
        _contentlbl.font = [UIFont systemFontOfSize:17];
        [self addSubview:_contentlbl];
        
        _imgView1 = [[UIImageView alloc] init];
        [self addSubview:_imgView1];

        _imgView2 = [[UIImageView alloc] init];
        [self addSubview:_imgView2];

        _imgView3 = [[UIImageView alloc] init];
        [self addSubview:_imgView3];

        _locationImgView = [[UIImageView alloc] init];
        _locationImgView.image = nil;
        [self addSubview:_locationImgView];
        
        _locationlbl = [[UILabel alloc] init];
        _locationlbl.font = [UIFont systemFontOfSize:14];
        [self addSubview:_locationlbl];

        _viewCountlbl = [[UILabel alloc] init];
        _viewCountlbl.font = [UIFont systemFontOfSize:14];
        [self addSubview:_viewCountlbl];

        _collectBtn = [[UIButton alloc] init];
        [self addSubview:_collectBtn];

        _praiseBtn = [[UIButton alloc] init];
        [self addSubview:_collectBtn];

        _commentBtn = [[UIButton alloc] init];
        [self addSubview:_collectBtn];

        
    }
    
    return self;
    
}


- (void)setTopicFrameModel:(KTopicFrameModel *)topicFrameModel{
    
    _topicFrameModel = topicFrameModel;
    KTopicModel *topicModel = topicFrameModel.topicModel;
    
    _iconImgView.frame = topicFrameModel.iconFrame;
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:topicModel.iconName]];
    _namelbl.frame = topicFrameModel.nameFrame;
    _namelbl.text = topicModel.name;
    _timelbl.frame = topicFrameModel.timeFrame;
    _timelbl.text = topicModel.time;
    _contentlbl.frame = topicFrameModel.contentFrame;
    _contentlbl.text = topicModel.content;
    _contentlbl.numberOfLines = 0;
    
    
    
    if (topicFrameModel.imagesFrameArr.count) {
        
        switch (topicFrameModel.imagesFrameArr.count) {
            case 1:{
                _imgView1.frame = CGRectFromString(topicFrameModel.imagesFrameArr[1]);
                [_imgView1 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[1]]];
                
            }
                break;
            case 2:{
                _imgView1.frame = CGRectFromString(topicFrameModel.imagesFrameArr[1]);
                [_imgView1 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[1]]];
                _imgView2.frame = CGRectFromString(topicFrameModel.imagesFrameArr[2]);
                [_imgView2 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[2]]];
                
            }
                break;
            case 3:{
                _imgView1.frame = CGRectFromString(topicFrameModel.imagesFrameArr[1]);
                [_imgView1 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[1]]];
                _imgView2.frame = CGRectFromString(topicFrameModel.imagesFrameArr[2]);
                [_imgView2 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[2]]];
                _imgView3.frame = CGRectFromString(topicFrameModel.imagesFrameArr[3]);
                [_imgView3 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[3]]];
            }
                break;
                
            default:
                break;
        }
    }
    
    _locationImgView.frame = topicFrameModel.locationImgViewFrame;
    
    _locationlbl.frame = topicFrameModel.locationlblFrame;
    _locationlbl.text = topicModel.location;

    _viewCountlbl.frame = topicFrameModel.viewCountFrame;
    _viewCountlbl.text = [NSString stringWithFormat:@"%@人浏览",topicModel.viewCount];
    _collectBtn.frame = topicFrameModel.collectFrame;
    _praiseBtn.frame = topicFrameModel.praiseFrame;
    _commentBtn.frame = topicFrameModel.commentFrame;
}



- (void)prepareForReuse{
    
    [super prepareForReuse];
    
    //清空图片
    _imgView1.frame = (CGRect){_imgView1.frame.origin,CGSizeMake(0, 0)};
    _imgView2.frame = (CGRect){_imgView1.frame.origin,CGSizeMake(0, 0)};
    _imgView3.frame = (CGRect){_imgView1.frame.origin,CGSizeMake(0, 0)};
    _imgView1.image = nil;
    _imgView2.image = nil;
    _imgView3.image = nil;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
