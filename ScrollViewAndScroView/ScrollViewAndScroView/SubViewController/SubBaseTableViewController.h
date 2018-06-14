//
//  SubBaseTableViewController.h
//  ScrollViewAndScroView
//
//  Created by HENING on 2018/6/13.
//  Copyright © 2018年 HeNing. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 *  头部view的高度， 很重要
 */
static const CGFloat headerViewHeight = 220;

@protocol PagemenuDelegate <NSObject>

- (void) scrollChangedOffset:(CGFloat)offset scrollView:(UIScrollView *)scrollview;

@end

@interface SubBaseTableViewController : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)    UITableView                 *mainTableView;
@property (nonatomic,weak)      id<PagemenuDelegate>        delegate;

// 数据处理
-(void)refresh;

@end
