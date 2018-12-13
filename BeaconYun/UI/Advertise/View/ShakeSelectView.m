//
//  ShakeSelectView.m
//  MinewRGB
//
//  Created by Minewtech on 2018/1/24.
//  Copyright © 2018年 Minewtech. All rights reserved.
//

#import "ShakeSelectView.h"

@interface ShakeSelectView()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *currentSelBtn;
@end

@implementation ShakeSelectView
{
    CGFloat viewHeight ;
    CGFloat viewWidth ;
    CGFloat imageWidth ;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

- (void )initView
{
    CGFloat viewHeight = 80;
    CGFloat viewWidth = 66;
    CGFloat imageWidth = 46;
//    CGFloat verSpacing = 30;
//    CGFloat horSpacing = 54;
//    CGFloat imageSpacing = (ScreenWidth - horSpacing*2-viewWidth*3)/2;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [self addSubview:view];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    _selButton = button;
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(5);
        make.left.equalTo(view).offset(10);
        make.centerX.equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(imageWidth, imageWidth));
    }];
    
    [button addTarget:self action:@selector(shakeToSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = imageWidth/2;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(10);
        make.left.equalTo(view.mas_left);
        make.right.equalTo(view.mas_right);
        make.bottom.equalTo(view.mas_bottom);
    }];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = COLOR_RGBA(255, 255, 255, 0.5);
}

- (void)setBtnImageName:(NSString *)btnImageName
{
    _btnImageName = btnImageName;
    [_selButton setImage:[UIImage imageNamed:btnImageName] forState:UIControlStateNormal];
    [_selButton setImage:[UIImage imageNamed:[btnImageName stringByAppendingString:@"01"] ] forState:UIControlStateSelected];
}

- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    _titleLabel.text = titleName;
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    _selButton.selected = isSelect;
    if (_isSelect) {
        _titleLabel.textColor = [UIColor whiteColor];
    }else{
        _titleLabel.textColor = COLOR_RGBA(255, 255, 255, 0.5);
    }
}

- (void)shakeToSelectAction:(UIButton *)btn
{
//    btn.selected = !btn.selected;
//    if ([self.currentSelBtn isEqual:btn]) {
//        return;
//    }else{
//        self.currentSelBtn.selected = NO;
//        self.currentSelBtn = btn;
//    }
    if (self.shakeToSelect) {
        self.shakeToSelect(btn);
    }
    self.isSelect = YES;
}
@end
