//
//  DealListController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "DealListController.h"

@interface DealListController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@property (nonatomic, strong) NSArray *list;
@end

@implementation DealListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topTableViewY.constant = [self getTableViewY];
    _tableView.separatorColor = LCoreCurrent.detailLightBackColor;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _list = [LCoreCurrent getDealList];
    [_tableView reloadData];
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
    return _list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kTableViewFootHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kTableViewHeadHegiht;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DealCell *cell = [tableView cellFromNibWithClass:[DealCell class]];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = LCoreCurrent.backgroundColor;
    }else
    {
        cell.backgroundColor = LCoreCurrent.topSegmentColor;
    }
    cell.model = [DealModel modelWithDictionary:_list[indexPath.row]];
    return cell;
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
