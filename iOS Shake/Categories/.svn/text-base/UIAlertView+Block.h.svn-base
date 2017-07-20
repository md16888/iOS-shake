//
//  UIAlertView+Block.h
//  Refrence
//
//  Created by mac on 15/9/4.
//  Copyright (c) 2015年 turkeyaa. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DismissBlock)(NSInteger buttonIndex);
typedef void(^CancelBlock)();

@interface UIAlertView (Block) <UIAlertViewDelegate>


+ (void)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                      otherButtonTitles:(NSArray *)otherButtons
                              onDismiss:(DismissBlock)dismissed
                               onCancel:(CancelBlock)cancelled;

// 提示
+ (void)showAlertViewWIthTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle;

@end
