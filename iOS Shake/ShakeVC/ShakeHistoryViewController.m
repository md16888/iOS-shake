//
//  ShakeHistoryViewController.m
//  CureFunNew
//
//  Created by modong on 2017/7/18.
//  Copyright © 2017年 TLQ. All rights reserved.
//

#import "ShakeHistoryViewController.h"
#import "ClearHistoryAlertVCViewController.h"

///设备宽高
#define DEVICE_HEIGHT   ([[UIScreen mainScreen]bounds].size.height)
#define DEVICE_WIDTH    ([[UIScreen mainScreen]bounds].size.width)
#define TAB_HEIGHT 49
#define NAV_HEIGHT 44
#define STATUS_HEIGHT 20

@interface ShakeHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableContentArray;

@end

@implementation ShakeHistoryViewController

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, DEVICE_WIDTH, DEVICE_HEIGHT-STATUS_HEIGHT-NAV_HEIGHT-20) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSArray *)tableContentArray
{
    if (!_tableContentArray)
    {
        _tableContentArray = @[@[@"ShakeHistoryExam", @"XXX考试", @""], @[@"ShakeHistoryChallenge", @"挑战赛", @""], @[@"ShakeHistoryScore", @"500积分", @"2017-12-30 12:00:00"]];
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
    self.title = @"摇到的历史";
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(clickMore:)];
}

- (void)clickMore:(id)sender
{
    __weak typeof(self) weakSelf = self;
    ClearHistoryAlertVCViewController *clearAlertVC = [[ClearHistoryAlertVCViewController alloc] init];
    clearAlertVC.clickItemBlock = ^(NSInteger index) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        // 100001:清空    100002:取消
        if (100001 == index)
        {
            [strongSelf clearHistoryDone];
        }
        else if (100002 == index)
        {
        }
    };
    clearAlertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:clearAlertVC animated:YES completion:nil];
}

- (void)clearHistoryDone
{
    self.tableContentArray = [[NSArray alloc] init];
    [self.tableView reloadData];
    
    CGRect imageViewRect = CGRectMake(DEVICE_WIDTH/4, (DEVICE_HEIGHT-NAV_HEIGHT)/2-DEVICE_WIDTH/2, DEVICE_WIDTH/2, DEVICE_WIDTH/2);
    UIImageView *noRecordView = [[UIImageView alloc] initWithFrame:imageViewRect];
    noRecordView.image = [UIImage imageNamed:@"NoRecord"];
    noRecordView.contentMode = UIViewContentModeScaleAspectFit;
    noRecordView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:noRecordView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noRecordView.frame)-10, DEVICE_WIDTH, 20)];
    label.textColor = [UIColor lightGrayColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"暂时没有摇一摇纪录";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
}

// UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableContentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    
    cell.imageView.image = [UIImage imageNamed:_tableContentArray[indexPath.row][0]];
    cell.textLabel.text = _tableContentArray[indexPath.row][1];
    cell.detailTextLabel.text = _tableContentArray[indexPath.row][2];
    return cell;
}

// UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
