//
//  QRCodeController.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "QRCodeController.h"

@interface QRCodeController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation QRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addQRCodeImageView];
    // Do any additional setup after loading the view.
}
- (void)addQRCodeImageView
{
    QRCodeImage *qrcodeImage = [QRCodeImage codeImageWithString:@"http://www.baidu.com"                                                                    size:_imageView.frame.size.width
                                                          color:[UIColor colorWithRed:41/255.0 green:41/255.0 blue:41/255.0 alpha:1.0]
                                                           icon:nil
                                                      iconWidth:0];
    
    _imageView.image = qrcodeImage;
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
