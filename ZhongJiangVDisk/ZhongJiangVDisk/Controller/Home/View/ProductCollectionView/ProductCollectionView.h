//
//  ProductCollectionView.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/16.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCollectionView : UIView
@property (weak, nonatomic) IBOutlet UIPageControl *pagC;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) btnsActionBlock btnsActionBlock;
- (void)setCollectionViewContentOffsetWithIndex:(NSInteger)index;
@end
