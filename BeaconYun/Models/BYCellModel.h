//
//  cellModel.h
//  BeaconYun
//
//  Created by SACRELEE on 2/23/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CellModelType) {
    CellModelTypeCommon = 0,
    CellModelTypeInput,
};


@interface BYCellModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CellModelType type;
@property (nonatomic, strong) NSString *logoName;
@property (nonatomic, strong) NSString *detailText;

@end
