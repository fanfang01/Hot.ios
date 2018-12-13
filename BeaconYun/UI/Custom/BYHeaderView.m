//
//  BYHeaderView.m
//  BeaconYun
//
//  Created by SACRELEE on 2/24/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYHeaderView.h"
#import "BYCommonMacros.h"
#import "BYCommonTools.h"

#define sHeaderHeight 40.f

@interface BYHeaderView () <UIGestureRecognizerDelegate>

@end

@implementation BYHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithType:(HeaderViewType)t title:(NSString *)title
{
    CGRect rect = CGRectMake( 0, 0, sScreenWidth, sHeaderHeight);
    self = [super initWithFrame:rect];
    if (self)
    {
        _title = title;
        [self initGUI:t];
    }
    return self;
}

- (void)initGUI:(HeaderViewType)t
{
    self.backgroundColor = [BYCommonTools colorWithRgb:@"#FFFFFF" alpha:0.54];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake( 20, 0, sScreenWidth - 20.f, sHeaderHeight);
    titleLabel.text = _title;
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    
    if (t == HeaderViewTypeArrow)
    {
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake( 0, sScreenWidth - sHeaderHeight, sHeaderHeight, sHeaderHeight)];
//        arrow.image = [UIImage imageNamed:@""];
        [self addSubview:arrow];
    }
    
    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)tapped:(UIGestureRecognizer *)sender
{
    if (_tapped)
        _tapped();
}

@end
