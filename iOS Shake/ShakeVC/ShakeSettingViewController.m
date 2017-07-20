//
//  ShakeSettingViewController.m
//  CureFunNew
//
//  Created by modong on 2017/7/18.
//  Copyright © 2017年 TLQ. All rights reserved.
//

#import "ShakeSettingViewController.h"
#import "ShakeHistoryViewController.h"

///设备宽高
#define DEVICE_HEIGHT   ([[UIScreen mainScreen]bounds].size.height)
#define DEVICE_WIDTH    ([[UIScreen mainScreen]bounds].size.width)
#define TAB_HEIGHT 49
#define NAV_HEIGHT 44
#define STATUS_HEIGHT 20

@interface ShakeSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableContentArray;

@end

@implementation ShakeSettingViewController

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, DEVICE_WIDTH, DEVICE_HEIGHT-STATUS_HEIGHT-NAV_HEIGHT-20) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (NSArray *)tableContentArray
{
    if (!_tableContentArray)
    {
        _tableContentArray = @[@[@"music", @"音效"], @[@"history", @"摇到的历史"]];
    }
    return _tableContentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    self.title = @"设置";
    [self.view addSubview:self.tableView];
}


// UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableContentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey";
    static NSString *cellIdentifierForFirstRow=@"UITableViewCellIdentifierKeyWithSwitch";

    UITableViewCell *cell;
    if (indexPath.row==0)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifierForFirstRow];
    }
    else
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    if(!cell)
    {
        if (indexPath.row==0)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifierForFirstRow];
            UISwitch *sw=[[UISwitch alloc]init];
//            sw.transform = CGAffineTransformMakeScale(1.2, 1.2);
//            sw.layer.anchorPoint=CGPointMake(0,0);
            [sw addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
            
            BOOL swOn = YES;
            id obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShakeMusicSetting"];
            if (obj)
            {
                swOn = [(NSNumber *)obj boolValue];
            }
            else
            {
                [self setSwitchValue:swOn];
            }
            [sw setOn:swOn animated:YES];
            cell.accessoryView=sw;
        }
        else
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if(indexPath.row==0)
    {
        ((UISwitch *)cell.accessoryView).tag=indexPath.section;
    }
    
    cell.imageView.image = [UIImage imageNamed:_tableContentArray[indexPath.row][0]];
    cell.textLabel.text = _tableContentArray[indexPath.row][1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

// UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.row)
    {
        ShakeHistoryViewController *vc = [[ShakeHistoryViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 切换开关转化事件
-(void)switchValueChange:(UISwitch *)sw
{
    [self setSwitchValue:sw.on];
}

- (void)setSwitchValue:(BOOL)isOn
{
    [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:@"ShakeMusicSetting"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
