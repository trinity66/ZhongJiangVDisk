//
//  WithdrawController.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "WithdrawController.h"

@interface WithdrawController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) SecurityCodeView *foot;
@property (nonatomic, strong) LTextField *moneyTF, *bankTF, *nameTF, *bankNumberTF,*dealPswdTF, *codeTF;
@end
__weak WithdrawController *_withdrawSelf;
@implementation WithdrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _withdrawSelf = self;
    _topTableViewY.constant = [self getTableViewY];
    _titles = @[@"提现金额：", @"提现银行：", @"姓名：", @"银行账号：", @"交易密码："];
    _tableView.backgroundColor = LCoreCurrent.backgroundColor;
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
    return _titles.count;
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:nil options:nil].lastObject;
    }
    cell.textField.delegate = self;
    switch (indexPath.row) {
        case 0:
            _moneyTF = cell.textField;
            break;
        case 1:
            _bankTF = cell.textField;
            break;
        case 2:
            _nameTF = cell.textField;
            break;
        case 3:
            _bankNumberTF = cell.textField;
            break;
        case 4:
            _dealPswdTF = cell.textField;
            break;
        default:
            break;
    }
    cell.title.text = _titles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _titles.count - 1) {
        if (!_foot) {
            _foot = [[NSBundle mainBundle] loadNibNamed:@"SecurityCodeView" owner:nil options:nil].lastObject;
            _codeTF = _foot.securityCodeTF;
            _codeTF.delegate = self;
            _foot.btnsActionBlock = ^(NSInteger index) {
                [_withdrawSelf textFieldResignFirstResponder];
                if (index == 0) {
                    //验证码
                    [_withdrawSelf sendCodeActionWithIndex:0];
                    
                }else if (index == 1) {
                    //拨打电话
                    [_withdrawSelf sendCodeActionWithIndex:1];
                    
                }else if (index == 2) {
                    //确认按钮
                    [_withdrawSelf clickButtonAction];
                }
            };
            _tableView.tableFooterView = _foot;
            [_foot setButtonTitle:@"提交"];
        }
    }
}
//textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    LTextField *tf = (LTextField *)textField;
    [tf setEnabledColor];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    LTextField *tf = (LTextField *)textField;
    [tf setDefalutColor];
}
- (void)textFieldResignFirstResponder
{
    NSArray *ary = @[_moneyTF, _bankTF, _nameTF, _bankNumberTF,_dealPswdTF, _codeTF];
    for (LTextField *tf in ary) {
        [tf resignFirstResponder];
    }
    
}
/*
 点击确认之后的处理
 */
- (void)clickButtonAction
{
    NSArray *tfs = @[_moneyTF, _bankTF, _nameTF, _bankNumberTF,_dealPswdTF, _codeTF];
    NSArray *names = @[@"提现金额", @"提现银行", @"姓名", @"银行账号", @"交易密码"];
    for (int i = 0; i < tfs.count; i ++) {
        LTextField *tf = tfs[i];
        if (tf.text.length == 0) {
            [self showAlert:[NSString stringWithFormat:@"请输入%@",names[i]]];
            return;
        }
    }
    //提现金额
    if (![LCoreCurrent isValidNumber:_moneyTF.text decimalCount:2]) {
        [self showAlert:@"提现金额格式错误"];
        return;
    }
    double balance = [LCoreCurrent.userInfo[@"balance"] doubleValue];
    double money = [_moneyTF.text doubleValue];
    if (balance < money) {
        [self showAlert:@"余额不足"];
        return;
    }
    //真实姓名
    if (![LCoreCurrent isValidChineseCharacter:_nameTF.text]) {
        [self showAlert:@"真实姓名输入错误，只可输入汉字"];
        return;
    }
    //银行帐号
    if (![LCoreCurrent isValidNumber:_bankNumberTF.text]) {
        [self showAlert:@"银行账号格式错误，请检查"];
        return;
    }
    NSString *deal = LCoreCurrent.userInfo[@"dealPassword"];
    if (![deal isEqualToString:_dealPswdTF.text]) {
        [self showAlert:@"交易密码输入错误"];
        return;
    }
    //验证码
    if (![LCoreCurrent isValidNumber:_codeTF.text]) {
        [self showAlert:@"验证码输入不正确，请检查"];
        return;
    }
#warning mark 提现
    balance -= money;
    //提现
    [LCoreCurrent saveDeal:@{@"_id":[NSString stringWithFormat:@"%@",[NSDate date]],
                             @"type":@400,
                             @"product":@{
                                     @"_id":[NSString stringWithFormat:@"%@",[NSDate date]],
                                     @"productName":_bankTF.text,
                                     @"bankNumber":_bankNumberTF.text,
                                     @"bankTitle":_bankTF.text,
                                     @"name":_nameTF.text,
                                     },
                             @"time":[NSString stringWithFormat:@"%@",[NSDate date]],
                             @"money":@(money),
                             @"balance":@(balance),
                             @"isFinsih":@1,
                             }];
    //提现手续费
    double poundage = money *0.01;
    balance -= poundage;
    [LCoreCurrent saveDeal:@{@"_id":[NSString stringWithFormat:@"%@",[NSDate date]],
                             @"type":@401,
                             @"product":@{
                                     @"_id":[NSString stringWithFormat:@"%@",[NSDate date]],
                                     @"productName":_bankTF.text,
                                     @"bankNumber":_bankNumberTF.text,
                                     @"bankTitle":_bankTF.text,
                                     @"name":_nameTF.text,
                                     },
                             @"time":[NSString stringWithFormat:@"%@",[NSDate date]],
                             @"money":@(poundage),
                             @"balance":@(balance),
                             @"isFinsih":@1,
                             }];
    [LCoreCurrent saveUserInfoWithKey:@"balance" value:@(balance)];
    [self setBalance];
    [self showAlert:@"提现成功"];
    
    
}
/*
 发送验证码
 */
- (void)sendCodeActionWithIndex:(NSInteger)index
{
//    NSString *phone = LCoreCurrent.userInfo[@"phone"];
    if (index == 0) {
        //短信验证码
        [self showAlert:@"验证码发送成功"];
    }else
    {
        //电话验证码
        [self showAlert:@"验证码已通过电话告知给您"];
    }
    
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
