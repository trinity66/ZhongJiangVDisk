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
@end
@implementation ProductCollectionView

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
    self.backgroundColor = [Core shareCore].detailBackColor;
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"ProductCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProductCollectionCell"];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
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
    cell.btnsActionBlock = ^(NSInteger index) {
        if (!_buyView) {
            _buyView = [[NSBundle mainBundle] loadNibNamed:@"BuyView" owner:nil options:nil].lastObject;
            __block BuyView *_buy = self.buyView;
            _buyView.btnActionBlock = ^() {
                [[Core shareCore] showAlertTitle:@"购买成功" timeCount:2 inView:_buy];
//                [_buy removeBuyView];
            };
        }
        if (index == 0) {
            _buyView.title.text = @"买涨";
        }else
        {
            _buyView.title.text = @"买跌";
        }
        [_buyView showBuyView];
    };
    if (indexPath.item % 2 == 0) {
        [cell setColorWithType:@"RED"];
    }else
    {
        [cell setColorWithType:@"BROWN"];
    }
    return cell;
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
