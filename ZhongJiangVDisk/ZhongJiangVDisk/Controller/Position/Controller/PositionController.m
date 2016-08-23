//
//  PositionController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/11.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "PositionController.h"

@interface PositionController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewY;
@end
__weak PositionController *_positionSelf;
@implementation PositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    _positionSelf = self;
    _tableView.backgroundColor = LCoreCurrent.backgroundColor;
    _tableView.separatorColor = LCoreCurrent.backgroundColor;
    [self addSegmentWithUserEnabled:NO];
    _topTableViewY.constant = [self getTableViewY];
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
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
    PositionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PositionCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PositionCell" owner:nil options:nil].lastObject;
    }
    cell.btnActionBlock = ^() {
        [LCoreCurrent showAlertTitle:@"平仓成功" timeCount:2 inView:_positionSelf.view];
    };
    [cell setDetailWithNumber:0.00 isRise:YES];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controll
 er using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
