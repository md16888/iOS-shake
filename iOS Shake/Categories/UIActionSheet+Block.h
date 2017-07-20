//
//  UIActionSheet+Block.h
//  Refrence
//
//  Created by mac on 15/9/6.
//  Copyright (c) 2015年 turkeyaa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DismissBlock) (NSInteger buttonIndex);
typedef void(^CancelBlock) ();

@interface UIActionSheet (Block) <UIActionSheetDelegate>

+ (void)showSheetWithTitle:(NSString *)aTitle
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherTitles
                      view:(UIView *)aview
                 onDismiss:(DismissBlock)dismissed
                  onCancel:(CancelBlock)cancelled;

@end
