//
//  ShakeResultViewController.m
//  CureFunNew
//
//  Created by modong on 2017/7/19.
//  Copyright © 2017年 TLQ. All rights reserved.
//

#import "ShakeResultViewController.h"
#import "UIColor+tools.h"

#define ShakeResultTextColor [UIColor colorWithHexString:@"73201b"]

@interface ShakeResultViewController ()
{
    ShakeResultType _shakeType;
}

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *miImageView;
@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) NSDictionary *imageDictionary;
@end

@implementation ShakeResultViewController

- (NSDictionary *)imageDictionary
{
    if (!_imageDictionary)
    {
        _imageDictionary = @{[NSNumber numberWithUnsignedInteger:ShakeResultType_Exam]: @[@"ShakeResultType_Exam", @"Type_Exam"],
                             [NSNumber numberWithUnsignedInteger:ShakeResultType_Challenge]: @[@"ShakeResultType_Challenge", @"Type_Challenge"],
                             [NSNumber numberWithUnsignedInteger:ShakeResultType_Score]: @[@"ShakeResultType_Score", @"Type_Score"],};
    }
    return _imageDictionary;
}

- (UIImageView *)backImageView
{
    if (!_backImageView)
    {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.backgroundColor = [UIColor clearColor];
        _backImageView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imageName = [self.imageDictionary objectForKey:[NSNumber numberWithUnsignedInteger:_shakeType]][0];
        _backImageView.image = [UIImage imageNamed:imageName];
    }
    return _backImageView;
}

- (UIImageView *)miImageView
{
    if (!_miImageView)
    {
        _miImageView = [[UIImageView alloc] init];
        _miImageView.backgroundColor = [UIColor clearColor];
        _miImageView.contentMode = UIViewContentModeScaleAspectFit;
        _miImageView.image = [UIImage imageNamed:@"ShakeMi"];
    }
    return _miImageView;
}


- (UIImageView *)typeImageView
{
    if (!_typeImageView)
    {
        _typeImageView = [[UIImageView alloc] init];
        _typeImageView.backgroundColor = [UIColor clearColor];
        _typeImageView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imageName = [self.imageDictionary objectForKey:[NSNumber numberWithUnsignedInteger:_shakeType]][1];
        _typeImageView.image = [UIImage imageNamed:imageName];
    }
    return _typeImageView;
}

- (UILabel *)textLabel
{
    if (!_textLabel)
    {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = ShakeResultTextColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (UIButton *)okButton
{
    if (!_okButton)
    {
        _okButton = [[UIButton alloc] init];
        [_okButton setBackgroundImage:[UIImage imageNamed:@"ShakeOK"] forState:UIControlStateNormal];
        [_okButton setTitleColor:ShakeResultTextColor forState:UIControlStateNormal];
        _okButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _okButton.tag = 110001;
        [_okButton addTarget:self action:@selector(buttonDone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"ShakeCancel"] forState:UIControlStateNormal];
        [_cancelButton setTintColor:ShakeResultTextColor];
        _cancelButton.tag = 110000;
        [_cancelButton addTarget:self action:@selector(buttonDone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (void)buttonDone:(UIButton *)button
{
    
    if (110001 == button.tag)
    {
        // 110001:考试   110002:比赛   110003:积分
        ShakeResultClickItem item = ShakeResultClickItem_Exam;
        if (_shakeType == ShakeResultType_Challenge)
        {
            item = ShakeResultClickItem_Challenge;
        }
        else if (_shakeType == ShakeResultType_Score)
        {
            item = ShakeResultClickItem_Score;
        }
        
        if (self.clickItemBlock)
        {
            self.clickItemBlock(item);
        }
    }
    else if (110000 == button.tag)
    {
        // 110000:取消
        if (self.clickItemBlock)
        {
            self.clickItemBlock(ShakeResultClickItem_Cancel);
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithShakeResultType:(ShakeResultType)type
{
    if (self = [super init])
    {
        _shakeType = type;
        
        [self initUI];
        [self initLayout];
    }
    return self;
}

- (void)initUI
{
    [self.view addSubview:self.backImageView];
    [self.backImageView addSubview:self.miImageView];
    [self.backImageView addSubview:self.typeImageView];
    [self.backImageView addSubview:self.textLabel];
    [self.view addSubview:self.okButton];
    [self.view addSubview:self.cancelButton];
}

- (void)initLayout
{
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    CGFloat x = frame.size.width/12;
    CGFloat y = frame.size.height/5;
    self.backImageView.frame = CGRectMake(x, y, frame.size.width*5/6, frame.size.height/2);
    
    CGRect rect = self.backImageView.frame;
    CGFloat miImageX = rect.size.width*0.36;
    CGFloat miImageY = rect.size.height*0.28;
    CGFloat miImageWidthAndHeight = rect.size.width*0.28;
    self.miImageView.frame = CGRectMake(miImageX, miImageY, miImageWidthAndHeight, miImageWidthAndHeight);
    
    CGFloat typeImageX = rect.size.width*0.4;
    CGFloat typeImageY = rect.size.height*0.34;
    CGFloat typeImageWidthAndHeight = rect.size.width*0.2;
    self.typeImageView.frame = CGRectMake(typeImageX, typeImageY, typeImageWidthAndHeight, typeImageWidthAndHeight);
    
    CGFloat textLabelX = 0;
    CGFloat textLabelY = rect.size.height*0.62;
    self.textLabel.frame = CGRectMake(textLabelX, textLabelY, rect.size.width, 40);
    
    CGFloat okButtonX = frame.size.width*0.355;
    CGFloat okButtonY = frame.size.height*0.577;
    CGFloat okButtonWidth = frame.size.width*0.29;
    CGFloat okButtonHeight = frame.size.height*0.056;
    self.okButton.frame = CGRectMake(okButtonX, okButtonY, okButtonWidth, okButtonHeight);
    
    CGFloat cancelButtonWidth = frame.size.width*0.084;
    CGFloat cancelButtonX = frame.size.width*0.458;
    CGFloat cancelButtonY = frame.size.height*0.037 + CGRectGetMaxY(self.backImageView.frame);
    self.cancelButton.frame = CGRectMake(cancelButtonX, cancelButtonY, cancelButtonWidth, cancelButtonWidth);
}

- (void)setLabelText:(NSString *)labelString buttonTitle:(NSString *)buttonTitle
{
    self.textLabel.text = labelString;
    [self.okButton setTitle:buttonTitle forState:UIControlStateNormal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
