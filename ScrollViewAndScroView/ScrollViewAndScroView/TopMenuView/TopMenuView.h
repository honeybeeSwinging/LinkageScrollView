//
//  TopMenuView.h
//  CampusHeadlines3.0
//
//  Created by baisen on 2016/11/25.
//  Copyright © 2016年 besonit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopMenuViewDelegate <NSObject>

- (void)refreshWithTag:(NSInteger)menuTag;

@end

@interface TopMenuView : UIView

@property (nonatomic,weak)      id<TopMenuViewDelegate>delegate;


/**
 第一种初始化方法

 @param frame viewFrame
 @param titleArray 标题数组
 @return TopMenuView
 */
- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray;


/**
 第二种初始化方法

 @param frame viewFrame
 @param titleArray 标题数组
 @param titleColor 标题颜色
 @param heighColor 选中的标题颜色
 @param lineColor 选中按钮的底部横线颜色
 @param width 选中按钮底部横线宽度
 @param height 选中按钮底部横线高度度
 @param font 标题字体大小
 @return TopMenuView
 */
- (id)initWithFrame:(CGRect)frame
      andTitleArray:(NSArray *)titleArray
         titleColor:(UIColor *)titleColor
         titleHeighColor:(UIColor *)heighColor
          lineColor:(UIColor *)lineColor
          lineWidth:(CGFloat)width
         lineHeight:(CGFloat)height
           withFont:(UIFont *)font;

// 滑动或代码修改当前选中按钮
- (void)selectItemChangedWithSelectedIndex:(NSInteger)intIndex;

@end
