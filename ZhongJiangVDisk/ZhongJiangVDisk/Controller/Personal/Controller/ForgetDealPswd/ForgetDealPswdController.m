//
//  ForgetDealPswdController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/17.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ForgetDealPswdController.h"

@interface ForgetDealPswdController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) SecurityCodeView *foot;
@end
__weak ForgetDealPswdController *_forgetDealSelf;
@implementation ForgetDealPswdController

- (void)viewDidLoad {
    [super viewDidLoad];
    _forgetDealSelf = self;
    _topTableViewY.constant = [self getTableViewY];
    _titles = @[@"手机号："];
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
    return 36;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
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
    cell.textField.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    cell.title.text = _titles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _titles.count - 1) {
        if (!_foot) {
            _foot = [[NSBundle mainBundle] loadNibNamed:@"SecurityCodeView" owner:nil options:nil].lastObject;
            _foot.btnsActionBlock = ^(NSInteger index) {
                NSString *title;
                if (index == 0) {
                    //验证码
                    title = @"验证码发送成功";
                    
                }else if (index == 1) {
                    //拨打电话
                    title = @"已成功通过拨打电话方式告知验证码";
                    
                }else if (index == 2) {
                    //确认按钮
                    title = @"交易密码已重置";
                }
                [[Core shareCore] showAlertTitle:title timeCount:2 inView:_forgetDealSelf.view];
            };
            _tableView.tableFooterView = _foot;
            [_foot setButtonTitle:@"重置密码"];
        }
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
