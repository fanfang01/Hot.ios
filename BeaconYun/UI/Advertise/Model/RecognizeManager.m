//
//  RecognizeManager.m
//  BeaconYun
//
//  Created by 樊芳 on 2018/12/18.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import "RecognizeManager.h"

@interface RecognizeManager ()<BDSClientASRDelegate>

@property (strong, nonatomic) BDSEventManager *asrEventManager;

@end

@implementation RecognizeManager

+ (instancetype)sharedInstance {
    static RecognizeManager *recManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        recManager = [[RecognizeManager alloc] init];
    });
    return recManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initCore];
    }
    return self;
}

- (void)initCore {
    //创建语音识别对象
    self.asrEventManager = [BDSEventManager createEventManagerWithName:BDS_ASR_NAME];
    //设置语音识别代理
    [self.asrEventManager setDelegate:self];
    
    //参数配置
    //1.设置DEBUG_LOG的级别
    [self.asrEventManager setParameter:@(EVRDebugLogLevelTrace) forKey:BDS_ASR_DEBUG_LOG_LEVEL];
    
    [self.asrEventManager setParameter:@[API_KEY,SECRET_KEY] forKey:BDS_ASR_API_SECRET_KEYS];
    //设置 APPID
    [self.asrEventManager setParameter:APP_ID forKey:BDS_ASR_OFFLINE_APP_CODE];
    
    //    self.wakeupEventManager = [BDSEventManager createEventManagerWithName:BDS_WAKEUP_NAME];
    
    NSLog(@"Current SDK version: %@",[self.asrEventManager libver]);
    
    NSString *modelVAD_filepath = [[NSBundle mainBundle] pathForResource:@"bds_easr_basic_model" ofType:@"dat"];
    
    [self.asrEventManager setParameter:modelVAD_filepath forKey:BDS_ASR_MODEL_VAD_DAT_FILE];
    
    [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_MODEL_VAD];
    
    //4.开启语义了解
    [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_NLU];
    
    [self.asrEventManager setParameter:@"15361" forKey:BDS_ASR_PRODUCT_ID];
    
    //发送指令：启动识别
    [self.asrEventManager sendCommand:BDS_ASR_CMD_START];
}


#pragma mark --- BDSClientASRDelegate
- (void)VoiceRecognitionClientWorkStatus:(int)workStatus obj:(id)aObj
{
    switch (workStatus) {
        case EVoiceRecognitionClientWorkStatusNewRecordData:
        {
            NSLog(@"进入EVoiceRecognitionClientWorkStatusNewRecordData 状态");
            break;
        }
        case EVoiceRecognitionClientWorkStatusStartWorkIng:{
            NSDictionary *logDic = [self parseLogToDic:aObj];
            NSLog(@"开始识别 === %@",logDic);
            [SVProgressHUD showSuccessWithStatus:@"开始识别"];
            
            [self onStartWorking];
            break;
        }
        case EVoiceRecognitionClientWorkStatusStart: {
            [self printLogTextView:@"CALLBACK: detect voice start point.\n"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusEnd: {
            [self printLogTextView:@"CALLBACK: detect voice end point.\n"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusFlushData: {
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: partial result - %@.\n\n", [self getDescriptionForDic:aObj]]];
            break;
        }
        case EVoiceRecognitionClientWorkStatusFinish: {
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: final result - %@.\n\n", [self getDescriptionForDic:aObj]]];
            if (aObj) {
                //                self.resultTextView.text = [self getDescriptionForDic:aObj];
                
                NSLog(@"系统的最终得到的录音:%@",[self getDescriptionForDic:aObj]);
                [SVProgressHUD showSuccessWithStatus:[self getDescriptionForDic:aObj]];
                if (self.voiceReco) {
                    self.voiceReco([self getDescriptionForDic:aObj]);
                }
            }

            break;
        }
        case EVoiceRecognitionClientWorkStatusMeterLevel: {
            break;
        }
        case EVoiceRecognitionClientWorkStatusCancel: {
            [self printLogTextView:@"CALLBACK: user press cancel.\n"];
            [self onEnd];
            break;
        }
        case EVoiceRecognitionClientWorkStatusError: {
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: encount error - %@.\n", (NSError *)aObj]];
            [self onEnd];
            break;
        }
        case EVoiceRecognitionClientWorkStatusLoaded: {
            [self printLogTextView:@"CALLBACK: offline engine loaded.\n"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusUnLoaded: {
            [self printLogTextView:@"CALLBACK: offline engine unLoaded.\n"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkThirdData: {
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: Chunk 3-party data length: %lu\n", (unsigned long)[(NSData *)aObj length]]];
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkNlu: {
            NSString *nlu = [[NSString alloc] initWithData:(NSData *)aObj encoding:NSUTF8StringEncoding];
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: Chunk NLU data: %@\n", nlu]];
            NSLog(@"%@", nlu);
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkEnd: {
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: Chunk end, sn: %@.\n", aObj]];
            //            if (!self.longSpeechFlag) {
            //                [self onEnd];
            //            }
            break;
        }
        case EVoiceRecognitionClientWorkStatusFeedback: {
            NSDictionary *logDic = [self parseLogToDic:aObj];
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK Feedback: %@\n", logDic]];
            break;
        }
        case EVoiceRecognitionClientWorkStatusRecorderEnd: {
            [self printLogTextView:@"CALLBACK: recorder closed.\n"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusLongSpeechEnd: {
            [self printLogTextView:@"CALLBACK: Long Speech end.\n"];
            [self onEnd];
            break;
        }
        default:
            break;
    }
}

//开始识别的一些操作
- (void)onStartWorking {
    
}

//语音识别结束的操作
- (void)onEnd {
    
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
    return @"noting";
}

- (void)printLogTextView:(NSString *)logString
{
    NSLog(@"打印log===%@",logString);
}
@end
