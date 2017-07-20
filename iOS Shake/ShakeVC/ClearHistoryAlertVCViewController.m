//
//  ClearHistoryAlertVCViewController.m
//  CureFunNew
//
//  Created by modong on 2017/7/19.
//  Copyright © 2017年 TLQ. All rights reserved.
//

#import "ClearHistoryAlertVCViewController.h"

@interface ClearHistoryAlertVCViewController ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation ClearHistoryAlertVCViewController

- (UIView *)backView
{
    if (!_backView)
    {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
    }
    return _backView;
}

- (UIImageView *)headImageView
{
    if (!_headImageView)
    {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"ClearHistory"];
        _headImageView.backgroundColor = [UIColor clearColor];
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"确定清空摇到的历史？";
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel)
    {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.textColor = [UIColor colorWithHexString:@"666666"];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.text = @"清空后无法恢复";
        _detailLabel.font = [UIFont systemFontOfSize:13];
    }
    return _detailLabel;
}

- (UIButton *)clearButton
{
    if (!_clearButton)
    {
        _clearButton = [[UIButton alloc] init];
        _clearButton.backgroundColor = [UIColor colorWithHexString:@"068efb"];
        [_clearButton setTitle:@"清空" forState:UIControlStateNormal];
        [_clearButton setTintColor:[UIColor whiteColor]];
        _clearButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _clearButton.tag = 100001;
        _clearButton.layer.cornerRadius = 5;
        _clearButton.layer.borderWidth = 2;
        _clearButton.layer.borderColor = [UIColor colorWithHexString:@"0080d0"].CGColor;
        [_clearButton addTarget:self action:@selector(buttonDone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [[UIButton alloc] init];
        _cancelButton.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTintColor:[UIColor colorWithHexString:@"333333"]];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelButton.tag = 100002;
        _cancelButton.layer.cornerRadius = 5;
        _cancelButton.layer.borderWidth = 2;
        _cancelButton.layer.borderColor = [UIColor colorWithHexString:@"d5d5d5"].CGColor;
        [_cancelButton addTarget:self action:@selector(buttonDone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (void)buttonDone:(UIButton *)button
{
    if (self.clickItemBlock)
    {
        self.clickItemBlock(button.tag);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.headImageView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.detailLabel];
    [self.backView addSubview:self.clearButton];
    [self.backView addSubview:self.cancelButton];
}

- (void)initLayout
{
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    CGFloat x = frame.size.width/8;
    CGFloat y = frame.size.height/4;
    self.backView.frame = CGRectMake(x, y, frame.size.width*3/4, frame.size.height/2);
    
    CGRect rect = self.backView.frame;
    CGFloat headImageHeight = rect.size.height*2/5;
    self.headImageView.frame = CGRectMake(rect.size.width/4, 20, rect.size.width/2, headImageHeight);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.headImageView.frame), rect.size.width, 20);
    self.detailLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), rect.size.width, 20);
    
    CGFloat buttonX = 20;
    CGFloat buttonHeight = 40;
    CGFloat buttonWidth = (rect.size.width-buttonX*3)/2;
    CGFloat buttonY = rect.size.height-buttonHeight-20;
    
    self.clearButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    self.cancelButton.frame = CGRectMake(buttonX*2+buttonWidth, buttonY, buttonWidth, buttonHeight);
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
