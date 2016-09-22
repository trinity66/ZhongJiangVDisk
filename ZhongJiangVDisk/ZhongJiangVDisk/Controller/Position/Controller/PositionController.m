//
//  PositionController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/11.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "PositionController.h"

@interface PositionController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;

@property (nonatomic, strong) NSArray *list;
@end
__weak PositionController *_positionSelf;
@implementation PositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    _positionSelf = self;
    [self addSegmentWithUserEnabled:NO];
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
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadDatas];
}
- (void)loadDatas
{
    _list = [LCoreCurrent getDealHistoryList];
    [_tableView reloadData];
    if (_tableView.contentSize.height < kScreenHeight-_topTableViewY.constant-64-49) {
        _tableHeight.constant = (_list.count+1)*kTableViewCellHegiht;
    }else
    {
        _tableHeight.constant = kScreenHeight-_topTableViewY.constant-64-49-10;
    }
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
    return kTableViewCellHegiht;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kTableViewFootHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        return 26;
    }else
    {
        return kTableViewCellHegiht;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PositionHead *head = [[NSBundle mainBundle] loadNibNamed:@"PositionHead" owner:nil options:nil].lastObject;
    head.btnActionBlock = ^(){
        [_positionSelf clickButtonAction];
    };
//    [head setDetailWithNumber:0.00 isRise:YES];
    return head;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionCell*cell = [tableView dequeueReusableCellWithIdentifier:@"PositionCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PositionCell" owner:nil options:nil].lastObject;
        cell.btnActionBlock = ^(){
            //转让操作
        };
    }
    cell.model = [DealHistoryModel modelWithDictionary:_list[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self goDetailPositionWithIndex:indexPath.row];
}
/*push到交易详情*/
- (void)goDetailPositionWithIndex:(NSInteger)index
{
    DetailPositionController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailPositionController"];
    vc.model = [DealHistoryModel modelWithDictionary:_list[index]];
    [self.navigationController pushViewController:vc animated:YES];
}
/*点击一键平仓的操作*/
- (void)clickButtonAction
{
    NSMutableArray *list = [NSMutableArray arrayWithArray:[LCoreCurrent getDealList]];
    for (int index = 0; index < list.count; index ++) {
        NSDictionary *deal = list[index];
        DealModel *model = [DealModel modelWithDictionary:deal];
        if (model.type == 200 && !model.isFinsih) {
#warning mark 卖出&&卖出手续费
            //卖出
            double money = model.money;
            double poundage = model.productModel.poundage;
            double poundageMoney = money*poundage;
            double balance = [LCoreCurrent.userInfo[@"balance"] doubleValue];
            balance += money;
            NSString *time = [NSString stringWithFormat:@"%@",[NSDate date]];
            [list addObject:@{@"_id":time,
                                 @"type":@300,
                                 @"product":deal[@"product"],
                                 @"time":time,
                                 @"money":@(money),
                                 @"balance":@(balance),
                                 @"isFinsih":@1,
                                 }];
            balance -= poundageMoney;
            //卖出手续费
            [list addObject:@{@"_id":time,
                                 @"type":@301,
                                 @"product":deal[@"product"],
                                 @"time":time,
                                 @"money":@(poundageMoney),
                                 @"balance":@(balance),
                                 @"isFinsih":@1,
                                 }];
            [LCoreCurrent saveUserInfoWithKey:@"balance" value:@(balance)];
            [self setBalance];
            /*买入状态改为已结束*/
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:deal];
            [dict setObject:@1 forKey:@"isFinsih"];
            [list replaceObjectAtIndex:index withObject:dict];
        }
    }
    [LCoreCurrent saveDealWithList:list];
    [self showAlert:@"平仓成功"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controll
 er using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
