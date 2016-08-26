//
//  ProductCollectionView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/16.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ProductCollectionView.h"

@interface ProductCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) BuyView *buyView;
@property (nonatomic, strong) NSArray *productsList;
@end
__weak ProductCollectionView *productCollectionSelf;
@implementation ProductCollectionView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self products];
    productCollectionSelf = self;
    self.backgroundColor = LCoreCurrent.detailBackColor;
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"ProductCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProductCollectionCell"];
}
- (void)products
{
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Products" ofType:@"json"]];
    NSError* err = nil;
    _productsList = (NSArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return _productsList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *dict = _productsList[section];
    NSArray *list = dict[@"list"];
    return list.count;
}
//cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (kScreenWidth-15) / 2.0;
    return CGSizeMake(width, _collectionView.frame.size.height);
}
////cell margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCollectionCell" forIndexPath:indexPath];
    NSDictionary *dict = _productsList[indexPath.section];
    NSArray *list = dict[@"list"];
    cell.model = [ProductModel modelWithDictionary:list[indexPath.row]];
    if (indexPath.row == list.count-1) {
        [cell setColorWithType:@"RED"];
    }else
    {
        [cell setColorWithType:@"BROWN"];
    }
    cell.btnsActionBlock = ^(NSInteger index) {
        [productCollectionSelf candleBuyViewWithIndex:index indexPath:indexPath];
    };
    return cell;
}
- (void)candleBuyViewWithIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = _productsList[indexPath.section];
    NSArray *list = dict[@"list"];
    if (!_buyView) {
        _buyView = [[NSBundle mainBundle] loadNibNamed:@"BuyView" owner:nil options:nil].lastObject;
        __block BuyView *_buy = self.buyView;
        _buyView.btnActionBlock = ^() {
            [LCoreCurrent showAlertTitle:@"购买成功" timeCount:2 inView:_buy];
        };
    }
    _buyView.model = [ProductModel modelWithDictionary:list[indexPath.row]];
    _buyView.isBuyRise = !index;
    [_buyView showBuyViewAnimated:NO];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    _pagC.currentPage = (int)point.x/_collectionView.frame.size.width;
    
}
- (IBAction)pagCValueChanged:(id)sender {
    NSInteger index = _pagC.currentPage;
    [_collectionView setContentOffset:CGPointMake(index * _collectionView.frame.size.width, 0) animated:YES];
}
@end
