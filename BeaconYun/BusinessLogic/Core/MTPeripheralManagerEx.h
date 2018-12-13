//
//  MTPeripheralManagerEx.h
//  Peripheral
//
//  Created by SACRELEE on 4/10/18.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import "MTPeripheralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface MTPeripheralManager()<CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *manager;

@property (nonatomic, strong) CBMutableCharacteristic *otaCharac;

@property (nonatomic, strong) CBMutableCharacteristic *energyCharac;

@property (nonatomic, strong) CBMutableCharacteristic *unpairCharac;

@property (nonatomic, assign) BOOL charging;

@property (nonatomic, strong) NSMutableArray *centrals;

@property (nonatomic, copy) StartChargeBlock chargingBlock;

- (void)enableOTA;

@end
