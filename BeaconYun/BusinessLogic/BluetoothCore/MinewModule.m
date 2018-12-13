//
//  MinewModule.m
//  MinewModuleDemo
//
//  Created by SACRELEE on 11/16/16.
//  Copyright © 2016 SACRELEE. All rights reserved.
//

#import "MinewModule.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "MinewCommonTool.h"

#define sWriteUUIDs @[@"6E400002-B5A3-F393-E0A9-E50E24DCCA9E", @"FFF2"]
#define sNotifyUUIDs @[@"6E400003-B5A3-F393-E0A9-E50E24DCCA9E", @"FFF1"]
#define sServiceUUIDs @[@"6E400001-B5A3-F393-E0A9-E50E24DCCA9E", @"FFF0"]

@interface MinewModule()<CBPeripheralDelegate>

@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;

@property (nonatomic, strong) CBCharacteristic *notifyCharacteristic;

@end

@implementation MinewModule

@synthesize rssi = _rssi;
@synthesize name = _name;
@synthesize connected = _connected;
@synthesize inRange = _inRange;
@synthesize battery = _battery;

- (void)writeData:(NSData *)data hex:(BOOL)hex
{
    if (!_writeCharacteristic && _writeHandler)
    {
        _writeHandler(NO);
        return ;
    }
    
    [_peripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

- (instancetype)initWithPeripheral:(CBPeripheral *)per infoDict:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        _peripheral = per;
        _updateTime = [NSDate date];
        _UUID = per.identifier.UUIDString;
        _name = per.name;
        _customName = info[@"customName"];
        [per readRSSI];
    }
    return self;
}



#pragma mark ************************************Bluetooth
- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral
{
    _name = peripheral.name;
}

- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error
{
    _rssi = [RSSI integerValue];
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSInteger svcCount = peripheral.services.count;
    
    if (svcCount != 1)
    {
        [self executeConnectionHandler:NO];
        return ;
    }
    
    
    for ( CBService *s in peripheral.services)
    {
        if ([sServiceUUIDs indexOfObject:s.UUID.UUIDString])
           [peripheral discoverCharacteristics:nil forService:s];
        else
            [self executeConnectionHandler:NO];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"++++%@", characteristic);
    
    if ([_notifyCharacteristic.UUID.UUIDString isEqualToString:characteristic.UUID.UUIDString] && !error)
    {
        if (_receiveHandler)
           _receiveHandler(characteristic.value);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didUpdateNotificationStateForCharacteristic Error:%@", error);
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *c in service.characteristics)
    {
    
        if ([sNotifyUUIDs indexOfObject:[c.UUID.UUIDString uppercaseString]] != NSNotFound)
        {
           [peripheral setNotifyValue:YES forCharacteristic:c];
            _notifyCharacteristic = c;
        }
        else if ([sWriteUUIDs indexOfObject:[c.UUID.UUIDString uppercaseString]] != NSNotFound)
                 _writeCharacteristic = c;
        
        [peripheral readValueForCharacteristic:c];
    }
    
    
    if (!_connectionHandler)
        return ;
    
    
    if (_writeCharacteristic && _notifyCharacteristic)
        [self executeConnectionHandler:YES];
    else
        [self executeConnectionHandler:NO];
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didWriteValueForCharacteristic Error:%@", error);
    if ( [_writeCharacteristic.UUID.UUIDString isEqualToString:characteristic.UUID.UUIDString] && _writeHandler)
    {
        _writeHandler(error? NO: YES);
    }
}

- (void)executeConnectionHandler:(BOOL)connected
{
    if (_connectionHandler)
    {
        NSDictionary *dict = connected? [self deviceInfo]: @{@"state": @"0"};
        _connectionHandler(dict, self);
    }
}



#pragma mark ***********************************Setter
- (void)setPeripheral:(CBPeripheral *)peripheral
{
    _peripheral = peripheral;
    _UUID = peripheral.identifier.UUIDString;
    _peripheral.delegate = self;
}

- (void)didConnect
{
    _connected = YES;
    _connecting = NO;
    [_peripheral discoverServices:nil];
}


- (void)didDisconnect
{
    _connecting = NO;
    _connected = NO;
    
    [self executeConnectionHandler:NO];
}


- (void)didConnectFailed
{
    _connecting = NO;
    _connected = NO;
    [self executeConnectionHandler:NO];
}

- (NSDictionary *)deviceInfo
{
    NSMutableDictionary *infoOut = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [infoOut setValue:@"1" forKey:@"state"];
    
    
    if (_name)
        [infoOut setValue:_name forKey:@"name"];
    
    [infoOut setValue:@(_rssi) forKey:@"rssi"];
    [infoOut setValue:@(_battery) forKey:@"battery"];
    
    if (_UUID)
       [infoOut setValue:_UUID forKey:@"identifer"];
    
    return [NSDictionary dictionaryWithDictionary:infoOut];
}


@end
