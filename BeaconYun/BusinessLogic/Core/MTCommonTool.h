//
//  MTCommonTool.h
//  Peripheral
//
//  Created by SACRELEE on 4/11/18.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import "MTPeripheralManager.h"

@interface MTCommonTool : MTPeripheralManager

+ (NSString *)hexStringFromData:(NSData *)data;

@end
