//
//  SubViewTwo.m
//  ScrollViewAndScroView
//
//  Created by HENING on 2018/6/13.
//  Copyright © 2018年 HeNing. All rights reserved.
//

#import "SubViewTwo.h"

@implementation SubViewTwo

- (void)refresh{
    NSLog(@"刷新消息数据");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



@end
