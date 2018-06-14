//
//  SubViewOne.m
//  ScrollViewAndScroView
//
//  Created by HENING on 2018/6/13.
//  Copyright © 2018年 HeNing. All rights reserved.
//

#import "SubViewOne.h"

@implementation SubViewOne

- (void)refresh{
    NSLog(@"刷新资讯数据");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}


@end
