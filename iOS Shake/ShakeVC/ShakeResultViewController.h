//
//  ShakeResultViewController.h
//  CureFunNew
//
//  Created by modong on 2017/7/19.
//  Copyright © 2017年 TLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockItem)(NSInteger index);

typedef NS_ENUM(NSUInteger, ShakeResultType)
{
    ShakeResultType_Exam,
    ShakeResultType_Challenge,
    ShakeResultType_Score,
};

typedef NS_ENUM(NSUInteger, ShakeResultClickItem)
{
    ShakeResultClickItem_Cancel = 110000,
    ShakeResultClickItem_Exam,
    ShakeResultClickItem_Challenge,
    ShakeResultClickItem_Score,
};

@interface ShakeResultViewController : UIViewController
@property (nonatomic, copy) BlockItem clickItemBlock;   // 110000:取消    110001:考试   110002:比赛   110003:积分
- (instancetype)initWithShakeResultType:(ShakeResultType)type;
- (void)setLabelText:(NSString *)labelString buttonTitle:(NSString *)buttonTitle;
@end
