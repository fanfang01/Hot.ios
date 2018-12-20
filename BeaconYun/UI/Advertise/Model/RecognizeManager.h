//
//  RecognizeManager.h
//  BeaconYun
//
//  Created by 樊芳 on 2018/12/18.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FinalVoiceReco)(NSString *voice);
@interface RecognizeManager : NSObject

@property (nonatomic, copy) FinalVoiceReco voiceReco;

+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
