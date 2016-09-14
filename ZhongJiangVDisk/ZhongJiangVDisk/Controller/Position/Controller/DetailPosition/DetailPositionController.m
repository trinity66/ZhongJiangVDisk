//
//  DetailPositionController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "DetailPositionController.h"

@interface DetailPositionController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@property (nonatomic, strong) NSArray *infos;
@end

@implementation DetailPositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    _infos = @[@[@"订单号:", @"合同成立时间:", @"产品:"],
               @[@[@"方向:", @"数量:"], @[@"合同立价:", @"转让价:"], @[@"止盈:", @"止损:"]],
               @[@"订单总价值:", @"建仓支付金额:", @"交易服务费:", @"盈亏资金:"]];
    self.view.backgroundColor = LCoreCurrent.backgroundColor;
    _tableView.backgroundColor = LCoreCurrent.backgroundColor;
    _tableView.separatorColor = LCoreCurrent.detailLightBackColor;
    _topTableViewY.constant = [self getTableViewY];
    if (LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        _topTableViewY.constant += 10;
        _tableView.layer.borderColor = LCoreCurrent.personalTopColor.CGColor;
    }else
    {
        _tableView.layer.borderColor = [UIColor clearColor].CGColor;
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)_infos[section]).count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableViewCellHegiht;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, _tableView.frame.size.width, 0.5)];
    line.backgroundColor = LCoreCurrent.topSegmentColor;
    [view addSubview:line];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 26;
    }else
    {
        return kTableViewCellHegiht;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PositionHead *head = [[NSBundle mainBundle] loadNibNamed:@"PositionHead" owner:nil options:nil].lastObject;
    [head setTitle:@"交易详情" detail:nil buttonTitle:nil];
    return head;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section, row = indexPath.row;
    if (section == 0) {
        DetailPositionCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailPositionCell1"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DetailPositionCell1" owner:nil options:nil].lastObject;
        }
        cell.title = _infos[section][row];
        return cell;
    }else if (section == 1) {
        DetailPositionCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailPositionCell2"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DetailPositionCell2" owner:nil options:nil].lastObject;
        }
        cell.title1 = _infos[section][row][0];
        cell.title2 = _infos[section][row][1];
        return cell;
    }else if (section == 2) {
        DetailPositionCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailPositionCell3"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DetailPositionCell3" owner:nil options:nil].lastObject;
        }
        cell.title = _infos[section][row];
        if (row == 2) {
            cell
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
