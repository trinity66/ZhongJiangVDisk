//
//  RegisterController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/22.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) RegisterButtonView *foot;
@property (nonatomic, strong) LTextField *dealPswdTF, *nameTF, *numberTF, *phoneTF, *codeTF;
@end
__weak RegisterController *registerSelf;
@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    registerSelf = self;
    _titles = @[@"交易密码：", @"真实姓名：", @"身份证号码：", @"手机号码："];
    _tableView.backgroundColor = LCoreCurrent.backgroundColor;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            _dealPswdTF = cell.textField;
            break;
        case 1:
            _nameTF = cell.textField;
            break;
        case 2:
            _numberTF = cell.textField;
            break;
        case 3:
            _phoneTF = cell.textField;
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
            _foot = [[NSBundle mainBundle] loadNibNamed:@"RegisterButtonView" owner:nil options:nil].lastObject;
            __block RegisterButtonView *weakFoot = _foot;
            _foot.isAgreeBtn.selected = YES;
            _codeTF = _foot.securityCodeTF;
            _codeTF.delegate = self;
            _foot.btnsActionBlock = ^(NSInteger index) {
                [registerSelf textFieldResignFirstResponder];
                NSString *title;
                if (index == 0) {
                    //验证码
                    title = @"验证码发送成功(111111)";
                    [LCoreCurrent showAlertTitle:title timeCount:2 inView:registerSelf.view];
                }else if (index == 1) {
                    //是否同意开户协议
                    weakFoot.isAgreeBtn.selected = !weakFoot.isAgreeBtn.selected;
                }else if (index == 2) {
                    /*
                     跳转至webController-开户协议
                     */
                    [LCoreCurrent goWebVCWithUrl:@"http://www.baidu.com" inNavigationController:registerSelf.navigationController];
                }else if (index == 3) {
                    //注册
                    [registerSelf clickButtonAction];
                }
            };
            _tableView.tableFooterView = _foot;
        }
    }
}
/*
 textField delegate
 */
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
    NSArray *ary = @[_dealPswdTF, _nameTF, _numberTF, _phoneTF, _codeTF];
    for (LTextField *tf in ary) {
        [tf resignFirstResponder];
    }
}
/*
 将自身从父视图移除
 */
- (void)selfRemoveFromSuper
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
 点击确认之后的处理
 */
- (void)clickButtonAction
{
    NSArray *tfs = @[_dealPswdTF, _nameTF, _numberTF, _phoneTF, _codeTF];
    NSArray *names = @[@"交易密码", @"真实姓名", @"身份证号码", @"手机号码", @"验证码"];
    for (int i = 0; i < tfs.count; i ++) {
        LTextField *tf = tfs[i];
        if (tf.text.length == 0) {
            [self showAlert:[NSString stringWithFormat:@"请输入%@",names[i]]];
            return;
        }
    }
    //真实姓名
    if (_nameTF.text.length > 0 && ![LCoreCurrent isValidChineseCharacter:_nameTF.text]) {
        [self showAlert:@"真实姓名输入错误，只可输入汉字"];
        return;
    }
    //身份证号
    if (![LCoreCurrent isValidIdCard:_numberTF.text]) {
        [self showAlert:@"身份证号输入不正确，请检查"];
        return;
    }
    //手机号码
    if (![LCoreCurrent isValidPhoneNumber:_phoneTF.text]) {
        [self showAlert:@"手机号码输入不正确，请检查"];
        return;
    }
    //验证码
    if (![LCoreCurrent isValidNumber:_codeTF.text]) {
        [self showAlert:@"验证码输入不正确，请检查"];
        return;
    }
    if (!_foot.isAgreeBtn.selected) {
        [self showAlert:@"注册账户必须同意开户协议"];
        return;
    }
    //注册操作，登录成功
    LCoreCurrent.isLogin = YES;
    [self selfRemoveFromSuper];
    
}
- (void)showAlert:(NSString *)string
{
    [LCoreCurrent showAlertTitle:string timeCount:2 inView:self.view];
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
