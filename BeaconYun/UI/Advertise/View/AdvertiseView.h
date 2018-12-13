//
//  AdvertiseView.h
//  BeaconYun
//
//  Created by 樊芳 on 2018/12/3.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ButtonBlock)(NSInteger index);

typedef void(^PoweronBlock)(BOOL isOn);

@interface AdvertiseView : UIView
@property (nonatomic, strong) UISwitch *onSwitch;

@property (nonatomic, strong)ButtonBlock buttonBlock;

@property (nonatomic, copy)PoweronBlock poweronBlock;

@property (nonatomic,assign)NSInteger selectedIndex;
@end

NS_ASSUME_NONNULL_END
