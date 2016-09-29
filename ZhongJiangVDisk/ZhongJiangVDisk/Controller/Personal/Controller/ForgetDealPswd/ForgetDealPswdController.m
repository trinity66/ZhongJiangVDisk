//
//  ForgetDealPswdController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/17.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ForgetDealPswdController.h"

@interface ForgetDealPswdController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) SecurityCodeView *foot;
@property (nonatomic, strong) LTextField *phoneTF, *dealPswdTF, *codeTF;
@end
__weak ForgetDealPswdController *_forgetDealSelf;
@implementation ForgetDealPswdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _forgetDealSelf = self;
    _topTableViewY.constant = [self getTableViewY];
    _titles = @[@"手机号码：", @"新密码："];
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
 tableView delagate
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
    TextFieldCell *cell = [tableView cellFromNibWithClass:[TextFieldCell class]];
    cell.textField.delegate = self;
    if (indexPath.row == 0) {
        _phoneTF = cell.textField;
        NSString *phone = LCoreCurrent.userInfo[@"phone"];
        _phoneTF.text = [NSString phoneHide:phone];
        _phoneTF.enabled = NO;
    }else
    {
        _dealPswdTF = cell.textField;
        
    }
    _phoneTF = cell.textField;
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
                [_forgetDealSelf textFieldResignFirstResponder];
                if (index == 0) {
                    //验证码
                    [_forgetDealSelf sendCodeActionWithIndex:0];
                    
                }else if (index == 1) {
                    //拨打电话
                    [_forgetDealSelf sendCodeActionWithIndex:1];
                    
                }else if (index == 2) {
                    //确认按钮
                    [_forgetDealSelf clickButtonAction];
                }
            };
            _tableView.tableFooterView = _foot;
            [_foot setButtonTitle:@"重置密码"];
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
    NSArray *ary = @[_phoneTF, _codeTF];
    for (LTextField *tf in ary) {
        [tf resignFirstResponder];
    }
    
}
/*
 点击确认之后的处理
 */
- (void)clickButtonAction
{
    NSArray *tfs = @[ _dealPswdTF, _codeTF];
    NSArray *names = @[@"新交易密码", @"验证码"];
    for (int i = 0; i < tfs.count; i ++) {
        LTextField *tf = tfs[i];
        if (tf.text.length == 0) {
            [self showAlert:[NSString stringWithFormat:@"请输入%@",names[i]]];
            return;
        }
    }
    //验证码
    if (![LCoreCurrent isValidNumber:_codeTF.text]) {
        [self showAlert:@"验证码输入不正确，请检查"];
        return;
    }
    //注册操作，登录成功
    [LCoreCurrent saveUserInfoWithKey:@"dealPassword" value:_dealPswdTF.text];
    [self.navigationController popViewControllerAnimated:YES];
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
