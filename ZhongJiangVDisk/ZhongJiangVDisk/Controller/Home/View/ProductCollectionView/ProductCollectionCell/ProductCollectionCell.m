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
@property (weak, nonatomic) IBOutlet UIButton *riseButton;
@property (weak, nonatomic) IBOutlet UIButton *fallButton;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
@implementation ProductCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setColorWithType:(NSString *)type
{
    UIColor *color = [[Core shareCore] zhongJiangColors][@"lightMainColor"];
    _title.textColor = color;
    _riseButton.layer.masksToBounds = YES;
    _fallButton.layer.masksToBounds = YES;
    if ([type isEqualToString:@"RED"]) {
        color = [[Core shareCore] zhongJiangColors][@"riseColor"];
    }
    
    _mainView.layer.borderColor = color.CGColor;
    _mainView.backgroundColor = color;
    
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

@end
