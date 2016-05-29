//
//  KCommentCell.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/12.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KCommentCell.h"
#import <UIImageView+WebCache.h>


@interface KCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (weak, nonatomic) IBOutlet UILabel *namelbl;

@property (weak, nonatomic) IBOutlet UILabel *timelbl;
@property (weak, nonatomic) IBOutlet UILabel *commentContent;

@end

@implementation KCommentCell

- (void)awakeFromNib {
    // Initialization code
    _iconImgView.layer.cornerRadius = _iconImgView.frame.size.width/2;
    _iconImgView.layer.masksToBounds = YES;
    
}


- (void)setCommentModel:(KCommentModel *)commentModel{
    
    _commentModel = commentModel;
    
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:commentModel.icon]];
    
    _namelbl.text = commentModel.nickname;
    _timelbl.text = commentModel.date;
    _commentContent.text = commentModel.content;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
