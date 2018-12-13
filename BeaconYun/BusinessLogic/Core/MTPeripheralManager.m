//
//  MTPeripheralManager.m
//  Peripheral
//
//  Created by SACRELEE on 3/21/18.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import "MTPeripheralManagerEx.h"
#import "MTCommonTool.h"

#define sCharacUUIDs @[@"0001", @"0002", @"0003", @"1111", @"1112"]

typedef NS_ENUM(NSUInteger, CharaType) {
    CharaTypeEnergyMeter = 0,
    CharaTypeCharging,
    CharaTypeUnpair,
    CharaTypeOTA,
    CharaTypeMac,
};



@implementation MTPeripheralManager


+ (instancetype)sharedInstance
{
    static MTPeripheralManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[MTPeripheralManager alloc]init];
    });
    return m;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [[CBPeripheralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue() options:nil];
        
//        [self performSelector:@selector(startAdvtising) withObject:nil afterDelay:1];
        
        uint8_t bytes[13] = {0xff, 0x10, 0xff, 0xff, 0xff, 0x20, 0xff, 0xff, 0xff, 0x30, 0xff, 0xff, 0xff};
        _lightData = [NSData dataWithBytes:bytes length:13];
    }
    return self;
}


- (void)startAdvtising
{
    [_manager stopAdvertising];
    
    CBUUID *uuid = [CBUUID UUIDWithString:_searchstr];
    NSLog(@"广播的字符串======%@",uuid.UUIDString);
    
    //remove all the services added before
    [_manager removeAllServices];
    
    if (_searchstr.length <= 0) {
        _searchstr = @"0xFFF0";
    }
    CBUUID *newUuid = [CBUUID UUIDWithString:_searchstr];
    
    
    [_manager startAdvertising:@{CBAdvertisementDataLocalNameKey: @"ASK",
                                 CBAdvertisementDataServiceUUIDsKey: @[newUuid,],
//                                 CBAdvertisementDataIsConnectable:@(NO),
//                                 CBAdvertisementDataManufacturerDataKey:data
                                 }];
}



- (void)stopAdvertising {
    [_manager stopAdvertising];
}

- (void)enableOTA
{
    uint8_t ota = 0x01;
    [_manager updateValue:[NSData dataWithBytes:&ota length:1] forCharacteristic:_otaCharac onSubscribedCentrals:_centrals];
}

- (void)didStartCharge:(StartChargeBlock)handler
{
    _chargingBlock = handler;
}

- (CharaType)typeOfCharacterstic:(CBCharacteristic *)charac
{
    NSString *uuid = charac.UUID.UUIDString;
    return [sCharacUUIDs indexOfObject:uuid];
}


#pragma mark *************************************** Peripheral Delegates
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state) {
        case 5:
//            [self setUp];
            break;
        case 4:
            NSLog(@"已关闭");
            break;
        default:
            break;
    }
}

//当接收到中央端读的请求时会调用didReceiveReadRequest:
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
{
    CBCharacteristic *charac = request.characteristic;
    
    if (charac.properties & CBCharacteristicPropertyRead) {
        
        CharaType type = [self typeOfCharacterstic:charac];
        
        switch (type) {
            case CharaTypeEnergyMeter:    // 光
            {
                [request setValue:_lightData];
                [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
            }
                break;
                
            default:
                break;
        }
    }
    else
        [peripheral respondToRequest:request withResult:CBATTErrorReadNotPermitted];
}

//当接收到中央端写的请求时会调用didReceiveWriteRequest:
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests
{
    for ( NSInteger i = 0; i < requests.count; i ++) {
        
        CBATTRequest *request = requests[i];
        CBMutableCharacteristic *charac = (CBMutableCharacteristic *)request.characteristic;
        
        if (charac.properties & CBCharacteristicPropertyWrite) {
            
            CharaType type = [self typeOfCharacterstic:charac];
            switch (type) {
                case CharaTypeMac:
                {
                    charac.value = request.value;
                    [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
                    
                    _macString = [MTCommonTool hexStringFromData:request.value];
                }
                    break;
                case CharaTypeCharging:
                {
                    charac.value = request.value;
                    [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
                    self.charging = YES;
                }
                    break;
                default:
                    break;
            }
        }
        else
            [peripheral respondToRequest:request withResult:CBATTErrorWriteNotPermitted];
    }
}

- (void)setDesiredConnectionLatency:(CBPeripheralManagerConnectionLatency)latency forCentral:(CBCentral *)central {
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    [self startAdvtising];
}

//when [self.peripheralManager startAdvertising:] 会监听 DidStartAdvertising
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    NSLog(@"when [self.peripheralManager startAdvertising:] 会监听 DidStartAdvertising");
}

//当中央端连接上了此设备并订阅了特征时会回调 didSubscribeToCharacteristic:
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    if (![_centrals containsObject:central]) {
        [_centrals addObject:central];
        [self enableOTA];
    }
}

//当中央端取消订阅时会调用didUnsubscribeFromCharacteristic:
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(nonnull CBCharacteristic *)characteristic
{
    if ([_centrals containsObject:central]) {
        [_centrals removeObject:central];
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary<NSString *,id> *)dict
{
    peripheral.delegate = nil;
    
    if (peripheral.isAdvertising) {
        [peripheral stopAdvertising];
    }
}




@end
