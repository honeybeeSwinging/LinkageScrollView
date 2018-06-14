//
//  TopMenuView.m
//  CampusHeadlines3.0
//
//  Created by baisen on 2016/11/25.
//  Copyright © 2016年 besonit. All rights reserved.
//

#import "TopMenuView.h"

@interface TopMenuView ()

@property (nonatomic,strong)    UIView              *lineView;
@property (nonatomic,strong)    NSMutableArray      *buttonArray;
@property (nonatomic,strong)    NSMutableArray      *titleArray;
@property (nonatomic,strong)    UIColor             *nomalTitleColor;
@property (nonatomic,strong)    UIColor             *heighTitleColor;
@property (nonatomic,strong)    UIColor             *bottomLineColor;
@property (nonatomic,assign)    CGFloat             bottomLineWidth;
@property (nonatomic,assign)    CGFloat             bottomLineHeight;
@property (nonatomic,assign)    UIFont              *titleFont;

@end

@implementation TopMenuView

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray{
    return [self initWithFrame:frame
                 andTitleArray:titleArray
                    titleColor:[UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1]
               titleHeighColor:[UIColor colorWithRed:0 green:141/255.0 blue:142/255.0 alpha:1]
                     lineColor:[UIColor colorWithRed:0 green:141/255.0 blue:142/255.0 alpha:1]
                     lineWidth:15 lineHeight:3.0
                      withFont:[UIFont systemFontOfSize:16]];
}

- (instancetype)initWithFrame:(CGRect)frame
                andTitleArray:(NSArray *)titleArray
                   titleColor:(UIColor *)titleColor
              titleHeighColor:(UIColor *)heighColor
                    lineColor:(UIColor *)lineColor
                    lineWidth:(CGFloat)width
                   lineHeight:(CGFloat)height
                     withFont:(UIFont *)font{
    self = [super initWithFrame:frame];
    if (self){
        self.layer.masksToBounds = YES;
        self.frame = frame;
        self.titleArray = [NSMutableArray array];
        self.buttonArray = [NSMutableArray array];
        
        self.nomalTitleColor = titleColor;
        self.heighTitleColor = heighColor;
        self.bottomLineColor = lineColor;
        self.bottomLineWidth = width;
        self.bottomLineHeight = height;
        self.titleFont = font;
        
        [self.titleArray addObjectsFromArray:titleArray];        
        [self loadViewUI];
    }
    return self;
}

- (void)loadViewUI{
    CGFloat btnW = self.bounds.size.width*1.0/self.titleArray.count;
    
    /**
     *  选中按钮标识处理
     */
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, btnW, self.bounds.size.height)];
    self.lineView.backgroundColor = [UIColor clearColor];
    self.lineView.userInteractionEnabled = YES;
    [self addSubview:self.lineView];
    
    UIView *selecLineview = [[UIView alloc]initWithFrame:CGRectMake((btnW-self.bottomLineWidth)/2.0,self.bounds.size.height-self.bottomLineHeight, self.bottomLineWidth, self.bottomLineHeight)];
    selecLineview.backgroundColor = self.bottomLineColor;
    selecLineview.userInteractionEnabled = YES;
    [self.lineView addSubview:selecLineview];
    
    /**
     *  初始化按钮
     */
    for (int i=0; i<self.titleArray.count; i++){
        CGFloat orignX = btnW*i;
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(orignX, 1, btnW, self.bounds.size.height-self.bottomLineHeight);
        selectBtn.titleLabel.font = self.titleFont;
        [selectBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        selectBtn.backgroundColor = [UIColor clearColor];
        UIColor *color = (i==0)?self.heighTitleColor:self.nomalTitleColor;
        [selectBtn setTitleColor:color forState:UIControlStateNormal];
        selectBtn.tag = 100+i;
        
        [selectBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectBtn];
        [self.buttonArray addObject:selectBtn];
    }
}

- (void)menuBtnAction:(UIButton *)sender{
    for (UIButton *allButton in self.buttonArray) {
        UIColor *color = (allButton.tag == sender.tag)?self.heighTitleColor:self.nomalTitleColor;
        [allButton setTitleColor:color forState:UIControlStateNormal];
    }
    
    sender.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.center = sender.center;
    } completion:^(BOOL finished) {
        sender.userInteractionEnabled = YES;
    }];
    
    if ([self.delegate respondsToSelector:@selector(refreshWithTag:)]){
        [self.delegate refreshWithTag:(sender.tag-100)];
    }
}

- (void)selectItemChangedWithSelectedIndex:(NSInteger)intIndex{
    UIButton *button = (UIButton *)[self viewWithTag:(intIndex+100)];
    [self selectItemGestureRecognizerOperationButtonEvent:button];
}

- (void)selectItemGestureRecognizerOperationButtonEvent:(UIButton *)sender{
    [UIView animateWithDuration:0.1 animations:^{
        self.lineView.center = sender.center;
        for (UIButton *itemButton in self.buttonArray) {
            UIColor *color = (itemButton.tag == sender.tag)?self.heighTitleColor:self.nomalTitleColor;
            [itemButton setTitleColor:color forState:UIControlStateNormal];
        }
    } completion:^(BOOL finished) {
        
        sender.userInteractionEnabled = YES;
    }];
}

@end

