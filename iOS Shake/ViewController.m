//
//  ViewController.m
//  iOS Shake
//
//  Created by modong on 2017/7/20.
//  Copyright © 2017年 modong. All rights reserved.
//

#import "ViewController.h"
#import "ShakeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addButton];
}

- (void)addButton
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"进入摇一摇" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonDone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)buttonDone:(UIButton *)button
{
    ShakeViewController *shakeVC = [[ShakeViewController alloc] init];
    [self.navigationController pushViewController:shakeVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
