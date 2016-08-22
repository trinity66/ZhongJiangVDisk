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
    _tableView.backgroundColor = [Core shareCore].backgroundColor;
    // Do any additional setup after loading the view.
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
            _codeTF = _foot.securityCodeTF;
            _codeTF.delegate = self;
            _foot.btnsActionBlock = ^(NSInteger index) {
                [registerSelf textFieldResignFirstResponder];
                NSString *title;
                if (index == 0) {
                    //验证码
                    title = @"验证码发送成功";
                    
                }else if (index == 1) {
                    //是否同意开户协议
                    title = @"是否同意开户协议";
                    
                }else if (index == 2) {
                    //开户协议的内容
                    title = @"开户协议的内容";
                }else if (index == 3) {
                    //注册
                    title = @"注册成功";
                    [Core shareCore].isLogin = YES;
                    [registerSelf dismissViewControllerAnimated:YES completion:nil];
                }
                [[Core shareCore] showAlertTitle:title timeCount:2 inView:registerSelf.view];
            };
            _tableView.tableFooterView = _foot;
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
    NSArray *ary = @[_dealPswdTF, _nameTF, _numberTF, _phoneTF, _codeTF];
    for (LTextField *tf in ary) {
        [tf resignFirstResponder];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
