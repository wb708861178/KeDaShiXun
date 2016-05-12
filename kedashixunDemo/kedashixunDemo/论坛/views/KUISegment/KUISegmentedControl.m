//
//  KUISegmentedControl.m
//  SegmentedK
//
//  Created by vintop_xiaowei on 16/1/2.
//  Copyright © 2016年 vintop_DragonLi. All rights reserved.
//

#import "KUISegmentedControl.h"

@interface KUISegmentedControl ()<KUISegmentedControlDelegate>
{
    CGFloat widthFloat;
    UIView* buttonDown;
    NSInteger selectSeugment;
}
@end

@implementation KUISegmentedControl

-(void)AddSegumentArray:(NSArray *)SegumentArray
{
    NSInteger seugemtNumber=SegumentArray.count;
    widthFloat=(self.bounds.size.width)/seugemtNumber;
    for (int i=0; i<SegumentArray.count; i++) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(i*widthFloat, 0, widthFloat, self.bounds.size.height-2)];
        [button setTitle:SegumentArray[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:self.titleFont];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectColor forState:UIControlStateSelected];
        [button setTag:i];
        [button addTarget:self action:@selector(changeTheSegument:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            //            默认下划线高  2
            buttonDown=[[UIView alloc]initWithFrame:CGRectMake(i*widthFloat, self.bounds.size.height-2, widthFloat, 2)];
            
#pragma mark -----buttonDown 设置下划线颜色
            [buttonDown setBackgroundColor:[UIColor orangeColor]];
            [self addSubview:buttonDown];
        }
        [self addSubview:button];
        [self.ButtonArray addObject:button];
    }
    [[self.ButtonArray firstObject] setSelected:YES];
}


-(void)changeTheSegument:(UIButton*)button
{
    [self selectTheSegument:button.tag];
}


-(void)selectTheSegument:(NSInteger)segument
{
    if (selectSeugment!=segument) {
        [self.ButtonArray[selectSeugment] setSelected:NO];
        [self.ButtonArray[segument] setSelected:YES];
        [UIView animateWithDuration:0.1 animations:^{
            [buttonDown setFrame:CGRectMake(segument*widthFloat,self.bounds.size.height-2, widthFloat, 2)];
        }];
        selectSeugment=segument;
        [self.delegate uisegumentSelectionChange:selectSeugment];
    }
}
/**
 34 ---默认高度,可以根据项目需求自己更改
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    selectSeugment=0;
    self.ButtonArray=[NSMutableArray arrayWithCapacity:_ButtonArray.count];
    self.titleFont=[UIFont systemFontOfSize:17];
    self=[super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 44)];
    self.KBackGroundColor = [UIColor whiteColor];
    self.titleColor = [UIColor blackColor];
    self.selectColor=[UIColor blackColor];
    //    整体背景颜色
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

@end
