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
@property (nonatomic, strong) ChartViewTwo *chartSuperViewTwo;
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
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (LCoreCurrent.isLogin && !self.segment) {
        [self addSegmentWithUserEnabled:YES];
        self.segment.btnsActionBlock = ^(NSInteger index) {
            [_self.collectionSuperView setCollectionViewContentOffsetWithIndex:index];
        };
        [self set_scrollView];
    }
    
}
- (void)goForgetDealPswd
{
    //忘记交易密码
    [LCoreCurrent goForgetDealPswdVC];
    [_put removeInputDealPswdViewAnimated:NO];
}
- (void)putBtnAction
{
    if (_put.textField.text.length == 0) {
        [LCoreCurrent showAlertTitle:@"请输入交易密码" timeCount:2 inView:_put];
        return;
    }else
    {
        NSString *dealPswd = LCoreCurrent.userInfo[@"dealPassword"];
        if ([dealPswd isEqualToString:_put.textField.text]) {
            [_put removeInputDealPswdViewAnimated:NO];
        }else
        {
            [LCoreCurrent showAlertTitle:@"输入交易密码错误" timeCount:2 inView:_put];
            return;
        }
    }
    _put = nil;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_put) {
        [_put showInputDealPswdViewAnimated:NO];
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
    switch (LCoreCurrent.VDiskType) {
        case VDiskTypeZhongJiang:
        {
            if (!_chartSuperView) {
                _chartSuperView = [[NSBundle mainBundle] loadNibNamed:@"ChartView" owner:nil options:nil].lastObject;
                _chartSuperView.frame = CGRectMake(0, 0, kScreenWidth, 330);
                [_scrollView addSubview:_chartSuperView];
            }
            if (!_collectionSuperView) {
                _collectionSuperView = [[NSBundle mainBundle] loadNibNamed:@"ProductCollectionView" owner:nil options:nil].lastObject;
                _collectionSuperView.btnsActionBlock = ^(NSInteger index) {
                    _self.segment.selectedIndex = index;
                };
                _collectionSuperView.frame = CGRectMake(0, _chartSuperView.frame.size.height, kScreenWidth, 160);
                [_scrollView addSubview:_collectionSuperView];
                _scrollView.contentSize = CGSizeMake(kScreenWidth, _chartSuperView.frame.size.height + _collectionSuperView.frame.size.height);
            }
        }
        break;
        case VDiskTypeZhongHui:
        {
            if (!_chartSuperView) {
                _chartSuperView = [[NSBundle mainBundle] loadNibNamed:@"ChartView" owner:nil options:nil].lastObject;
                _chartSuperView.frame = CGRectMake(0, 0, kScreenWidth, 330);
                [_scrollView addSubview:_chartSuperView];
            }
            if (!_productTableSuperView) {
                _productTableSuperView = [[NSBundle mainBundle] loadNibNamed:@"ProductTableView" owner:nil options:nil].lastObject;
                _productTableSuperView.frame = CGRectMake(0, _chartSuperView.frame.size.height, kScreenWidth, 160);
                [_scrollView addSubview:_productTableSuperView];
                _scrollView.contentSize = CGSizeMake(kScreenWidth, _chartSuperView.frame.size.height + _productTableSuperView.frame.size.height);
            }
        }
        break;
        case VDiskTypeYinHe:
        {
            double topSapce = 10;
            
            if (!_chartSuperViewTwo) {
                _chartSuperViewTwo = [[NSBundle mainBundle] loadNibNamed:@"ChartViewTwo" owner:nil options:nil].lastObject;
                _chartSuperViewTwo.frame = CGRectMake(10, topSapce, kScreenWidth-20, 340);
                [_scrollView addSubview:_chartSuperViewTwo];
            }
        }
        break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
