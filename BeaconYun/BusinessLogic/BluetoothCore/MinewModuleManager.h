//
//  MinewModuleManager.h
//  MinewModuleDemo
//
//  Created by SACRELEE on 11/16/16.
//  Copyright © 2016 SACRELEE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MinewModule;

typedef NS_ENUM(NSUInteger, BluetoothStatus) {
    BluetoothStatusPowerOff,
    BluetoothStatusPowerOn,
    BluetoothStatusUnknown,
};

typedef NS_ENUM(NSUInteger, LinkStatus) {
    LinkStatusDisconnect,
    LinkStatusConnecting,
    LinkStatusConnected,
    LinkStatusConnectFailed,
};

typedef void(^FindDevice)(MinewModule *module);

@class MinewModuleManager, MinewModule, MinewModule;

@protocol MinewModuleManagerDelegate <NSObject>

@optional
/**
 listem bluetooth status
 
 @param manager which manager
 @param status current bluetooth status
 */
- (void)manager:(MinewModuleManager *)manager didChangeBluetoothStatus:(BluetoothStatus)status;


/**
 call back when the manager find new Modules.
 
 @param manager which manager
 @param modules all new Modules.
 */
- (void)manager:(MinewModuleManager *)manager appearModules:(NSArray *)modules;


/**
 call back if Modules doesn't update data in 10 seconds.
 
 @param manager which manager
 @param modules the disappear Modules.
 */
- (void)manager:(MinewModuleManager *)manager disappearModules:(NSArray *)modules;


/**
 call back when a Module change the connection status between manager.
 
 @param manager which manager
 @param status current connection status
 @param module which Module
 */
- (void)manager:(MinewModuleManager *)manager didChangeModule:(MinewModule *)module linkStatus:(LinkStatus)status;


@end

@interface MinewModuleManager : NSObject
@property (nonatomic, copy)FindDevice findDevice;

// current bluetooth status
@property (nonatomic, assign) BluetoothStatus status;

// all modules scanned
@property (nonatomic, strong) NSArray *allModules;

// modules in range
@property (nonatomic, strong) NSArray *inrangeModules;

@property (nonatomic, strong) NSArray *bindModules;

@property (nonatomic, weak) id<MinewModuleManagerDelegate> delegaate;

+ (MinewModuleManager *)sharedInstance;

// scan for modules
- (void)startScan;

// stop scan
- (void)stopScan;

// connect to a module
- (void)connecnt:(MinewModule *)module;

// disconnect from a module
- (void)disconnect:(MinewModule *)module;

- (void)addBindModule:(MinewModule *)module;

- (void)removeBindModule:(MinewModule *)module;

//
- (MinewModule *)moduleExist:(NSString *)uuid;

@end
