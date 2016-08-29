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
@end
__weak PositionController *_positionSelf;
@implementation PositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    _positionSelf = self;
    _tableView.backgroundColor = LCoreCurrent.backgroundColor;
    _tableView.separatorColor = LCoreCurrent.backgroundColor;
    [self addSegmentWithUserEnabled:NO];
    _topTableViewY.constant = [self getTableViewY];
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
    return 1;
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PositionCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PositionCell" owner:nil options:nil].lastObject;
    }
    cell.btnActionBlock = ^() {
        [_positionSelf clickButtonAction];
        
    };
    [cell setDetailWithNumber:0.00 isRise:YES];
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
