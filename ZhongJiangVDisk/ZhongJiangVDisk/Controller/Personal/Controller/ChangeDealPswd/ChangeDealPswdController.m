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
    _tableView.backgroundColor = [Core shareCore].backgroundColor;
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
            __block ChangeDealPswdController* _self =self;
            _foot.btnActionBlock = ^(){
                [changeDealSelf textFieldResignFirstResponder];
                [[Core shareCore] showAlertTitle:@"交易密码修改成功" timeCount:2 inView:_self.view];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
