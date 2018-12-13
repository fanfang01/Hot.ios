//
//  MinewModuleAPI.h
//  BeaconYun
//
//  Created by SACRELEE on 3/2/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>

@class MinewModule, MinewModuleManager;

@interface MinewModuleAPI : NSObject

+ (instancetype)sharedInstance;


@property (nonatomic, strong) MinewModule *lastModule;

@property (nonatomic, strong) NSTimer *timer;

// blocks
//@property (nonatomic, copy) WXModuleKeepAliveCallback notifyBlock;
//@property (nonatomic, copy) WXModuleKeepAliveCallback dataReceiveBlock;
//@property (nonatomic, copy) WXModuleKeepAliveCallback dataSentBlock;

+ (void)disconnectLastModule:(MinewModule *)lastModule;


- (void)getLastIdentifer:(WXModuleKeepAliveCallback)handler;

- (void)connect:(NSString *)identifer completion:(WXModuleKeepAliveCallback)handler;

- (void)disconnect:(NSString *)identifer;

- (void)dataReceive:(WXModuleKeepAliveCallback)handler;

- (void)sendData:(NSString *)data hex:(BOOL)hex completion:(WXModuleKeepAliveCallback)handler;

- (void)sendCycleData:(NSString *)data hex:(BOOL)hex interval:(NSString *)inter completion:(WXModuleKeepAliveCallback)handler;

- (void)stopCycleTimer;



@end
