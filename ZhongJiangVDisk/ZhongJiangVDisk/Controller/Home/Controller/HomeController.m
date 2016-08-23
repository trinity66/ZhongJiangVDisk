//
//  HomeController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/11.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ChartView *chartSuperView;
@property (nonatomic, strong) ProductCollectionView *collectionSuperView;
@property (nonatomic, strong) ProductTableView *productTableSuperView;
@property (nonatomic, strong) InputDealPswdView *put;


@property (nonatomic, strong) LineSeries *line;
@property (nonatomic, strong) StockSeries *stock;
@end
__weak HomeController *_self;
@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    _self = self;
    if (LCoreCurrent.isLogin) {
        _put = [[NSBundle mainBundle] loadNibNamed:@"InputDealPswdView" owner:nil options:nil].lastObject;
        _put.btnsActionBlock = ^(NSInteger index) {
            if (index == 0) {
                [_self goForgetDealPswd];
            }else
            {
                [_self putBtnAction];
            }
        };
    }

    [self addSegmentWithUserEnabled:YES];
    [self set_scrollView];
    // Do any additional setup after loading the view.
}
- (void)goForgetDealPswd
{
    //忘记交易密码
    [LCoreCurrent goForgetDealPswdVC];
    [_put removeInputDealPswdView];
}
- (void)putBtnAction
{
    [_put removeInputDealPswdView];
    _put = nil;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_put) {
        [_put showInputDealPswdView];
    }
}
#pragma mark 设置scrollView
- (void)set_scrollView
{
    if (!_scrollView) {
        CGFloat y = [self getTableViewY], height = kScreenHeight-64-49-y;
        CGRect rect = CGRectMake(0, y, kScreenWidth, height);
        _scrollView = [[UIScrollView alloc] initWithFrame: rect];
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = LCoreCurrent.backgroundColor;
        [self.view addSubview:_scrollView];
    }
    if (!_chartSuperView) {
        _chartSuperView = [[NSBundle mainBundle] loadNibNamed:@"ChartView" owner:nil options:nil].lastObject;
        _chartSuperView.frame = CGRectMake(0, 0, kScreenWidth, 330);
        [_scrollView addSubview:_chartSuperView];
    }
    if (LCoreCurrent.VDiskType == VDiskTypeZhongJiang) {
        if (!_collectionSuperView) {
            _collectionSuperView = [[NSBundle mainBundle] loadNibNamed:@"ProductCollectionView" owner:nil options:nil].lastObject;
            _collectionSuperView.frame = CGRectMake(0, _chartSuperView.frame.size.height, kScreenWidth, 160);
            [_scrollView addSubview:_collectionSuperView];
            _scrollView.contentSize = CGSizeMake(kScreenWidth, _chartSuperView.frame.size.height + _collectionSuperView.frame.size.height);
        }
    }
    if (LCoreCurrent.VDiskType == VDiskTypeZhongHui) {
        if (!_productTableSuperView) {
            _productTableSuperView = [[NSBundle mainBundle] loadNibNamed:@"ProductTableView" owner:nil options:nil].lastObject;
            _productTableSuperView.frame = CGRectMake(0, _chartSuperView.frame.size.height, kScreenWidth, 160);
            [_scrollView addSubview:_productTableSuperView];
            _scrollView.contentSize = CGSizeMake(kScreenWidth, _chartSuperView.frame.size.height + _productTableSuperView.frame.size.height);
        }
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
