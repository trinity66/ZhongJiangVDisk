//
//  ChangeDealPswdController.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ChangeDealPswdController.h"

@interface ChangeDealPswdController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) ButtonView *foot;
@property (nonatomic, strong) LTextField *pswdTFOld, *pswdTFNew, *pswdTFNewAgain;
@end
__weak ChangeDealPswdController *changeDealSelf;
@implementation ChangeDealPswdController

- (void)viewDidLoad {
    [super viewDidLoad];
    changeDealSelf = self;
    _topTableViewY.constant = [self getTableViewY];
    _titles = @[@"原交易密码：", @"新交易密码：", @"再次确认："];
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
    switch (indexPath.row) {
        case 0:
            _pswdTFOld = cell.textField;
            break;
        case 1:
            _pswdTFNew = cell.textField;
            break;
        case 2:
            _pswdTFNewAgain = cell.textField;
            break;
        default:
            break;
    }
    cell.textField.delegate = self;
    cell.title.text = _titles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _titles.count - 1) {
        if (!_foot) {
            _foot = [[NSBundle mainBundle] loadNibNamed:@"ButtonView" owner:nil options:nil].lastObject;
            [_foot setBtnTitle:@"确定"];
            _tableView.tableFooterView = _foot;
            _foot.btnActionBlock = ^(){
                [changeDealSelf textFieldResignFirstResponder];
                [changeDealSelf clickButtonAction];
            };
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
    NSArray *ary = @[_pswdTFOld, _pswdTFNew, _pswdTFNewAgain];
    for (LTextField *tf in ary) {
        [tf resignFirstResponder];
    }
    
}
/*
 点击确认之后的处理
 */
- (void)clickButtonAction
{
    NSArray *tfs = @[_pswdTFOld, _pswdTFNew, _pswdTFNewAgain];
    NSArray *names = @[@"原交易密码", @"新交易密码", @"确认的交易密码"];
    for (int i = 0; i < tfs.count; i ++) {
        LTextField *tf = tfs[i];
        if (tf.text.length == 0) {
            [self showAlert:[NSString stringWithFormat:@"请输入%@",names[i]]];
            return;
        }
    }
    NSString *oldDeal = LCoreCurrent.userInfo[@"dealPassword"];
    if (![oldDeal isEqualToString:_pswdTFOld.text]) {
        [self showAlert:@"原交易密码输入错误"];
        return;
    }
    if (![_pswdTFNew.text isEqualToString:_pswdTFNewAgain.text]) {
        [self showAlert:@"两次新密码输入不同"];
        return;
    }
    [LCoreCurrent saveUserInfoWithKey:@"dealPassword" value:_pswdTFNew.text];
    [self showAlert:@"交易密码修改成功"];
    
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
