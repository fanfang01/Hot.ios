//
//  BYSectionModel.h
//  BeaconYun
//
//  Created by SACRELEE on 2/23/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYSectionModel : NSObject

@property (nonatomic, assign) NSInteger serial;
@property (nonatomic, assign) NSInteger rowAtitude;
@property (nonatomic, assign) float rowHeight;
@property (nonatomic, assign) float headerHeight;
@property (nonatomic, assign) float footerHeight;
@property (nonatomic, strong) id    header;   // NSString or UIView
@property (nonatomic, strong) id    footer;   // NSString or UIView

@end
