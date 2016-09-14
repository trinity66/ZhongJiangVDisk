//
//  BuyView.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/15.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "BuyView.h"

@interface BuyView ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet LButton *button;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIView *lTwo;
@property (weak, nonatomic) IBOutlet UIView *lOne;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainHeight;

@property (nonatomic, assign) NSInteger maxProfit, maxLoss, maxCount;
@property (nonatomic, assign) NSInteger currentProfitIndex, currentLossIndex, currentCountIndex;
@property (nonatomic, strong) NSMutableArray *profits, *losses, *counts;
@property (nonatomic, strong) LTextField *profitTf, *lossTf, *countTf, *priceTF, *contractPriceTF;
@property (nonatomic, strong) NSArray *titles, *texts;
@property (nonatomic, assign) double poundage;
@property (nonatomic, assign) BuyViewType buyViewType;

@end
__weak BuyView *buySelf;
@implementation BuyView
//懒加载
/*model*/
- (void)setModel:(ProductModel *)model
{
    _model = model;
    self.maxProfit = model.maxProfit;
    self.maxLoss = model.maxLoss;
    self.poundage = model.poundage;
    self.maxCount = 1000;
    self.currentProfitIndex = 0;
    self.currentLossIndex = 0;
    self.currentCountIndex = 0;
    self.texts = @[@"不设", @"不设", @"1", [NSString stringWithFormat:@"%.02f",_model.price], [NSString stringWithFormat:@"%.02f",_model.contractPrice]];
}
- (void)setBuyViewType:(BuyViewType)buyViewType
{
    _buyViewType = buyViewType;
    if (_buyViewType == BuyViewTypeAdjustProfit) {
        _title.text = @"调整盈亏比例";
    }
}
- (void)setDealModel:(DealHistoryModel *)dealModel
{
    _dealModel = dealModel;
    self.texts = @[dealModel.profit, dealModel.loss];
    self.maxProfit = dealModel.productModel.maxProfit;
    self.maxLoss = dealModel.productModel.maxLoss;
    self.maxCount = 1000;
    self.currentProfitIndex = [dealModel.profit isEqualToString:@"不设"]?0:[dealModel.profit integerValue]/10;
    self.currentLossIndex = [dealModel.loss isEqualToString:@"不设"]?0:[dealModel.loss integerValue]/10;
    _mainHeight.constant = 200;
}
- (void)setIsBuyRise:(BOOL)isBuyRise
{
    _isBuyRise = isBuyRise;
    [self setSomeData];
}
/*maxLoss*/
- (void)setMaxLoss:(NSInteger)maxLoss
{
    _maxLoss = maxLoss;
    if (_losses) {
        [_losses removeAllObjects];
    }else
    {
        _losses = [NSMutableArray array];
    }
    for (int i = 0; i <= maxLoss; i = i + 10) {
        [_losses addObject:[NSNumber numberWithInteger:i]];
    }
}
/*currentLossIndex*/
- (void)setCurrentLossIndex:(NSInteger)currentLossIndex
{
    _currentLossIndex = currentLossIndex;
    NSString *text;
    if (currentLossIndex == 0) {
        text = @"不设";
    }else
    {
        text = [NSString stringWithFormat:@"%ld",(long)[_losses[currentLossIndex] integerValue]];
    }
    self.lossTf.text = text;
}
/*maxCount*/
- (void)setMaxCount:(NSInteger)maxCount
{
    _maxCount = maxCount;
    if (_counts) {
        [_counts removeAllObjects];
    }else
    {
        _counts = [NSMutableArray array];
    }
    for (int i = 1; i <= maxCount;  i ++) {
        [_counts addObject:[NSNumber numberWithInteger:i]];
    }
}
/*currentCountIndex*/
- (void)setCurrentCountIndex:(NSInteger)currentCountIndex
{
    _currentCountIndex = currentCountIndex;
    NSString *text = [NSString stringWithFormat:@"%ld",(long)[_counts[currentCountIndex] integerValue]];
    _countTf.text = text;
    [self setSomeData];
}
/*maxProfit*/
- (void)setMaxProfit:(NSInteger)maxProfit
{
    _maxProfit = maxProfit;
    if (_profits) {
        [_profits removeAllObjects];
    }else
    {
        _profits = [NSMutableArray array];
    }
    for (int i = 0; i <= maxProfit; i = i + 10) {
        [_profits addObject:[NSNumber numberWithInteger:i]];
    }
}
/*currentProfitIndex*/
- (void)setCurrentProfitIndex:(NSInteger)currentProfitIndex
{
    _currentProfitIndex = currentProfitIndex;
    NSString *text;
    if (currentProfitIndex == 0) {
        text = @"不设";
    }else
    {
        text = [NSString stringWithFormat:@"%ld",(long)[_profits[currentProfitIndex] integerValue]];
    }
    _profitTf.text = text;
}
- (void)showBuyViewAnimated:(BOOL)animated buyViewType:(BuyViewType)buyViewType
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.buyViewType = buyViewType;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    if (animated) {
        _mainView.alpha = 0.0;
        _mainView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:0.3 animations:^{
            _mainView.alpha = 1.0;
            _mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
    
}
- (IBAction)cancelAction:(id)sender {
    [self removeBuyViewAnimated:NO];
}
- (IBAction)buttonAction:(id)sender {
    if (_buyViewType == BuyViewTypeBuy) {
        double balance = [LCoreCurrent.userInfo[@"balance"] doubleValue];
        double money = [_priceTF.text doubleValue];
        if (money > balance) {
            [LCoreCurrent showAlertTitle:@"余额不足" timeCount:2 inView:self];
        }else
        {
            [LCoreCurrent showAlertTitle:@"购买成功" timeCount:2 inView:self];
            [LCoreCurrent saveUserInfoWithKey:@"balance" value:@(balance-money)];
            NSString *time = [NSString stringWithFormat:@"%@",[NSDate date]];
#warning mark 买入
            NSDictionary *dict = @{@"_id":time,
                                   @"type":@200,
                                   @"product":_model.modelDict,
                                   @"time":time,
                                   @"money":@(money),
                                   @"balance":@(balance-money),
                                   @"isFinsih":@0,
                                   @"profit":_profitTf.text,
                                   @"loss":_lossTf.text,
                                   };
            [LCoreCurrent saveDeal:dict];
            NSDictionary *dict2 = @{
                                    @"_id":time,
                                    @"time":time,
                                    @"productName":_model.productName,
                                    @"countNumber":@([_countTf.text integerValue]),
                                    @"money":@(money),
                                    @"product":_model.modelDict,
                                    @"isBuyRise":@(_isBuyRise),
                                    @"profit":_profitTf.text,
                                    @"loss":_lossTf.text,
                                    };
            [LCoreCurrent saveDealHistory:dict2];
            BaseNavigationController *navc = ((BaseTabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController).viewControllers[0];
            HomeController *vc = (HomeController*)navc.viewControllers[0];
            [vc setBalance];
            if (self.btnActionBlock) {
                self.btnActionBlock();
            }
        }
    }else
    {
        [LCoreCurrent showAlertTitle:@"调整成功" timeCount:2 inView:self];
    }
    
}
- (void)removeBuyViewAnimated:(BOOL)animated
{
    if (animated) {
        _mainView.alpha = 1.0;
        _mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView animateWithDuration:0.3 animations:^{
            _mainView.alpha = 0.0;
            _mainView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else
    {
        [self removeFromSuperview];
    }
    
    
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setSomeControl];
}
- (void)setSomeControl
{
    buySelf = self;
    _lHeight.constant = 0.5;
    _button.backgroundColor = LCoreCurrent.buttonBackColor;
    _titles = @[@"止盈（％）", @"止损（％）", @"购买数量", @"预付款", @"合同总价值"];
    _title.textColor = LCoreCurrent.cellTextColor;
    _mainView.backgroundColor = LCoreCurrent.backgroundColor;
    _mainView.layer.borderColor = LCoreCurrent.buttonBorderColor.CGColor;
    _tableView.backgroundColor = LCoreCurrent.backgroundColor;
    _lOne.backgroundColor = LCoreCurrent.detailLightBackColor;
    _lTwo.backgroundColor = LCoreCurrent.detailLightBackColor;
    [_cancel setImage:[[UIImage imageNamed:@"buyCancel"] imageWithTintColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.texts.count;
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
    if (indexPath.row < 3) {
        SelectDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectDataCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SelectDataCell" owner:nil options:nil].lastObject;
        }
        switch (indexPath.row) {
            case 0:
                _profitTf = cell.textField;
                cell.btnsActionBlock = ^(NSInteger index) {
                    [buySelf setProfitWithIndex:index];
                };
                break;
            case 1:
                _lossTf = cell.textField;
                cell.btnsActionBlock = ^(NSInteger index) {
                    [buySelf setLossWithIndex:index];
                };
                break;
            case 2:
                _countTf = cell.textField;
                cell.btnsActionBlock = ^(NSInteger index) {
                    [buySelf setCountWithIndex:index];
                };
                break;
            default:
                break;
        }
        cell.title.text = _titles[indexPath.row];
        cell.textField.text = _texts[indexPath.row];
        return cell;
    }else
    {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:nil options:nil].lastObject;
            cell.textField.enabled = NO;
        }
        if (indexPath.row == 3) {
            _priceTF = cell.textField;
            
        }else
        {
            _contractPriceTF = cell.textField;
        }
        cell.title.text = _titles[indexPath.row];
        cell.textField.text = _texts[indexPath.row];
        return cell;
    }
}
- (void)setProfitWithIndex:(NSInteger)btnIndex
{
    //盈
    switch (btnIndex) {
        case 0:
        //减
        if (self.currentProfitIndex > 0) {
            self.currentProfitIndex -= 1;
        }
        break;
        case 1:
        //加
        if (self.currentProfitIndex < _profits.count-1) {
            self.currentProfitIndex += 1;
        }
        break;
        default:
        break;
    }
}
- (void)setLossWithIndex:(NSInteger)btnIndex
{
    //损
    switch (btnIndex) {
        case 0:
        //减
        if (self.currentLossIndex > 0) {
            self.currentLossIndex -= 1;
        }
        break;
        case 1:
        //加
        if (self.currentLossIndex < _losses.count-1) {
            self.currentLossIndex += 1;
        }
        break;
        default:
        break;
    }
    
}
- (void)setCountWithIndex:(NSInteger)btnIndex
{
    //数量
    switch (btnIndex) {
        case 0:
        //减
        if (self.currentCountIndex > 0) {
            self.currentCountIndex -= 1;
        }
        break;
        case 1:
        //加
        if (self.currentCountIndex < _counts.count-1) {
            self.currentCountIndex += 1;
        }
        break;
        default:
        break;
    }
}
- (void)setSomeData
{
    NSString *str;
    if (_isBuyRise) {
        str = @"买涨";
    }else
    {
        str = @"买跌";
    }
    NSInteger count = _currentCountIndex + 1;
    NSString *title = [NSString stringWithFormat:@"%@ %@, 手续费:%.0f", _model.productName, str, _model.price*count*_poundage];
    _title.text = title;
    _priceTF.text = [NSString stringWithFormat:@"%.2f",count*_model.price];
    _contractPriceTF.text = [NSString stringWithFormat:@"%.2f",count*_model.contractPrice];
}
@end
