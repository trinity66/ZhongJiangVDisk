//
//  InfosController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "InfosController.h"

@interface InfosController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *titles;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;

@end

@implementation InfosController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titles = @[@"8月12日中江数据日历", @"关于提现手续费调整通知", @"公告", @"关于数据恢复公告", @"关于白银，原油暂停建仓公告", @"关于调整交易时间的公告"];
    _topTableViewY.constant = [self getTableViewY];
    _tableView.backgroundColor = LCoreCurrent.backgroundColor;
    _tableView.separatorColor = LCoreCurrent.detailLightBackColor;
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
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
    return kTableViewFootHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.textColor = LCoreCurrent.cellTextColor;
        cell.backgroundColor = LCoreCurrent.detailBackColor;
        cell.textLabel.font = [UIFont systemFontOfSize:kCellLabelFont];
        UIView *view = [UIView new];
        view.backgroundColor = LCoreCurrent.selectedLineColor;
        cell.selectedBackgroundView = view;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
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
