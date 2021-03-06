//
//  RechargeController.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "RechargeController.h"
#define minSpace 40
@interface RechargeController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCollectionViewY;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign)NSInteger selectMoneyIndex, selectWayIndex;
@property (weak, nonatomic) IBOutlet UIView *btnSuperView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) ButtonView * buttonView;
@property (nonatomic, strong) LTextField *inputTF;

@end
__weak RechargeController *rechargeSelf;
@implementation RechargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    [self setSomethingForCollectionView];
    [self addButtonView];
    // Do any additional setup after loading the view.
}
- (void)addButtonView
{
    _buttonView = [[NSBundle mainBundle] loadNibNamed:@"ButtonView" owner:nil options:nil].lastObject;
    _buttonView.frame = _btnSuperView.bounds;
    [_buttonView setBtnTitle:@"立即充值"];
    _buttonView.btnActionBlock = ^(){
        [rechargeSelf clickButtonAction];
    };
    [_btnSuperView addSubview:_buttonView];
}
- (void)_init
{
    rechargeSelf = self;
    _topCollectionViewY.constant = [self getTableViewY] -1;
    [self.personalTopView setRechargeEnabled:NO];
    _titles = @[
                @[@"50", @"500", @"1000", @"5000", @"", @"10000"],
                @[@"银联充值", @"微信充值"]
                ];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickCancelButton)];
    
    //设置默认选中方式
    _selectWayIndex = 0;
    _selectMoneyIndex = 4;
}
- (void)clickCancelButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setSomethingForCollectionView
{
    _flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 44);
    //注册cell
    [_collectionView registerCellWithNibName:@"RechargeCell"];
    //注册表头
    [_collectionView registerHeadWithNibName:@"RechargeHeadView"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }
    return 2;
}
//cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (kScreenWidth - minSpace*3.0) / 2.0;
    return CGSizeMake(width, 35);
}
//cell margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, minSpace, 0, minSpace);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RechargeCell" forIndexPath:indexPath];
    NSString *str = _titles[indexPath.section][indexPath.row];
    cell.textField.text = str.length > 0 ? str : @"其他";
    if (indexPath.section == 0) {
        //充值金额
        //可输入金额
        if (indexPath.item == 5) {
            _inputTF = cell.textField;
            _inputTF.delegate = self;
            _inputTF.textAlignment = NSTextAlignmentLeft;
            _inputTF.returnKeyType = UIReturnKeyDone;
        }
        if (indexPath.item == _selectMoneyIndex) {
            [cell.textField setSelectedColor];
        }
    }else if (indexPath.section == 1) {
       //充值方式
        if (indexPath.item == _selectWayIndex) {
            [cell.textField setSelectedColor];
        }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self textFieldResignFirstResponder];
    NSInteger beforeIndexpathItem, nowIndexPathItem;
    nowIndexPathItem = indexPath.item;
    if (indexPath.section == 0) {
        beforeIndexpathItem = _selectMoneyIndex;
        _selectMoneyIndex = indexPath.row;
        if (indexPath.item < 4) {
            _inputTF.text = _titles[indexPath.section][indexPath.item];
            [_inputTF setDefalutColor];
        }else
        {
            if (indexPath.item == 4) {
                _inputTF.text = @"";
            }
            _inputTF.enabled = YES;
            [_inputTF becomeFirstResponder];
            [_inputTF setSelectedColor];
            nowIndexPathItem = 4;
            _selectMoneyIndex = 4;
        }
    }else
    {
        beforeIndexpathItem = _selectWayIndex;
        _selectWayIndex = indexPath.row;
    }
    RechargeCell *nowCell = (RechargeCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:nowIndexPathItem inSection:indexPath.section]];
     RechargeCell *beforeCell= (RechargeCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:beforeIndexpathItem inSection:indexPath.section]];
    if (beforeCell != nowCell) {
        [beforeCell.textField setDefalutColor];
        [nowCell.textField setSelectedColor];
    }
    
}

////添加表头
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        RechargeHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RechargeHeadView" forIndexPath:indexPath];
        headView.backgroundColor = LCoreCurrent.backgroundColor;
        if (indexPath.section == 0) {
            headView.title.text = @"充值金额(最小充值50元)";
        }else
        {
            headView.title.text = @"充值方式";
        }
        return headView;
    }
    return nil;
}
//textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textFieldResignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_inputTF setDefalutColor];
    _inputTF.enabled = NO;
}
- (void)textFieldResignFirstResponder
{
    [_inputTF resignFirstResponder];
}
/*
 点击确认之后的处理
 */
- (void)clickButtonAction
{
    if (_inputTF.text.length == 0) {
        [self showAlert:@"请输入充值金额"];
        return;
    }else
    if (![LCoreCurrent isValidNumber:_inputTF.text decimalCount:2]) {
        [self showAlert:@"充值金额格式错误"];
        return;
    }
    //注册操作，登录成功
    double money = [_inputTF.text doubleValue];
    double oldMoney = [LCoreCurrent.userInfo[@"balance"] doubleValue];
    [LCoreCurrent saveUserInfoWithKey:@"balance" value:@(money+oldMoney)];
#warning mark 充值
    NSString *time = [NSString strWithObj:[NSDate date]];
    NSDictionary *dict = @{@"_id":time,
                           @"type":@100,
                           @"product":@{
                               @"_id":time,
                               @"productName":@"",
                           },
                           @"time":time,
                           @"money":@(money),
                           @"balance":@(money+oldMoney),
                           @"isFinsih":@1,
                               };
    [LCoreCurrent saveDeal:dict];
    [self showAlert:@"充值成功"];
    [self setBalance];
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
