//
//  CustomManager.m
//  BeaconYun
//
//  Created by SACRELEE on 2/23/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYCustomManager.h"

#define sCustomDict [[NSBundle mainBundle] pathForResource:@"BYCustomConfig" ofType:@"plist"]


@implementation BYCustomManager

+ (NSDictionary *)getCustomNavSettings:(NSString *)typeName
{
    NSDictionary *configs = [NSDictionary dictionaryWithContentsOfFile:sCustomDict];
    
    return configs[@"NavigationBar"][typeName];
}

@end
