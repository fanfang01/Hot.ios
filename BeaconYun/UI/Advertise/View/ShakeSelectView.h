//
//  ShakeSelectView.h
//  MinewRGB
//
//  Created by Minewtech on 2018/1/24.
//  Copyright © 2018年 Minewtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShakeSelectView : UIView
@property (strong, nonatomic) NSString *btnImageName;

@property (strong, nonatomic) NSString *titleName;
@property (assign, nonatomic) BOOL isSelect;

@property (strong, nonatomic) UIButton *selButton;


@property(copy,nonatomic)void (^shakeToSelect)(UIButton *);
@end
