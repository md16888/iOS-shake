//
//  ShakeViewController.m
//  iOS shakeshake
//
//  Created by modong on 2017/7/10.
//  Copyright © 2017年 modong. All rights reserved.
//

#import "ShakeViewController.h"
#import "ShakeSettingViewController.h"
#import "ShakeResultViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
///设备宽高
#define DEVICE_HEIGHT   ([[UIScreen mainScreen]bounds].size.height)
#define DEVICE_WIDTH    ([[UIScreen mainScreen]bounds].size.width)
#define TAB_HEIGHT 49
#define NAV_HEIGHT 44
#define STATUS_HEIGHT 20
#define WP(value)   ((DEVICE_WIDTH / 750) * (value*1.0))
#define HP(value)   ((DEVICE_HEIGHT / 1334) * (value*1.0))

// 直接判断机型
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

@interface ShakeViewController ()<CAAnimationDelegate>
@property (nonatomic, strong) NSMutableDictionary *playDic;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *shakeImageView;
@property (nonatomic, strong) UIImageView *navigationBarRightImageView;
@property (nonatomic, assign) BOOL isPlayMusic;

@end

@implementation ShakeViewController

- (UIImageView *)backImageView
{
    if (!_backImageView)
    {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-NAV_HEIGHT-STATUS_HEIGHT)];
        _backImageView.image = [UIImage imageNamed:@"shakeBack"];
    }
    return _backImageView;
}

- (UIImageView *)shakeImageView
{
    if (!_shakeImageView)
    {
        float x = WP(106);
        float y = HP(96);
        y += NAV_HEIGHT;
        if (IS_IPHONE_5)
            y -= 10;
        float width = WP(498);
        float height = HP(733);
        height = height -NAV_HEIGHT;
        _shakeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _shakeImageView.image = [UIImage imageNamed:@"shake"];
        _shakeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _shakeImageView;
}

-(NSMutableDictionary *)playDic
{
    if (!_playDic)
    {
        _playDic = [NSMutableDictionary dictionary];
    }
    return _playDic ;
}

- (BOOL)isPlayMusic
{
    BOOL swOn = YES;
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShakeMusicSetting"];
    if (obj)
    {
        swOn = [(NSNumber *)obj boolValue];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ShakeMusicSetting"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return swOn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    
    [self becomeFirstResponder];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self initUI];
}

- (void)initUI
{
    self.title = @"摇一摇";
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.shakeImageView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shakeSetting"] style:UIBarButtonItemStyleDone target:self action:@selector(clickMore:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self resignFirstResponder];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"start shake");
    [self shakeAnimation:self.shakeImageView.layer];
    
    if (self.isPlayMusic)
    {
        [self playMusic:@"摇一摇.wav"];
    }
    else
    {
        [self shakeHappy];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (UIEventSubtypeMotionShake == event.subtype)
    {
        NSLog(@"end shake");
        
        
        // 以下代码放在网络请求返回的地方
        [self requestFinish];
        
        [self testResultVC];
    }
}

- (void)testResultVC
{
    ShakeResultType type = rand()%3;
    ShakeResultViewController *VC = [[ShakeResultViewController alloc] initWithShakeResultType:type];
    VC.clickItemBlock = ^(NSInteger index) {
        // 110000:取消    110001:考试   110002:比赛   110003:积分
        if (index == ShakeResultClickItem_Exam)
        {
            NSLog(@"110001:考试--110001:考试\n");
        }
        else if (index == ShakeResultClickItem_Challenge)
        {
            NSLog(@"110002:比赛--110002:比赛\n");
        }
        else if (index == ShakeResultClickItem_Score)
        {
            NSLog(@"110003:积分--110003:积分\n");
        }
    };
    if (type == ShakeResultType_Exam)
    {
        [VC setLabelText:@"XXX 考试" buttonTitle:@"立即参与"];
    }
    else if (type == ShakeResultType_Challenge)
    {
        [VC setLabelText:@"有胆来战 称霸杏林" buttonTitle:@"有胆来战"];
    }
    else if (type == ShakeResultType_Score)
    {
        [VC setLabelText:@"5000积分" buttonTitle:@"立即领取"];
    }
    VC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:VC animated:YES completion:nil];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

- (void)shakeAnimation:(CALayer *)layer
{
    CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    momAnimation.fromValue = [NSNumber numberWithFloat:-0.3];
    momAnimation.toValue = [NSNumber numberWithFloat:0.3];
    momAnimation.duration = 0.5;
    momAnimation.repeatCount = 1;
    momAnimation.autoreverses = YES;
    momAnimation.removedOnCompletion = YES;
    momAnimation.delegate = self;
    
    [layer addAnimation:momAnimation forKey:@"animateLayer"];
}

- (void)shakeHappy
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (BOOL)playMusic:(NSString *)fileName
{
    if (!fileName)
        return NO;
    
    AVAudioPlayer *player = self.playDic[fileName];
    if (!player)
    {
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        if (!url)
            return NO;
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        if (![player prepareToPlay])
            return NO;
        
        self.playDic[fileName] = player;
    }
    
    if (!player.isPlaying)
    {
        return [player play];
    }
    
    return YES;
}

- (void)clickMore:(id)sender
{
    ShakeSettingViewController *settingVC = [[ShakeSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)requestFinish
{
    [self shakeHappy];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5f*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (self.isPlayMusic)
        {
            BOOL requestSuccess = YES;
            if (requestSuccess)
            {
                [self playMusic:@"摇到结果.wav"];
            }
            else
            {
                [self playMusic:@"没摇到.wav"];
            }
            
        }
    });
}

@end
