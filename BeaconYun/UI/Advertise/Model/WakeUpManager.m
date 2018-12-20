//
//  WakeUpManager.m
//  BeaconYun
//
//  Created by 樊芳 on 2018/12/18.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import "WakeUpManager.h"



@interface WakeUpManager ()<BDSClientWakeupDelegate>

@property (strong, nonatomic) BDSEventManager *wakeupEventManager;

@end

@implementation WakeUpManager

+ (instancetype)sharedInstance {
    static WakeUpManager *wakeupManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wakeupManager = [[WakeUpManager alloc] init];
    });
    return wakeupManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //唤醒服务开启
        [self configWakeupClient];
    }
    return self;
}

//唤醒机制的配置
- (void)configWakeupClient {
    self.wakeupEventManager = [BDSEventManager createEventManagerWithName:BDS_WAKEUP_NAME];
    [self.wakeupEventManager setDelegate:self];
    [self.wakeupEventManager setParameter:APP_ID forKey:BDS_WAKEUP_APP_CODE];
    
    [self configWakeupSettings];
}

- (void)configWakeupSettings {
    NSString* dat = [[NSBundle mainBundle] pathForResource:@"bds_easr_basic_model" ofType:@"dat"];
    
    // 默认的唤醒词为"百度一下"，如需自定义唤醒词，请在 http://ai.baidu.com/tech/speech/wake 中评估并下载唤醒词，替换此参数
    //    NSString* words = [[NSBundle mainBundle] pathForResource:@"bds_easr_wakeup_words" ofType:@"dat"];
    
    NSString* keywords = [[NSBundle mainBundle] pathForResource:@"WakeUp" ofType:@"bin"];
    [self.wakeupEventManager setParameter:dat forKey:BDS_WAKEUP_DAT_FILE_PATH];
    [self.wakeupEventManager setParameter:keywords forKey:BDS_WAKEUP_WORDS_FILE_PATH];
}

- (void)startWakeup
{
    //    [self configWakeupClient];
    [self.wakeupEventManager setParameter:nil forKey:BDS_WAKEUP_AUDIO_FILE_PATH];
    [self.wakeupEventManager setParameter:nil forKey:BDS_WAKEUP_AUDIO_INPUT_STREAM];
    [self.wakeupEventManager sendCommand:BDS_WP_CMD_LOAD_ENGINE];
    [self.wakeupEventManager sendCommand:BDS_WP_CMD_START];
}

#pragma mark --- BDSClientWakeupDelegate
- (void)WakeupClientWorkStatus:(int)workStatus obj:(id)aObj
{
    switch (workStatus) {
        case EWakeupEngineWorkStatusStarted: {
            [self printLogTextView:@"WAKEUP CALLBACK: Started.\n"];
            break;
        }
        case EWakeupEngineWorkStatusStopped: {
            [self printLogTextView:@"WAKEUP CALLBACK: Stopped.\n"];
            break;
        }
        case EWakeupEngineWorkStatusLoaded: {
            [self printLogTextView:@"WAKEUP CALLBACK: Loaded.\n"];
            break;
        }
        case EWakeupEngineWorkStatusUnLoaded: {
            [self printLogTextView:@"WAKEUP CALLBACK: UnLoaded.\n"];
            break;
        }
        case EWakeupEngineWorkStatusTriggered: {
            [self printLogTextView:[NSString stringWithFormat:@"WAKEUP CALLBACK: Triggered - %@.\n", (NSString *)aObj]];
            //            if (self.continueToVR) {
            //                self.continueToVR = NO;
            NSString *key = [NSString stringWithFormat:@"%@",((NSString *)aObj)];
            [SVProgressHUD showSuccessWithStatus:key];
//            [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_NEED_CACHE_AUDIO];
//            [self.asrEventManager setParameter:aObj forKey:BDS_ASR_OFFLINE_ENGINE_TRIGGERED_WAKEUP_WORD];
//            [self voiceRecogButtonHelper];
            
            if (self.voiceWakeUp) {
                self.voiceWakeUp(key);
            }
            //            }
            break;
        }
        case EWakeupEngineWorkStatusError: {
            [self printLogTextView:[NSString stringWithFormat:@"WAKEUP CALLBACK: encount error - %@.\n", (NSError *)aObj]];
            break;
        }
            
        default:
            break;
    }
}

//唤醒的初始化操作
- (void)onInitializing
{
    
}

- (void)voiceRecogButtonHelper
{
    //    [self configFileHandler];
//    [self.asrEventManager setDelegate:self];
//    [self.asrEventManager setParameter:nil forKey:BDS_ASR_AUDIO_FILE_PATH];
//    [self.asrEventManager setParameter:nil forKey:BDS_ASR_AUDIO_INPUT_STREAM];
//    [self.asrEventManager sendCommand:BDS_ASR_CMD_START];
//    [self onInitializing];
}

- (NSDictionary *)parseLogToDic:(NSString *)logString
{
    NSArray *tmp = NULL;
    NSMutableDictionary *logDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    NSArray *items = [logString componentsSeparatedByString:@"&"];
    for (NSString *item in items) {
        tmp = [item componentsSeparatedByString:@"="];
        if (tmp.count == 2) {
            [logDic setObject:tmp.lastObject forKey:tmp.firstObject];
        }
    }
    return logDic;
}

- (NSString *)getDescriptionForDic:(NSDictionary *)dic {
    if (dic) {
        return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic
                                                                              options:NSJSONWritingPrettyPrinted
                                                                                error:nil] encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (void)printLogTextView:(NSString *)logString
{
    NSLog(@"打印log===%@",logString);
}

- (void)dealloc {
    [self stopWakeup];
}

- (void)stopWakeup {
    [self.wakeupEventManager sendCommand:BDS_WP_CMD_STOP];
}

@end
