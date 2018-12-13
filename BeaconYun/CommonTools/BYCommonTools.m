//
//  BeCloudCommonTools.m
//  BeaconYun
//
//  Created by SACRELEE on 2/22/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYCommonTools.h"
#import "BYCommonMacros.h"

@implementation BYCommonTools

#pragma mark ****************************For GUI
+ (UIColor *)colorWithRgb:(NSString *)rgb
{
    NSDictionary *cd = [BYCommonTools colorDictFromRgb:rgb];
    
    return [UIColor colorWithRed:[cd[@"r"] floatValue] / 255.f green: [cd[@"g"] floatValue] / 255.f blue:[cd[@"b"] floatValue] / 255.f alpha:1.0];
}

+ (UIColor *)colorWithRgb:(NSString *)rgb alpha:(float)al
{
    NSDictionary *cd = [BYCommonTools colorDictFromRgb:rgb];
    
    return [UIColor colorWithRed:[cd[@"r"] floatValue] / 255.f green: [cd[@"g"] floatValue] / 255.f blue:[cd[@"b"] floatValue] / 255.f alpha:al];
}

+ (NSDictionary *)colorDictFromRgb:(NSString *)rgb
{
    NSString *tmpRgb = [rgb stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    NSPredicate *checker = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[A-Za-z0-9]{6}"];
    
    if (![checker evaluateWithObject:tmpRgb])
    {
        BYLog(@"%@ is not a Rgb value", rgb);
        return nil;
    }
    
    float r = strtol( [[tmpRgb substringWithRange:NSMakeRange( 0, 2)] UTF8String], NULL, 16) * 1.0;
    float g = strtol( [[tmpRgb substringWithRange:NSMakeRange( 2, 2)] UTF8String], NULL, 16) * 1.0;
    float b = strtol( [[tmpRgb substringWithRange:NSMakeRange( 4, 2)] UTF8String], NULL, 16) * 1.0;
    
    return @{ @"r": @(r), @"g": @(g), @"b": @(b)};
}

@end
