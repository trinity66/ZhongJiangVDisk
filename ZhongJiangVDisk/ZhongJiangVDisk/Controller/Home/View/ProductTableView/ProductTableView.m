//
//  ProductTableView.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/18.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ProductTableView.h"

@interface ProductTableView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BuyView *buyView;
@end
__weak ProductTableView *productTabelSelf;
@implementation ProductTableView
- (void)awakeFromNib
{
    [super awakeFromNib];
    productTabelSelf = self;
    _tableView.backgroundColor = LCoreCurrent.backgroundColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return LCoreCurrent.productsList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = LCoreCurrent.productsList[section];
    NSArray *list = dict[@"list"];
    return list.count;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ProductTableViewCell" owner:nil options:nil].lastObject;
        cell.btnsActionBlock = ^(NSInteger index) {
            [productTabelSelf candleBuyViewWithIndex:index indexpath:indexPath];
        };
    }
    NSDictionary *dict = LCoreCurrent.productsList[indexPath.section];
    NSArray *list = dict[@"list"];
    cell.model = [ProductModel modelWithDictionary:list[indexPath.row]];
    return cell;
}
- (void)candleBuyViewWithIndex:(NSInteger)index indexpath:(NSIndexPath *)indexPath
{
    if (!_buyView) {
        _buyView = [[NSBundle mainBundle] loadNibNamed:@"BuyView" owner:nil options:nil].lastObject;
        __block BuyView *_buy = self.buyView;
        _buyView.btnActionBlock = ^() {
            [LCoreCurrent showAlertTitle:@"购买成功" timeCount:2 inView:_buy];
        };
    }
    NSDictionary *dict = LCoreCurrent.productsList[indexPath.section];
    NSArray *list = dict[@"list"];
    _buyView.model = [ProductModel modelWithDictionary:list[indexPath.row]];
    _buyView.isBuyRise = !index;
    [_buyView showBuyViewAnimated:NO];
}
@end
