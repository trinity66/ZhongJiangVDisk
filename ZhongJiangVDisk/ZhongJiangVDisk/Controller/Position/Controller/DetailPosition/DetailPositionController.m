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
@property (nonatomic, strong) NSArray *infos, *datas;
@property (nonatomic, strong) BuyView *buyView;
@end
__weak DetailPositionController *detailPositionSelf;
@implementation DetailPositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    detailPositionSelf = self;
    _infos = @[
               @[
                   @{@"订单号:":_model._id,},
                   @{@"合同成立时间:":_model.time,},
                   @{@"产品:":_model.productName,},
                   ],
               @[
                   @[
                       @{@"方向:":(_model.isBuyRise?@"买涨":@"买跌"),},
                       @{@"数量:":[NSString stringWithFormat:@"%ld",(long)_model.countNumber],}
                       ],
                   @[
                       @{@"合同立价:":[NSString stringWithFormat:@"%.02lf",_model.productModel.contractPrice],},
                       @{@"转让价:":@"0.00"}
                       ],
                   @[
                       @{@"止盈:":[NSString stringWithFormat:@"%@%%",_model.profit],},
                       @{@"止损:":[NSString stringWithFormat:@"%@%%",_model.loss],}
                       ]
                   ],
               @[
                   @{@"订单总价值:":[NSString stringWithFormat:@"%.02lf",_model.productModel.contractPrice/10],},
                   @{@"建仓支付金额:":[NSString stringWithFormat:@"%.02lf",_model.productModel.price],},
                   @{@"交易服务费:":@"0.00"},
                   @{@"盈亏资金:":@"0.00"},
                   ]
               ];
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
    return 28;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section != _infos.count-1) {
        return 5;
    }
    return kTableViewFootHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section != _infos.count-1) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 4.5, _tableView.frame.size.width, 0.5)];
        line.backgroundColor = LCoreCurrent.topSegmentColor;
        [view addSubview:line];
        return view;
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }else
    {
        return kTableViewFootHeight;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        PositionHead *head = [[NSBundle mainBundle] loadNibNamed:@"PositionHead" owner:nil options:nil].lastObject;
        [head setTitle:@"交易详情" detail:nil buttonTitle:nil];
        return head;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section, row = indexPath.row;
    if (section == 0) {
        DetailPositionCell1 *cell = [tableView cellFromNibWithClass:[DetailPositionCell1 class]];
        cell.dict = (NSDictionary*)_infos[section][row];
        return cell;
    }else if (section == 1) {
        DetailPositionCell2 *cell = [tableView cellFromNibWithClass:[DetailPositionCell2 class]];
        cell.datas = _infos[section][row];
        if (row == 2) {
            cell.button.hidden = NO;
            cell.btnActionBlock = ^(){
                [detailPositionSelf handleProfit];
            };
        }else
        {
            cell.button.hidden = YES;
        }
        return cell;
    }else if (section == 2) {
        DetailPositionCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailPositionCell3"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DetailPositionCell3" owner:nil options:nil].lastObject;
        }
        cell.dict = _infos[section][row];
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)handleProfit
{
    if (!_buyView) {
        _buyView = [[NSBundle mainBundle] loadNibNamed:@"BuyView" owner:nil options:nil].lastObject;
        __block BuyView *_buy = self.buyView;
        _buyView.btnActionBlock = ^() {
            [LCoreCurrent showAlertTitle:@"购买成功" timeCount:2 inView:_buy];
        };
        _buyView.dealModel = _model;
    }
    [_buyView showBuyViewAnimated:NO buyViewType:BuyViewTypeAdjustProfit];
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
