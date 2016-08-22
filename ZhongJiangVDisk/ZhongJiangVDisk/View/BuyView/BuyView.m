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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lHeight;
@property (nonatomic, assign) NSInteger maxProfit, maxLoss, maxCount;
@property (nonatomic, assign) NSInteger currentProfitIndex, currentLossIndex, currentCountIndex;
@property (nonatomic, strong) NSMutableArray *profits, *losses, *counts;
@property (nonatomic, strong) UITextField *profitTf, *lossTf, *countTf;
@property (nonatomic, strong) NSArray *titles;

@end
__weak BuyView *buySelf;
@implementation BuyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)showBuyViewAnimated:(BOOL)animated
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
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
    if (self.btnActionBlock) {
        self.btnActionBlock();
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
    _button.backgroundColor = [Core shareCore].buttonBackColor;
    _titles = @[@"止盈（％）", @"止损（％）", @"购买数量", @"预付款", @"合同总价值"];
    _maxProfit = 60;
    _maxLoss = 60;
    _maxCount = 20;
    _profits = [NSMutableArray array];
    _losses = [NSMutableArray array];
    _counts = [NSMutableArray array];
    for (int i = 0; i <= _maxProfit; i = i + 10) {
        [_profits addObject:[NSNumber numberWithInteger:i]];
    }
    for (int i = 0; i <= _maxLoss; i = i + 10) {
        [_losses addObject:[NSNumber numberWithInteger:i]];
    }
    for (int i = 1; i <= _maxCount; i ++) {
        [_counts addObject:[NSNumber numberWithInteger:i]];
    }
    _currentProfitIndex = 0;
    _currentLossIndex = 0;
    _currentCountIndex = 0;
    _title.textColor = [Core shareCore].cellTextColor;
    _mainView.backgroundColor = [Core shareCore].backgroundColor;
    _mainView.layer.borderColor = [Core shareCore].buttonBorderColor.CGColor;
    _tableView.backgroundColor = [Core shareCore].backgroundColor;
    _lOne.backgroundColor = [Core shareCore].detailLightBackColor;
    _lTwo.backgroundColor = [Core shareCore].detailLightBackColor;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
            cell.title.text = _titles[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    _profitTf = cell.textField;
                    [self setProfitText];
                    cell.btnsActionBlock = ^(NSInteger index) {
                        [buySelf setProfitWithIndex:index];
                    };
                    break;
                case 1:
                    _lossTf = cell.textField;
                   [self setLossText];
                    cell.btnsActionBlock = ^(NSInteger index) {
                        [buySelf setLossWithIndex:index];
                    };
                    break;
                case 2:
                    _countTf = cell.textField;
                    [self setCountText];
                    cell.btnsActionBlock = ^(NSInteger index) {
                        [buySelf setCountWithIndex:index];
                    };
                    break;
                default:
                    break;
            }
        }
        return cell;
    }else
    {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:nil options:nil].lastObject;
            cell.textField.enabled = NO;
        }
        cell.title.text = _titles[indexPath.row];
        return cell;
    }
}
- (void)setProfitWithIndex:(NSInteger)btnIndex
{
    //盈
    switch (btnIndex) {
        case 0:
            //减
            if (_currentProfitIndex > 0) {
                _currentProfitIndex -= 1;
            }
            break;
        case 1:
            //加
            if (_currentProfitIndex < _profits.count-1) {
                _currentProfitIndex += 1;
            }
            break;
        default:
            break;
    }
    [self setProfitText];
}
- (void)setProfitText {
    NSString *text;
    if (_currentProfitIndex == 0) {
        text = @"不设";
    }else
    {
        text = [NSString stringWithFormat:@"%ld",(long)[_profits[_currentProfitIndex] integerValue]];
    }
    _profitTf.text = text;
}
- (void)setLossWithIndex:(NSInteger)btnIndex
{
    //损
    switch (btnIndex) {
        case 0:
            //减
            if (_currentLossIndex > 0) {
                _currentLossIndex -= 1;
            }
            break;
        case 1:
            //加
            if (_currentLossIndex < _losses.count-1) {
                _currentLossIndex += 1;
            }
            break;
        default:
            break;
    }
    [self setLossText];
    
}
- (void)setLossText
{
    NSString *text;
    if (_currentLossIndex == 0) {
        text = @"不设";
    }else
    {
        text = [NSString stringWithFormat:@"%ld",(long)[_losses[_currentLossIndex] integerValue]];
    }
    _lossTf.text = text;
}
- (void)setCountWithIndex:(NSInteger)btnIndex
{
    //数量
    switch (btnIndex) {
        case 0:
            //减
            if (_currentCountIndex > 0) {
                _currentCountIndex -= 1;
            }
            break;
        case 1:
            //加
            if (_currentCountIndex < _counts.count-1) {
                _currentCountIndex += 1;
            }
            break;
        default:
            break;
    }
    [self setCountText];
}
- (void)setCountText
{
    NSString *text = [NSString stringWithFormat:@"%ld",(long)[_counts[_currentCountIndex] integerValue]];
    _countTf.text = text;
}
@end
