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
@property (nonatomic, strong) LChartView *lChartView;
@property (nonatomic, strong) ProductTableView *productTableSuperView;
@property (nonatomic, strong) InputDealPswdView *put;
@property (nonatomic, strong) LatestInfos *latestInfos;

@end
__weak HomeController *_homeSelf;
@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    _homeSelf = self;
    [self addSegmentWithUserEnabled:YES];
    self.segment.btnsActionBlock = ^(NSInteger index) {
        [_homeSelf handleTopButtonWithIndex:index];
    };
    [self set_scrollView];
    [self showInput];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_put) {
        [_put showInputDealPswdViewAnimated:NO];
    }
}
/*
 每次重新启动APP之后，如果当前是登录状态，则验证登录密码
 */
- (void)showInput
{
    if (LCoreCurrent.isLogin) {
        _put = [[NSBundle mainBundle] loadNibNamed:@"InputDealPswdView" owner:nil options:nil].lastObject;
        _put.btnsActionBlock = ^(NSInteger index) {
            if (index == 0) {
                [_homeSelf goForgetDealPswd];
            }else
            {
                [_homeSelf putBtnAction];
            }
        };
    }
}
/*
 顶部选择变化时
 */
- (void)handleTopButtonWithIndex:(NSInteger)index
{
    _chartSuperView.topSegSelectedIndex = index;
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
#pragma mark 设置scrollView
- (void)set_scrollView
{
    double space = 0, width = kScreenWidth;
    if (LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        space = 10;
        width = kScreenWidth-space*2;
    }
    if (!_scrollView) {
        CGFloat y = [self getTableViewY], height = kScreenHeight-64-49-y;
        CGRect rect = CGRectMake(space, y, width, height);
        _scrollView = [[UIScrollView alloc] initWithFrame: rect];
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_scrollView];
    }
    switch (LCoreCurrent.VDiskType) {
        case VDiskTypeZhongJiang:
        case VDiskTypeZhongHui:
        {
            double height = 0;
            if (!_chartSuperView) {
                _chartSuperView = [[NSBundle mainBundle] loadNibNamed:@"ChartView" owner:nil options:nil].lastObject;
                [_chartSuperView setSelfFrame:CGRectMake(0, 0, width, 330)];
                if (!_lChartView) {
                    _lChartView = _chartSuperView.lChart;
                    _lChartView.topView.btnsActionBlock = ^(NSInteger index) {
                        [_homeSelf handleScaleWithIndex:index];
                    };
                }
                [_scrollView addSubview:_chartSuperView];
                
            }
            height += _chartSuperView.frame.size.height;
            double tableHeight = 20;
            for (NSDictionary *dict in LCoreCurrent.productsList) {
                NSArray *list = dict[@"list"];
                tableHeight += list.count * kTableViewCellHegiht;
            }
            if (!_productTableSuperView) {
                _productTableSuperView = [[NSBundle mainBundle] loadNibNamed:@"ProductTableView" owner:nil options:nil].lastObject;
                _productTableSuperView.frame = CGRectMake(0, height, width, tableHeight);
                [_scrollView addSubview:_productTableSuperView];
            }
            height += tableHeight;
            _scrollView.contentSize = CGSizeMake(width, height);
        }
        break;
        case VDiskTypeYinHe:
        {
            double height = 0;
            if (!_productTableSuperView) {
                _productTableSuperView = [[NSBundle mainBundle] loadNibNamed:@"ProductTableView" owner:nil options:nil].lastObject;
                int count = 0;
                for (NSArray *list in LCoreCurrent.productsList) {
                    count += list.count;
                }
                _productTableSuperView.frame = CGRectMake(0, space, width, 25+count*kTableViewCellHegiht);
                
                height = space + 25 +count*kTableViewCellHegiht;
                [_scrollView addSubview:_productTableSuperView];
            }
            if (!_chartSuperViewTwo) {
                _chartSuperViewTwo = [[NSBundle mainBundle] loadNibNamed:@"ChartViewTwo" owner:nil options:nil].lastObject;
                [_chartSuperViewTwo setSelfFrame:CGRectMake(0, space + height, width, 340)];
                if (!_lChartView) {
                    _lChartView = _chartSuperView.lChart;
                    _lChartView.topView.btnsActionBlock = ^(NSInteger index) {
                         [_homeSelf handleScaleWithIndex:index];
                    };
                }
                [_scrollView addSubview:_chartSuperViewTwo];
                height += (space + 340);
            }
            if (!_latestInfos) {
                _latestInfos = [[NSBundle mainBundle] loadNibNamed:@"LatestInfos" owner:nil options:nil].lastObject;
                _latestInfos.btnsActionBlock = ^(NSInteger index) {
                    [_homeSelf goWebWithIndex:index];
                };
                _latestInfos.frame = CGRectMake(0, space + height, width, 25+kTableViewCellHegiht*3);
                [_scrollView addSubview:_latestInfos];
                height += (space + 25+kTableViewCellHegiht*3);
            }
            _scrollView.contentSize = CGSizeMake(width, height);
        }
        break;
        default:
        break;
    }
}
//chartView缩放
- (void)handleScaleWithIndex:(NSInteger)index
{
    [_lChartView subShowViewsHidden:YES];
    double width = kItemWidth;
    switch (index) {
        case 0:
            width *= 1.0;
            break;
        case 1:
            width *= 1.5;
            break;
        case 2:
            width *= 2.0;
            break;
        default:
            break;
    }
    _lChartView.item_width = width;
}
- (void)goWebWithIndex:(NSInteger)index
{
    [LCoreCurrent goWebVCWithUrl:@"http://www.baidu.com" inNavigationController:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
