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
@property (nonatomic, strong) NSArray *titles, *placeholders;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lHeight;
@end
@implementation BuyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)showBuyView
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    _mainView.alpha = 0.0;
    _mainView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        _mainView.alpha = 1.0;
        _mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}
- (IBAction)cancelAction:(id)sender {
    [self removeBuyView];
}
- (IBAction)buttonAction:(id)sender {
    if (self.btnActionBlock) {
        self.btnActionBlock();
    }
}
- (void)removeBuyView
{
    _mainView.alpha = 1.0;
    _mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView animateWithDuration:0.3 animations:^{
        _mainView.alpha = 0.0;
        _mainView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    _lHeight.constant = 0.5;
    _button.backgroundColor = [Core shareCore].buttonBackColor;
    _titles = @[@"止盈（％）", @"止损（％）", @"购买数量", @"预付款", @"合同总价值"];
    _placeholders = @[@"不设", @"不设", @"1", @"50", @"3174"];
    _title.textColor = [Core shareCore].cellTextColor;
    _mainView.backgroundColor = [Core shareCore].backgroundColor;
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
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3) {
        SelectDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectDataCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SelectDataCell" owner:nil options:nil].lastObject;
            cell.textField.enabled = NO;
        }
        cell.title.text = _titles[indexPath.row];
        cell.textField.placeholder = _placeholders[indexPath.row];
        return cell;
    }else
    {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:nil options:nil].lastObject;
            cell.textField.enabled = NO;
        }
        cell.title.text = _titles[indexPath.row];
        cell.textField.placeholder = _placeholders[indexPath.row];
        return cell;
    }
}

@end
