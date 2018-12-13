//
//  MTBeaconManager.h
//  Peripheral
//
//  Created by SACRELEE on 3/21/18.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTBeaconManager : NSObject

+ (instancetype)sharedInstance;

- (void)startMonitoring;

@end
