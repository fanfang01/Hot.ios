//
//  MTBeaconManager.m
//  Peripheral
//
//  Created by SACRELEE on 3/21/18.
//  Copyright © 2018 MinewTech. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "MTBeaconManager.h"
#import "MTPeripheralManager.h"


@interface MTBeaconManager()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MTBeaconManager

+ (instancetype)sharedInstance
{
    static MTBeaconManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[MTBeaconManager alloc]init];
    });
    return m;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    
    if ( [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestAlwaysAuthorization];
    }
}

- (void)startMonitoring
{
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc]initWithProximityUUID:[[NSUUID alloc]initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"] identifier:@"myBeaconRegion"];
    region.notifyEntryStateOnDisplay = YES;
    region.notifyOnExit = YES;
    region.notifyOnEntry = YES;
    
    [_locationManager startRangingBeaconsInRegion:region];
    [_locationManager startMonitoringForRegion:region];
}

- (void)wakeUpInRegion:(CLRegion *)region
{
//    [PushManager pushNotification:@"被唤醒"];
    NSLog(@"被唤醒");
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        [[MTPeripheralManager sharedInstance] startAdvtising];
    }
}

#pragma mark ************************************* Location Delegate
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [self wakeUpInRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [self wakeUpInRegion:region];

}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    [self wakeUpInRegion:region];

}




@end
