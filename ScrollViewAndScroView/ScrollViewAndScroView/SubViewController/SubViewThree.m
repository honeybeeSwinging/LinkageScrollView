//
//  SubViewThree.m
//  ScrollViewAndScroView
//
//  Created by HENING on 2018/6/13.
//  Copyright © 2018年 HeNing. All rights reserved.
//

#import "SubViewThree.h"

@implementation SubViewThree

- (void)refresh{
    NSLog(@"刷新资料数据");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


@end
