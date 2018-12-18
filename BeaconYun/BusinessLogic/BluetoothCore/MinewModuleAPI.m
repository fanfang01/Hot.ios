//
//  MinewModuleAPI.m
//  BeaconYun
//
//  Created by SACRELEE on 3/2/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "MinewModuleAPI.h"
#import "MinewModuleManager.h"
#import "MinewModule.h"
#import "NSTimer+Blocks.h"

@interface MinewModuleAPI ()<MinewModuleManagerDelegate>

@property (nonatomic, strong) MinewModuleManager *manager;

@property (nonatomic, strong) MinewModuleAPI *api;

@end

@implementation MinewModuleAPI

WX_EXPORT_METHOD(@selector(getLastIdentifer:))
WX_EXPORT_METHOD(@selector(connect:completion:))
WX_EXPORT_METHOD(@selector(disconnect:))
WX_EXPORT_METHOD(@selector(dataReceive:))
WX_EXPORT_METHOD(@selector(sendData:hex:completion:))
WX_EXPORT_METHOD(@selector(sendCycleData:hex:interval:completion:))
WX_EXPORT_METHOD(@selector(stopCycleTimer))
WX_EXPORT_METHOD(@selector(getLanguage:))

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static MinewModuleAPI *api = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[self alloc]init];
        [api initModule];
    });
    return api;
}

- (void)initModule
{
    _manager = [MinewModuleManager sharedInstance];
}

- (void)getLastIdentifer:(WXModuleKeepAliveCallback)handler
{
    MinewModuleAPI *api = [self getInstance];
    
    if (api.lastModule)
        handler( api.lastModule.UUID, NO);
    else
        handler( @"", NO);
}

- (void)connect:(NSString *)identifer completion:(WXModuleKeepAliveCallback)handler
{
    MinewModuleAPI *api = [self getInstance];

    MinewModule *module = api.lastModule;
    
    if (module)
    {
        module.connectionHandler = ^(NSDictionary *dataDict, MinewModule *connected) {
            
            if ([dataDict[@"state"] integerValue])
            {
                [[MinewModuleManager sharedInstance] addBindModule:connected];
            }
            
            handler( dataDict, YES);
        };
        
        [api.manager connecnt:module];
    }
    else
        handler(@"", YES);
}

- (void)disconnect:(NSString *)identifer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disconnectingDevice" object:nil];

    MinewModuleAPI *api = [self getInstance];
    
    MinewModule *module = api.lastModule;
    
    if (module)
        [api.manager disconnect:module];
}

- (void)dataReceive:(WXModuleKeepAliveCallback)handler
{
    MinewModuleAPI *api = [self getInstance];

    api.lastModule.receiveHandler = ^(NSData *data) {
        NSString *dataString = [NSString stringWithFormat:@"%@", data];
        dataString = [dataString stringByReplacingOccurrencesOfString:@"<" withString:@""];
        dataString = [dataString stringByReplacingOccurrencesOfString:@">" withString:@""];
        handler(dataString, YES);
    };
}

//hex  是否是 16进制
- (void)sendData:(NSString *)data hex:(BOOL)hex completion:(WXModuleKeepAliveCallback)handler
{
    NSLog(@"++INS:%@, hex:%d", data, hex);
    
    MinewModuleAPI *api = [self getInstance];
    
    if (!api.lastModule)
    {
        handler(@"0", NO);
        return ;
    }
    
    NSData *dataValue = nil;
    
    if (hex)
    {
        dataValue = [self dataFromHexString:data];
        
        if (!dataValue)
        {
            handler(@"0", YES);
            return ;
        }
    }
    else
        dataValue = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"++DATA:%@", dataValue);
    
    
    api.lastModule.writeHandler = ^(BOOL result) {
        handler( result? @"1": @"0", YES);
        
        NSLog(@"++RE:%d", result);
    };
    
    [api.lastModule writeData:dataValue hex:hex];
}

- (void)sendCycleData:(NSString *)data hex:(BOOL)hex interval:(NSString *)inter completion:(WXModuleKeepAliveCallback)handler
{
    MinewModuleAPI *api = [self getInstance];
    
    if (api.timer)
    {
        [api.timer invalidate];
        api.timer = nil;
    }
    
    NSTimeInterval interval = [inter integerValue];
    
    api.timer = [NSTimer scheduledTimerWithTimeInterval:interval block:^{
        [api sendData:data hex:hex completion:handler];    
    } repeats:YES];
    
    [api.timer fire];
}

- (void)stopCycleTimer
{
    MinewModuleAPI *api = [self getInstance];
    
    if (api.timer)
    {
        [api.timer invalidate];
        api.timer = nil;
    }
}

+ (void)disconnectLastModule:(MinewModule *)lastModule
{
    [[MinewModuleManager sharedInstance] disconnect:lastModule];
}

- (void)getLanguage:(WXModuleKeepAliveCallback)handler
{
    handler( [[NSLocale preferredLanguages][0] substringToIndex:2], NO);
}

- (MinewModuleAPI *)getInstance
{
    return [MinewModuleAPI sharedInstance];
}

- (NSData *)dataFromHexString:(NSString *)string
{
    string = [string lowercaseString];
    NSMutableData *data= [NSMutableData new];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i = 0;
    NSInteger length = string.length;
    while (i < length-1) {
        char c = [string characterAtIndex:i++];
        if (c < '0' || (c > '9' && c < 'a') || c > 'f')
            return nil;
        byte_chars[0] = c;
        byte_chars[1] = [string characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}




@end
