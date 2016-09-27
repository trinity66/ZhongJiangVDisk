//
//  LatestInfos.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/8.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "LatestInfos.h"

@interface LatestInfos ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSArray *list;
@end
@implementation LatestInfos

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    _list = @[@"关于劳工日交易时间调整的通知",@"关于夏季银行假日的公告",@"手续费调整公告"];
    _tableView.layer.cornerRadius = 5;
    _tableView.layer.borderColor = LCoreCurrent.personalTopColor.CGColor;
    _tableView.layer.borderWidth = 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
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
    if (section == 0 && LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        return 21;
    }
    return kTableViewFootHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 && LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LCoreCurrent.personalTopColor;;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 21)];
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"最新资讯";
        [view addSubview:label];
        return view;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellWithStyle:UITableViewCellStyleValue1];
    cell.textLabel.text = _list[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.btnsActionBlock) {
        self.btnsActionBlock(indexPath.row);
    }
}

@end
