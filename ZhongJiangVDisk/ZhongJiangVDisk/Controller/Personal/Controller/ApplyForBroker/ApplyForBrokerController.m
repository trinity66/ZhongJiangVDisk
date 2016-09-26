//
//  ApplyForBrokerController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "ApplyForBrokerController.h"

@interface ApplyForBrokerController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) SecurityCodeView *foot;
@property (nonatomic, strong) LTextField *brokerTF, *loginPswdTF, *phoneTF, *numberTF, *codeTF;
@end
__weak ApplyForBrokerController *_applySelf;
@implementation ApplyForBrokerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _applySelf = self;
    _topTableViewY.constant = [self getTableViewY];
    _titles = @[@"经纪人名称：", @"登录密码：", @"经纪人手机：", @"机构编号："];
    _tableView.backgroundColor = LCoreCurrent.backgroundColor;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_foot.codeButton stopTimer];
}
/*
 tableView delegate
 */
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
    return kTableViewHeadHegiht;
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
            _brokerTF = cell.textField;
            _brokerTF.text = LCoreCurrent.userInfo[@"realName"];
            break;
        case 1:
            _loginPswdTF = cell.textField;
            _loginPswdTF.placeholder = @"后台登录密码";
            break;
        case 2:
        {
            _phoneTF = cell.textField;
            NSString *phone = LCoreCurrent.userInfo[@"phone"];
            _phoneTF.text = [NSString stringWithFormat:@"%@****%@",[phone substringToIndex:3],[phone substringFromIndex:7]];
            _phoneTF.enabled = NO;
        }
            break;
        case 3:
            _numberTF = cell.textField;
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
                [_applySelf textFieldResignFirstResponder];
                if (index == 0) {
                    //验证码
                    [_applySelf sendCodeActionWithIndex:0];
                }else if (index == 1) {
                    //拨打电话
                    [_applySelf sendCodeActionWithIndex:1];
                    
                }else if (index == 2) {
                    //确认按钮
                    [_applySelf clickButtonAction];
                    return;
                }
            };
            _tableView.tableFooterView = _foot;
            [_foot setButtonTitle:@"提交申请"];
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
    NSArray *ary = @[_brokerTF, _loginPswdTF, _phoneTF, _numberTF, _codeTF];
    for (LTextField *tf in ary) {
        [tf resignFirstResponder];
    }
    
}
/*
 点击确认之后的处理
 */
- (void)clickButtonAction
{
    NSArray *tfs = @[_brokerTF, _loginPswdTF, _numberTF, _codeTF];
    NSArray *names = @[@"经纪人名称", @"登录密码", @"机构编号", @"验证码"];
    for (int i = 0; i < tfs.count; i ++) {
        LTextField *tf = tfs[i];
        if (tf.text.length == 0) {
            [self showAlert:[NSString stringWithFormat:@"请输入%@",names[i]]];
            return;
        }
    }
    //经纪人名称
    if (_brokerTF.text.length > 0 && ![LCoreCurrent isValidChineseCharacter:_brokerTF.text]) {
        [self showAlert:@"经纪人名称输入错误，只可输入汉字"];
        return;
    }
    //验证码
    if (![LCoreCurrent isValidNumber:_codeTF.text]) {
        [self showAlert:@"验证码输入不正确，请检查"];
        return;
    }
    //注册操作，登录成功
    [LCoreCurrent saveUserInfoWithKey:@"loginPassword" value:_loginPswdTF.text];
    [LCoreCurrent saveUserInfoWithKey:@"realName" value:_brokerTF.text];
    [LCoreCurrent saveUserInfoWithKey:@"organizationNumber" value:_numberTF.text];
    [self showAlert:@"经纪人申请提交成功"];
}
/*
 发送验证码
 */
- (void)sendCodeActionWithIndex:(NSInteger)index
{
    [_foot.codeButton startWithTimerCount:60];
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
