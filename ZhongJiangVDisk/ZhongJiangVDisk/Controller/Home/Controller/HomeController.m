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



@property (nonatomic, strong) LineSeries *line;
@property (nonatomic, strong) StockSeries *stock;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSegmentWithUserEnabled:YES];
    [self set_scrollView];
    // Do any additional setup after loading the view.
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
        [self.view addSubview:_scrollView];
    }
    if (!_chartSuperView) {
        _chartSuperView = [[NSBundle mainBundle] loadNibNamed:@"ChartView" owner:nil options:nil].lastObject;
        _chartSuperView.frame = CGRectMake(0, 0, kScreenWidth, 300);
        [_scrollView addSubview:_chartSuperView];
    }
    if (!_collectionSuperView) {
        _collectionSuperView = [[NSBundle mainBundle] loadNibNamed:@"ProductCollectionView" owner:nil options:nil].lastObject;
        _collectionSuperView.frame = CGRectMake(0, _chartSuperView.frame.size.height, kScreenWidth, 160);
        [_scrollView addSubview:_collectionSuperView];
        
    }
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _chartSuperView.frame.size.height + _collectionSuperView.frame.size.height);
    
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
