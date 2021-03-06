//
//  DealHistoryListController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "DealHistoryListController.h"

@interface DealHistoryListController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@property (nonatomic, strong) DealHistoryHeadView *head;
@property (nonatomic, strong) NSArray *list;
@end

@implementation DealHistoryListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topTableViewY.constant = [self getTableViewY];
    _tableView.separatorColor = LCoreCurrent.detailLightBackColor;
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _list = [LCoreCurrent getDealHistoryList];
    _head.tfOne.text = [NSString strWithIntNum:_list.count];
    int totalCount = 0;
    for (NSDictionary *dict in _list) {
        DealHistoryModel *model = [DealHistoryModel modelWithDictionary:dict];
        totalCount += model.countNumber;
    }
    _head.tfTwo.text = [NSString strWithIntNum:totalCount];
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
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kTableViewFootHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kTableViewFootHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self addHeadTableView];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DealHistoryCell *cell = [tableView cellFromNibWithClass:[DealHistoryCell class]];
    BOOL isRise = indexPath.row % 2;
    if (isRise != 0) {
        cell.backgroundColor = LCoreCurrent.backgroundColor;
    }else
    {
        cell.backgroundColor = LCoreCurrent.detailBackColor;
    }
    cell.model = [DealHistoryModel modelWithDictionary:_list[indexPath.row]];
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
