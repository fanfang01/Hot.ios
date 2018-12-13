//
//  CommonTool.m
//  YlwlBeaconManager
//
//  Created by SACRELEE on 16/8/11.
//  Copyright © 2016年 com.YLWL. All rights reserved.
//

#import "MinewCommonTool.h"


@implementation MinewCommonTool

+ (NSString *)deleteCharacter:(char)cha ofString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString: string];
    for (int i = 0; i < str.length; ++i)
    {
        if ([str characterAtIndex:i] == cha)
        {
            [str deleteCharactersInRange:NSMakeRange(i, 1)];
        }
    }
    return str;
}

+ (NSString *)replaceCharacter:(char)originCha withCharacter:(char)newCha ofString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString: string];
    for (int i = 0; i < str.length; ++i)
    {
        if ([str characterAtIndex:i] == originCha)
        {
            [str deleteCharactersInRange:NSMakeRange(i, 1)];
            [str insertString:[NSString stringWithFormat:@"%c", newCha] atIndex:i];
        }
    }
    return str;
}

+ (NSInteger)decimalFromHexString:(NSString *)hexStr
{

    const char *hexChars = [hexStr UTF8String];
    
    NSInteger intValue = (NSInteger)strtol(hexChars, NULL, 16);
    
    return intValue;
}

+ (NSInteger)signedHexToInteger:(NSString *)hexStr
{
    NSString *binaryStr = @"";
    
    for (int i = 0; i < hexStr.length; i ++)
    {
        char c = [hexStr characterAtIndex:i];
        
        NSString *tempBinary = nil;
        switch (c)
        {
            case '0':
                tempBinary = @"0000";
                break;
            case '1':
                tempBinary = @"0001";
                break;
            case '2':
                tempBinary = @"0010";
                break;
            case '3':
                tempBinary = @"0011";
                break;
            case '4':
                tempBinary = @"0100";
                break;
            case '5':
                tempBinary = @"0101";
                break;
            case '6':
                tempBinary = @"0110";
                break;
            case '7':
                tempBinary = @"0111";
                break;
            case '8':
                tempBinary = @"1000";
                break;
            case '9':
                tempBinary = @"1001";
                break;
            case 'a':
                tempBinary = @"1010";
                break;
            case 'b':
                tempBinary = @"1011";
                break;
            case 'c':
                tempBinary = @"1100";
                break;
            case 'd':
                tempBinary = @"1101";
                break;
            case 'e':
                tempBinary = @"1110";
                break;
            case 'f':
                tempBinary = @"1111";
                break;
            default:
                break;
        }
        binaryStr = [binaryStr stringByAppendingString:tempBinary];
    }
    
    
    char firstChar = [binaryStr characterAtIndex:0];
    
    
    if (firstChar == '0')
        return [self decimalFromHexString:hexStr];
    
    NSMutableString *optionStr = [NSMutableString stringWithString:@"1"];
    
    for ( NSInteger i = 1; i < binaryStr.length; i ++)
    {
        char c = [binaryStr characterAtIndex:i];
        
        [optionStr appendString:c == '0'? @"1": @"0"];
    }
    
    for ( NSInteger i = binaryStr.length - 1; i > 0; i --)
    {
        char c = [optionStr characterAtIndex:i];
        
        [optionStr replaceCharactersInRange:NSMakeRange( i, 1) withString: c == '1'? @"0": @"1"];
        
        if (c == '0')
            break ;
    }
    
    [optionStr replaceCharactersInRange:NSMakeRange( 0, 1) withString:@""];
    
    long intValue = strtol( [optionStr UTF8String], NULL, 2);
    
    return intValue * -1;
  
}

+ (void)onMainThread:(void(^)())block
{
    if ([[NSThread currentThread].name isEqualToString:@"main"])
        block();
    else
    {
        dispatch_async( dispatch_get_main_queue(), ^{
            block();
        });
    }
}

+ (void)onThread:(dispatch_queue_t)queue execute:(void(^)())block
{
   dispatch_async(queue, ^{
       block();
   });
}

+ (NSString *)getDataString:(NSObject *)data
{
    NSString *dataString = [NSString stringWithFormat:@"%@", data];
    
    NSArray *signs = @[@"<", @" ", @">"];
    
    for ( NSString *sign in signs)
    {
        dataString = [dataString stringByReplacingOccurrencesOfString:sign withString:@""];
    }
    
    return dataString;
}

+ (float)distanceByRSSI:(NSInteger)rssi
{
    
    if (rssi == 0)
    {
        return -1.0;
    }
    
    int txPower = -55;
    
    double ratio = rssi * 1.0 / txPower;
    
    if (ratio < 1.0)
    {
        return (double)(pow(ratio, 10));
    }
    else
    {
        double accuracy = (0.89976) * pow(ratio, 7.7095) + 0.111;
        return accuracy;
    }
}

@end
