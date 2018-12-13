//
//  BYHeaderView.h
//  BeaconYun
//
//  Created by SACRELEE on 2/24/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HeaderViewType) {
    HeaderViewTypeArrow,
    HeaderViewTypeNormal,
};

typedef void(^TouchEvent)();

@interface BYHeaderView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) TouchEvent tapped;

- (instancetype)initWithType:(HeaderViewType)t title:(NSString *)title;


@end
