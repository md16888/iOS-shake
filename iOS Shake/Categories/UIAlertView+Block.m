//
//  UIAlertView+Block.m
//  Refrence
//
//  Created by mac on 15/9/4.
//  Copyright (c) 2015年 turkeyaa. All rights reserved.
//

#import "UIAlertView+Block.h"

static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;

@implementation UIAlertView (Block)

+ (void)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                      otherButtonTitles:(NSArray *)otherButtons
                              onDismiss:(DismissBlock)dismissed
                               onCancel:(CancelBlock)cancelled {
    _dismissBlock = dismissed;
    _cancelBlock = cancelled;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:[self class] cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    
    for (NSString *buttonTitle in otherButtons) {
        [alertView addButtonWithTitle:buttonTitle];
    }
    
    [alertView show];
}

+ (void)showAlertViewWIthTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:[self class] cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    [alertView show];
}

+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
    if (buttonIndex == [alertView cancelButtonIndex]) {
        if (_cancelBlock) {
            _cancelBlock();
        }
    }
    else {
        _dismissBlock(buttonIndex - 1);
    }
}

@end
