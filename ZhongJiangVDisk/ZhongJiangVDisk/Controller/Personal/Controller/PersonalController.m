//
//  PersonalController.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "PersonalController.h"

@interface PersonalController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *titles;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *ary;
    if ([Core shareCore].VDiskType == VDiskTypeZhongJiang) {
        ary = @[@"收支明细(2016－06-20前)", @"交易历史(2016-06-20前)"];
    }else
    {
        ary = @[];
    }
    _titles =
    @[
  @[@"公告"],
  @[@"充值", @"提现", @"收支明细", @"交易历史"],
  @[@"我的二维码", @"经纪人申请", @"修改交易密码"],
  ary,
  @[@"帮助"]
  ];
    [self addPersonalTopView];
    _topTableViewY.constant = [self getTableViewY];
    _tableView.backgroundColor = [Core shareCore].backgroundColor;
    _tableView.separatorColor = [Core shareCore].detailLightBackColor;
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *list = _titles[section];
    return list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableViewCellHegiht;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kTableViewFootHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    NSArray *list = _titles[section];
    if (list.count > 0) {
       return 20;
    }
    return kTableViewFootHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [Core shareCore].topSegmentColor;
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.backgroundColor = [Core shareCore].detailBackColor;
        cell.textLabel.textColor = [Core shareCore].cellTextColor;
        cell.textLabel.font = [UIFont systemFontOfSize:kCellLabelFont];
        UIView *view = [UIView new];
        view.backgroundColor = [Core shareCore].selectedLineColor;
        cell.selectedBackgroundView = view;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _titles[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *identifier = @"InfosController";
    switch (indexPath.section) {
        case 0:
            identifier = @"InfosController";
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [[Core shareCore] goRechargeVC];
                    return;
                    break;
                case 1:
                    identifier = @"WithdrawController";
                    break;
                case 2:
                    identifier = @"DealListController";
                    break;
                case 3:
                    identifier = @"DealHistoryListController";
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    identifier = @"QRCodeController";
                    break;
                case 1:
                    identifier = @"ApplyForBrokerController";
                    break;
                case 2:
                    identifier = @"ChangeDealPswdController";
                    break;
                default:
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 0:
                    [[Core shareCore] showAlertTitle:@"无收支明细" timeCount:2 inView:self.view];
                    return;
                    break;
                case 1:
                    [[Core shareCore] showAlertTitle:@"无收历史记录" timeCount:2 inView:self.view];
                    return;
                    break;
                case 2:
                    identifier = @"ChangeDealPswdController";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    [self goVCWithIdentifier:identifier];
}

- (void)goVCWithIdentifier:(NSString *)identifier
{
    BaseViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:vc animated:YES];
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
