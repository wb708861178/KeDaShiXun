//
//  KTextView.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTextView.h"
#import "UIView+Extension.h"

@interface KTextView ()

@property (nonatomic , strong) UILabel *placeholderLabel;


@end


@implementation KTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        
        //添加一个现实提醒文字的label
        UILabel *placehoderLabel = [[UILabel alloc] init];
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:placehoderLabel];
        
        self.placeholderLabel = placehoderLabel;
        
        //设置默认文字颜色
        self.placeholderColor = [UIColor lightGrayColor];
        
        //设置默认字体
        self.font = [UIFont systemFontOfSize:17];
        
        //监听内部文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        //为textview添加一个手势
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewOnClick)];
        [self addGestureRecognizer:gesture];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //添加一个现实提醒文字的label
        UILabel *placehoderLabel = [[UILabel alloc] init];
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:placehoderLabel];
        
        self.placeholderLabel = placehoderLabel;
        
        //设置默认文字颜色
        self.placeholderColor = [UIColor lightGrayColor];
        
        //设置默认字体
        self.font = [UIFont systemFontOfSize:17];
        
        //监听内部文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        //为textview添加一个手势
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewOnClick)];
        [self addGestureRecognizer:gesture];
    }
    
    return self;
}

- (void)textViewOnClick {
    
    [self becomeFirstResponder];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 监听文字改变
- (void)textDidChange{
    
    self.placeholderLabel.hidden = self.hasText;
}

#pragma mark - 公共方法
- (void)setText:(NSString *)text {
    
    [super setText:text];
    [self textDidChange];
}


- (void)setAttributedText:(NSAttributedString *)attributedText {
    
    [super setAttributedText:attributedText];
    [self textDidChange];
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = placeholder;
    //设置文字
    self.placeholderLabel.text = placeholder;
    //重新计算子控件frame
    [self setNeedsLayout];
    
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
    
}


- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.placeholderLabel.y = 8;
    self.placeholderLabel.x = 5;
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x ;
    
    CGSize maxSize = CGSizeMake(self.placeholderLabel.width, MAXFLOAT);
    
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    CGSize textSize = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    self.placeholderLabel.height = textSize.height;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
