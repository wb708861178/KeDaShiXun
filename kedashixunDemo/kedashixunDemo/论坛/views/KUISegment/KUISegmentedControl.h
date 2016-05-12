//
//  KUISegmentedControl.h
//  SegmentedK
//
//  Created by vintop_xiaowei on 16/1/2.
//  Copyright © 2016年 vintop_DragonLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KUISegmentedControlDelegate< NSObject>

@optional
/**
 外界调用获取点击下标
 */
-(void)uisegumentSelectionChange:(NSInteger)selection;
@end
@interface KUISegmentedControl : UIView

@property(nonatomic,strong)id <KUISegmentedControlDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *ButtonArray;/**< 对应的标题文字 */
@property(strong,nonatomic)UIColor *KBackGroundColor;/**< BackGround颜色 */
@property(strong,nonatomic)UIColor *titleColor;/**< 标题文字颜色 */
@property(strong,nonatomic)UIColor *selectColor;/**< 选中按钮的颜色 */
@property(strong,nonatomic)UIFont *titleFont;/**< 字体大小 */

-(void)AddSegumentArray:(NSArray *)SegumentArray;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)selectTheSegument:(NSInteger)segument;
@end
