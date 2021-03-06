//
//  ProductCollectionCell.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/15.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "ProductCollectionCell.h"

@interface ProductCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet LButton *riseButton;
@property (weak, nonatomic) IBOutlet LButton *fallButton;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
@implementation ProductCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = LCoreCurrent.detailBackColor;
    // Initialization code
}
- (void)setColorWithType:(NSString *)type
{
    UIColor *color = LCoreCurrent.selectedLineColor;
    _title.textColor = color;
    if ([type isEqualToString:@"RED"]) {
        color = LCoreCurrent.riseTextColor;
    }
    
    _mainView.layer.borderColor = color.CGColor;
    _mainView.backgroundColor = color;
    //买涨买跌之间的斜线
    CALayer* line = [BaseLayer layerOfLineFrom:CGPointZero to:CGPointMake(-20, 30) withColor:[UIColor whiteColor] andWidth:0.6 animated:NO];
    line.position = CGPointMake((self.bounds.size.width-15)/2.0 + 10, self.bounds.size.height-_riseButton.bounds.size.height);
    [self.layer addSublayer:line];
    
}
- (IBAction)riseAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(0);
    }
}
- (IBAction)fallAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(1);
    }
}
- (void)setModel:(ProductModel *)model
{
    _model = model;
    _title.text = [NSString stringWithFormat:@"%.02f元/手",_model.price];
    _name.text = _model.productName;
    _detail.text = [NSString stringWithFormat:@"波动盈亏:%.03f元",_model.fluctuations];
}

@end
