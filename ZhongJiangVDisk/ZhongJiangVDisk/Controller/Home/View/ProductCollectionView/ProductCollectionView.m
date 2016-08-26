//
//  ProductCollectionView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/16.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ProductCollectionView.h"

@interface ProductCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *counts;
    NSInteger countTotal;
}
@property (nonatomic, strong) BuyView *buyView;
@end
__weak ProductCollectionView *productCollectionSelf;

@implementation ProductCollectionView

- (void)awakeFromNib
{
    [super awakeFromNib];
    productCollectionSelf = self;
    self.backgroundColor = LCoreCurrent.detailBackColor;
    for (int i = 0; i < LCoreCurrent.productsList.count; i ++) {
        if (!counts) {
            counts = [NSMutableArray array];
        }
        NSArray *list = LCoreCurrent.productsList[i][@"list"];
        [counts addObject:@(list.count)];
    }
    for (NSNumber *number in counts) {
        countTotal += [number integerValue];
    }
    if (countTotal %2 == 0) {
        _pagC.numberOfPages = countTotal/2;
    }else
    {
        _pagC.numberOfPages = countTotal/2+1;
    }
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"ProductCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProductCollectionCell"];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return counts.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [counts[section] integerValue];
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
    NSDictionary *dict = LCoreCurrent.productsList[indexPath.section];
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
    if (!_buyView) {
        _buyView = [[NSBundle mainBundle] loadNibNamed:@"BuyView" owner:nil options:nil].lastObject;
        _buyView.btnActionBlock = ^() {
        };
    }
    NSDictionary *dict = LCoreCurrent.productsList[indexPath.section];
    NSArray *list = dict[@"list"];
    _buyView.model = [ProductModel modelWithDictionary:list[indexPath.row]];
    _buyView.isBuyRise = !index;
    [_buyView showBuyViewAnimated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (countTotal %2 != 0 && point.x == _collectionView.frame.size.width*((countTotal)/2 - 0.5)) {
        _pagC.currentPage = (countTotal)/2+1;
        [_collectionView setContentOffset:CGPointMake(point.x+_collectionView.frame.size.width*0.5, 0) animated:YES];
        if (self.btnsActionBlock) {
            self.btnsActionBlock(counts.count-1);
        }
    }else
    {
        _pagC.currentPage = (int)point.x/_collectionView.frame.size.width;
        if (self.btnsActionBlock) {
            NSInteger c=0;
            NSInteger count = (_pagC.currentPage + 1)*2;
            for (int i = 1; i < counts.count; i ++) {
                c += [counts[i-1] integerValue];
                if (c < count && count <= c + [counts[i] integerValue]) {
                    self.btnsActionBlock(i);
                    return;
                }            }
            self.btnsActionBlock(0);
        }
    }
    
}
- (IBAction)pagCValueChanged:(id)sender {
    NSInteger index = _pagC.currentPage;
    [_collectionView setContentOffset:CGPointMake(index * _collectionView.frame.size.width, 0) animated:YES];
}
//动态改变collectionView的偏移量
- (void)setCollectionViewContentOffsetWithIndex:(NSInteger)index
{
    NSInteger idx;
    if (index == 0) {
        idx = 0;
    }else
    {
        NSInteger count=0;
        for (int i = 0; i < index; i ++) {
            count += [counts[i] integerValue];
        }
        idx = count / 2;
    }
    _pagC.currentPage = idx;
    [_collectionView setContentOffset:CGPointMake(idx *_collectionView.frame.size.width, 0) animated:YES];
}
@end
