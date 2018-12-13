//
//  AdvertiseView.m
//  BeaconYun
//
//  Created by 樊芳 on 2018/12/3.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import "AdvertiseView.h"
#import "ShakeSelectView.h"

@interface AdvertiseView ()
@property (strong, nonatomic) NSMutableArray *imageArray;
/**
 * 记录全部的 按钮
 */
@property (strong, nonatomic) NSMutableArray *totalsBtnArray;

@end

@implementation AdvertiseView
{
    NSMutableArray *_dataArray;
    UIButton *_currentSelBtn;
    ShakeSelectView *_currenthakeView;
    UIScrollView *_scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        
        [self initView];
    }
    
    return self;
}

- (void)initData {

    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithObjects:
                       @{@"icon":@"icon_Randomcolor",@"title":NSLocalizedString(@"模式", nil)},
                       @{@"icon":@"icon_Randomcolor",@"title":NSLocalizedString(@"强度加", nil)},
                       @{@"icon":@"icon_Randomcolor",@"title":NSLocalizedString(@"强度减", nil)},
                       @{@"icon":@"icon_Randomcolor",@"title":NSLocalizedString(@"加热", nil)},

                       nil];
    }
    if (!_totalsBtnArray) {
        _totalsBtnArray = [NSMutableArray array];
    }
}

- (void)initView {

    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self addSubview:_scrollView];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(ScreenWidth, [UIScreen mainScreen].bounds.size.height);
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [backImg setImage:[UIImage imageNamed:@"all_background"]];
    [_scrollView addSubview:backImg];
    

    if (ScreenHeight < 667) {
        _scrollView.contentSize = CGSizeMake(ScreenWidth, 667);
        backImg.frame = CGRectMake(0, 0, ScreenWidth, 667);
    }

    
    UIImageView *phoneImgView = [[UIImageView alloc] init];
    [self addSubview:phoneImgView];
    [phoneImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(175, 175));
    }];
    [phoneImgView setImage:[UIImage imageNamed:@"icon_Shakeashake"]];
    
    NSInteger count = self.imageArray.count;
    for (NSInteger i = 0; i <= count; i++) {
        [self createImageView:i];

    }

}

- (UIView *)createImageView:(NSInteger)index
{
    CGFloat viewHeight = 80;
    CGFloat viewWidth = 66;
    //    CGFloat imageWidth = 46;
    CGFloat verSpacing = 30;
    CGFloat horSpacing = 54;
    CGFloat imageSpacing = (ScreenWidth - horSpacing*2-viewWidth*3)/2;
    
    ShakeSelectView *shakeView = [[ShakeSelectView alloc] initWithFrame:CGRectMake(horSpacing+(viewWidth+imageSpacing)*(index%3), 50 + (viewHeight+verSpacing)*(index/3)+100, viewWidth, viewHeight)];
    if (index == _imageArray.count-1) {
        shakeView.frame = CGRectMake(horSpacing+(viewWidth+imageSpacing)*2, 50 + (viewHeight+verSpacing)*(index/3), viewWidth, viewHeight);
    }
    [self.totalsBtnArray addObject:shakeView.selButton];
    if (0 == index) {
        _currentSelBtn = shakeView.selButton;
        _currenthakeView = shakeView;
    }
    
    [_scrollView addSubview:shakeView];
    
    shakeView.titleName = self.imageArray[index][@"title"];
    shakeView.btnImageName = self.imageArray[index][@"icon"];
    
    [shakeView setShakeToSelect:^(UIButton *btn) {
        
        NSInteger index = [self.totalsBtnArray indexOfObject:btn];
        _currenthakeView.isSelect = NO;//取消上一个view的选中效果
        _currenthakeView = shakeView;
        
        if (self.buttonBlock) {
            self.buttonBlock(index);
        }
        
    }];
    return shakeView;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex < 0) {
        selectedIndex = 0;
    }
    if (selectedIndex > self.imageArray.count) {
        selectedIndex = self.imageArray.count - 1;
    }
    _selectedIndex = selectedIndex;
    
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"当前模式为%ld",(long)_selectedIndex+1]];

    UIButton *selBtn = self.totalsBtnArray[selectedIndex];
    ShakeSelectView *shakeView = (ShakeSelectView *)[selBtn.superview superview];
    _currenthakeView.isSelect = NO;
    
    shakeView.isSelect = YES;
    _currenthakeView = shakeView;
    
}

//- (void)buttonClick:(UIButton *)btn {
//    NSInteger index = btn.tag - 100;
//    if (self.buttonBlock) {
//        self.buttonBlock(index);
//    }
//}
@end
