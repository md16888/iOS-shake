//
//  UIActionSheet+Block.m
//  Refrence
//
//  Created by mac on 15/9/6.
//  Copyright (c) 2015年 turkeyaa. All rights reserved.
//

#import "UIActionSheet+Block.h"

static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;

@implementation UIActionSheet (Block)


+ (void)showSheetWithTitle:(NSString *)aTitle
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherTitles
                      view:(UIView *)aview
                 onDismiss:(DismissBlock)dismissed
                  onCancel:(CancelBlock)cancelled {
    _dismissBlock = dismissed;
    _cancelBlock = cancelled;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:aTitle delegate:[self self] cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    for (NSString *buttonTitle in otherTitles) {
        [sheet addButtonWithTitle:buttonTitle];
    }
    [sheet showInView:aview];
}

+ (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        _cancelBlock();
    }
    else {
        _dismissBlock(buttonIndex-1);  // 取消按钮是 0
    }
}

@end
