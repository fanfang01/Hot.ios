//
//  MTCommonTool.m
//  Peripheral
//
//  Created by SACRELEE on 4/11/18.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import "MTCommonTool.h"

@implementation MTCommonTool

+ (NSString *)hexStringFromData:(NSData *)data
{
    NSUInteger dataLength = [data length];
    NSMutableString *string = [NSMutableString stringWithCapacity:dataLength*2];
    const unsigned char *dataBytes = [data bytes];
    for (NSInteger idx = 0; idx < dataLength; ++idx) {
        [string appendFormat:@"%02x", dataBytes[idx]];
    }
    return string;
}

@end
