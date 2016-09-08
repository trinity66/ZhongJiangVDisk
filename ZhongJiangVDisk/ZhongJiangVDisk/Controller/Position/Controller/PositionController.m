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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right;
@property (nonatomic, strong) NSArray *list;
@end
__weak PositionController *_positionSelf;
@implementation PositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    _positionSelf = self;
    _tableView.backgroundColor = LCoreCurrent.backgroundColor;
    [self addSegmentWithUserEnabled:NO];
    _topTableViewY.constant = [self getTableViewY];

    if (LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.borderColor = LCoreCurrent.personalTopColor.CGColor;
        _tableView.layer.borderWidth = 1;
        _topTableViewY.constant = [self getTableViewY]+10;
        _left.constant = 10;
        _right.constant = 10;
    }else
    {
        _tableView.separatorColor = LCoreCurrent.backgroundColor;
    }
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _list = [LCoreCurrent getDealHistoryList];
    _tableHeight.constant = _list.count*50+30;
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
    if (LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        return _list.count;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 && LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        return 20;
    }
    return kTableViewFootHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 && LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LCoreCurrent.personalTopColor;;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 20)];
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"我的持仓单";
        [view addSubview:label];
        LButton *button = [LButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth-23-60, 2, 60, 20-2*2);
        button.layer.cornerRadius = 5;
        button.backgroundColor = LCoreCurrent.buttonBackColor;
        [button setTitleColor:LCoreCurrent.buttonTitleColor forState:UIControlStateNormal];
        [button setTitle:@"一键平仓" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:button];
        return view;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DealHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealHistoryCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DealHistoryCell" owner:nil options:nil].lastObject;
    }
    cell.model = [DealHistoryModel modelWithDictionary:_list[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
