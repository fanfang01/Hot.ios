//
//  BeCloudCommonMacros.h
//  BeaconYun
//
//  Created by SACRELEE on 2/22/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#ifndef BeCloudCommonMacros_h
#define BeCloudCommonMacros_h


#endif /* BeCloudCommonMacros_h */


// log print
#ifdef DEBUG
#define BYLog(fmt, ...) do{ NSLog((@"[%@: %s (%d)]: %@"), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, [NSString stringWithFormat:fmt, ##__VA_ARGS__]);} while(0)
#else
#define BYLog(...)
#endif

#define sScreenHeight [UIScreen mainScreen].bounds.size.height
#define sScreenWidth [UIScreen mainScreen].bounds.size.width

#define sIconsFont @"FontAwesome"
