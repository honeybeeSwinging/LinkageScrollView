//
//  TESTFloatingView.m
//  TEST_Common
//
//  Created by luxiaoming on 15/5/25.
//  Copyright (c) 2015年 luxiaoming. All rights reserved.
//

#import "ScrollHeaderView.h"

@implementation ScrollHeaderView

- (void)drawRect:(CGRect)rect{
    UIImage *imageBG = [UIImage imageNamed:@"bg"];
    CGFloat width = rect.size.width;
    CGFloat height = imageBG.size.height/imageBG.size.width*width;
    
    CGRect rec = CGRectMake(0, 10, width, height);
    [imageBG drawInRect:rec blendMode:kCGBlendModeNormal alpha:1.0];
//    [_image drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *result = [super hitTest:point withEvent:event];
//    if (result == self) {
//        return nil;
//    } else {
//        return result;
//    }
//}

@end
