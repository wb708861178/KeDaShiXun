//
//  KTopicCell.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTopicCell.h"
#import <UIImageView+WebCache.h>
#import "UIColor+HexColor.h"


@interface KTopicCell ()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *namelbl;
@property (nonatomic, strong) UILabel *timelbl;
@property (nonatomic, strong) UILabel *contentlbl;

@property (nonatomic, strong) UIImageView *topicTypeImgView;

@property (nonatomic, strong) UIImageView *imgView0;
@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;

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
        _namelbl.font = [UIFont systemFontOfSize:15];
        [self addSubview:_namelbl];
        
        _timelbl = [[UILabel alloc] init];
        _timelbl.font = [UIFont systemFontOfSize:12];
        [self addSubview:_timelbl];

        _contentlbl = [[UILabel alloc] init];
        _contentlbl.font = [UIFont systemFontOfSize:14];
        [self addSubview:_contentlbl];
        
        _imgView0 = [[UIImageView alloc] init];
        _imgView0.contentMode = UIViewContentModeScaleAspectFill;
        _imgView0.clipsToBounds = YES;
        [self addSubview:_imgView0];
        
        _imgView1 = [[UIImageView alloc] init];
        _imgView1.contentMode = UIViewContentModeScaleAspectFill;
        _imgView1.clipsToBounds = YES;
        [self addSubview:_imgView1];

        _imgView2 = [[UIImageView alloc] init];
        _imgView2.contentMode = UIViewContentModeScaleAspectFill;
        _imgView2.clipsToBounds = YES;
        [self addSubview:_imgView2];

        _locationImgView = [[UIImageView alloc] init];
        _locationImgView.image = [UIImage imageNamed:@"weizhi"];
        [self addSubview:_locationImgView];
        
        _locationlbl = [[UILabel alloc] init];
        _locationlbl.font = [UIFont systemFontOfSize:12];
        [self addSubview:_locationlbl];

        _viewCountlbl = [[UILabel alloc] init];
        _viewCountlbl.font = [UIFont systemFontOfSize:12];
        [self addSubview:_viewCountlbl];

        _praiseBtn = [[UIButton alloc] init];
        [_praiseBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
        [_praiseBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        _praiseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_praiseBtn];

        _commentBtn = [[UIButton alloc] init];
        [_commentBtn setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
        [_commentBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:15];

        [self addSubview:_commentBtn];

        
    }
    
    return self;
    
}


- (void)setTopicFrameModel:(KTopicFrameModel *)topicFrameModel{
    
    _topicFrameModel = topicFrameModel;
    KTopicModel *topicModel = topicFrameModel.topicModel;
    
    _iconImgView.frame = topicFrameModel.iconFrame;
    _iconImgView.layer.cornerRadius = _iconImgView.frame.size.width/2;
    _iconImgView.layer.masksToBounds = YES;
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
                _imgView0.frame = CGRectFromString(topicFrameModel.imagesFrameArr[0]);
                [_imgView1 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[0]]];
                
            }
                break;
            case 2:{
                _imgView0.frame = CGRectFromString(topicFrameModel.imagesFrameArr[0]);
                [_imgView0 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[0]]];
                _imgView1.frame = CGRectFromString(topicFrameModel.imagesFrameArr[1]);
                [_imgView1 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[1]]];
                
            }
                break;
            case 3:{
                _imgView0.frame = CGRectFromString(topicFrameModel.imagesFrameArr[0]);
                [_imgView0 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[0]]];
                _imgView1.frame = CGRectFromString(topicFrameModel.imagesFrameArr[1]);
                [_imgView1 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[1]]];
                _imgView2.frame = CGRectFromString(topicFrameModel.imagesFrameArr[2]);
                [_imgView2 sd_setImageWithURL:[NSURL URLWithString:topicModel.imagesUrlArr[2]]];
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

    _praiseBtn.frame = topicFrameModel.praiseFrame;
    [_praiseBtn setTitle:topicModel.supportnum forState:UIControlStateNormal];
    
    _commentBtn.frame = topicFrameModel.commentFrame;
}

- (void)setCommentCount:(NSString *)commentCount{
    
    _commentCount = commentCount;
    [_commentBtn setTitle:commentCount forState:UIControlStateNormal];
}

- (void)prepareForReuse{
    
    [super prepareForReuse];
    
    //清空图片
    _imgView0.frame = (CGRect){_imgView1.frame.origin,CGSizeMake(0, 0)};
    _imgView1.frame = (CGRect){_imgView1.frame.origin,CGSizeMake(0, 0)};
    _imgView2.frame = (CGRect){_imgView1.frame.origin,CGSizeMake(0, 0)};
    _imgView0.image = nil;
    _imgView1.image = nil;
    _imgView2.image = nil;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
