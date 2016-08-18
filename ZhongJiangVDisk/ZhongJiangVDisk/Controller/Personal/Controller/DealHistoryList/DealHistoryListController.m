//
//  DealHistoryListController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "DealHistoryListController.h"

@interface DealHistoryListController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@property (nonatomic, strong) DealHistoryHeadView *head;

@end

@implementation DealHistoryListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topTableViewY.constant = [self getTableViewY];
    _tableView.backgroundColor = [Core shareCore].backgroundColor;
    _tableView.separatorColor = [Core shareCore].detailLightBackColor;
    [self addHeadTableView];
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
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DealHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealHistoryCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DealHistoryCell" owner:nil options:nil].lastObject;
    }
    BOOL isRise = indexPath.row % 2;
    if (isRise != 0) {
        cell.backgroundColor = [Core shareCore].backgroundColor;
    }else
    {
        cell.backgroundColor = [Core shareCore].detailBackColor;
    }
    [cell setDetailWithNumber:indexPath.row + 1 isRise:isRise];
    return cell;
}
- (void)addHeadTableView
{
    if (!_head) {
        _head = [[NSBundle mainBundle] loadNibNamed:@"DealHistoryHeadView" owner:nil options:nil].lastObject;
        _head.bounds = CGRectMake(0, 0, kScreenWidth, 90);
    }
    _tableView.tableHeaderView = _head;
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
