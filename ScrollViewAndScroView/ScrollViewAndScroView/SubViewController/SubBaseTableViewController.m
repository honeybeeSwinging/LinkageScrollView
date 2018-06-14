//
//  SubBaseTableViewController.m
//  ScrollViewAndScroView
//
//  Created by HENING on 2018/6/13.
//  Copyright © 2018年 HeNing. All rights reserved.
//

#import "SubBaseTableViewController.h"

@interface SubBaseTableViewController()

@end

@implementation SubBaseTableViewController

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height) style:UITableViewStylePlain];
        /// 非常重要的设置
        _mainTableView.contentInset = UIEdgeInsetsMake(headerViewHeight, 0, 0, 0);
        [_mainTableView setBackgroundColor:[UIColor clearColor]];
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _mainTableView;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        [self loadSubView];
    }
    return self;
}

#pragma mark- 请求
-(void)refresh{
    
}

- (void)loadSubView{
    [self addSubview:self.mainTableView];
    self.mainTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行", @(indexPath.row)];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
//    if (self.scrollStyle==ManualScrollStyle) {
        if ([self.delegate respondsToSelector:@selector(scrollChangedOffset:scrollView:)]) {
            [self.delegate scrollChangedOffset:offsetY scrollView:scrollView];
        }
//    }
}

@end
