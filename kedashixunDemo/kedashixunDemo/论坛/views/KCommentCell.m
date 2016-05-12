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
}


- (void)setCommentModel:(KCommentModel *)commentModel{
    
    _commentModel = commentModel;
    
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:commentModel.icon]];
    //----------Test
    
    _iconImgView.image = [UIImage imageNamed:@"personal_icon"];
    
    //-----------
    
    _namelbl.text = commentModel.name;
    _timelbl.text = commentModel.time;
    _commentContent.text = commentModel.commentContent;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
