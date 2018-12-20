//
//  WakeUpManager.h
//  BeaconYun
//
//  Created by 樊芳 on 2018/12/18.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VoiceWakeUp)(NSString *keywords);
@interface WakeUpManager : NSObject

@property (nonatomic, copy)VoiceWakeUp voiceWakeUp;

+ (instancetype)sharedInstance ;

//开始唤醒
- (void)startWakeup;

@end

NS_ASSUME_NONNULL_END
