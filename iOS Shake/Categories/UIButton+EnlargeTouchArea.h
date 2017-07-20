//
//  UIButton+EnlargeTouchArea.h
//  wealth
//
//  Created by majian on 14-4-23.
//  Copyright (c) 2014年 kejia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)
/**
 *  修改按钮触发范围，正数扩大点击范围
 *
 *  @param top    上
 *  @param right  右
 *  @param bottom 下
 *  @param left   左
 */
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end
