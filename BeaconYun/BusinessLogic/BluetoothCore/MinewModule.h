//
//  MinewModule.h
//  MinewModuleDemo
//
//  Created by SACRELEE on 11/16/16.
//  Copyright © 2016 SACRELEE. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ConnectionState) {
    StateConnected,
    StateDisconnected,
};

@class MinewModule;

typedef void(^Connection)(NSDictionary *dataDict, MinewModule *module);
typedef void(^Receive)(NSData *data);
typedef void(^Send)(BOOL result);

@class CBPeripheral;

@interface MinewModule : NSObject

@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) NSString *UUID;

@property (nonatomic, assign) BOOL connecting;

@property (nonatomic, assign) BOOL activeDisconnect;

@property (nonatomic, strong) NSDate *updateTime;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *customName;

@property (nonatomic, assign) NSInteger rssi;

@property (nonatomic, assign) NSInteger battery;

@property (nonatomic, assign) BOOL inRange;

@property (nonatomic, assign) BOOL connected;

@property (nonatomic, copy) Connection connectionHandler;

@property (nonatomic, copy) Receive receiveHandler;

@property (nonatomic, copy) Send writeHandler;


- (instancetype)initWithPeripheral:(CBPeripheral *)per infoDict:(NSDictionary *)info;

// write data to module
- (void)writeData:(NSData *)data hex:(BOOL)hex;


- (void)didConnect;
- (void)didDisconnect;
- (void)didConnectFailed;

@end
