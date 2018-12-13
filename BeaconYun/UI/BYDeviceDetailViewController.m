//
//  BYDeviceDetailViewController.m
//  BeaconYun
//
//  Created by SACRELEE on 3/2/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYDeviceDetailViewController.h"
#import "AdvertiseView.h"

#import "BDSEventManager.h"
#import "BDSASRDefines.h"
#import "BDSASRParameters.h"
#import "BDSWakeupDefines.h"
#import "BDSWakeupParameters.h"
#import "BDRecognizerViewController.h"

//#error "请在官网新建应用，配置包名，并在此填写应用的 api key, secret key, appid(即appcode)"
const NSString* API_KEY = @"tyiwdzbYQ9GTmfaGPTqAuXtB";
const NSString* SECRET_KEY = @"ooDetcOCZyUyTYdtWpsXgG4iw3zih1aH";
const NSString* APP_ID = @"15058256";

@interface BYDeviceDetailViewController ()<BDSClientASRDelegate,BDSClientWakeupDelegate>
@property (nonatomic, strong) AdvertiseView *advertiseView;


@property (nonatomic, strong) MinewModuleAPI *api;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (strong, nonatomic) BDSEventManager *asrEventManager;
@property (strong, nonatomic) BDSEventManager *wakeupEventManager;

@end

@implementation BYDeviceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    // Do any additional setup after loading the view.

    
    [self initView];
    
    //    [self initCore];//开始语音识别
    
    //唤醒服务开启
    [self configWakeupClient];
    [self startWakeup];//开始唤醒


}

- (void)initData {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"模式",@"强度加",@"强度减",@"加热", nil];
    }
}

- (void)initView {
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backImg.image = [[UIImage imageNamed:@"all_background"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:backImg];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.advertiseView];
    
}


- (AdvertiseView *)advertiseView
{
    if (!_advertiseView) {
        _advertiseView = [[AdvertiseView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        __weak BYDeviceDetailViewController *weakSelf = self;
        _advertiseView.buttonBlock = ^(NSInteger index) {
            __strong BYDeviceDetailViewController *strongSelf = weakSelf;
            
            
        };
    }
    return _advertiseView;
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

- (void)dealloc {
    [self stopWakeup];
}

- (void)stopWakeup {
    [self.wakeupEventManager sendCommand:BDS_WP_CMD_STOP];
}

- (void)voiceRecogButtonHelper
{
    //    [self configFileHandler];
    [self.asrEventManager setDelegate:self];
    [self.asrEventManager setParameter:nil forKey:BDS_ASR_AUDIO_FILE_PATH];
    [self.asrEventManager setParameter:nil forKey:BDS_ASR_AUDIO_INPUT_STREAM];
    [self.asrEventManager sendCommand:BDS_ASR_CMD_START];
    [self onInitializing];
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
            }
            //            if (!self.longSpeechFlag) {
            //                [self onEnd];
            //            }
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
            [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_NEED_CACHE_AUDIO];
            [self.asrEventManager setParameter:aObj forKey:BDS_ASR_OFFLINE_ENGINE_TRIGGERED_WAKEUP_WORD];
            [self voiceRecogButtonHelper];
            
            [self voiceToAdvertise:key];
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

#pragma mark --- 语音发送广播
//后续 还可以更精准一点过滤   语音发送广播
- (void)voiceToAdvertise:(NSString *)key {
    NSMutableArray *keyArr = [self getALLKeys];
    NSString *recordKey = @"";
    for (NSString *okey in keyArr) {
        if ([okey containsString:key] || [key containsString:okey]) {
            recordKey = okey;
            NSInteger index = [keyArr indexOfObject:recordKey];
            if (index >= 0) {
                //开始广播
                //                _currentIndex = index;
                if (index == 10) {//fast
                    _currentIndex ++;
                    self.advertiseView.selectedIndex = _currentIndex;
                }else if (index == 11) {//slow
                    _currentIndex --;
                    self.advertiseView.selectedIndex = _currentIndex;
                }else if (index == 12) {
                    _is_on = !_is_on;
                    [self.advertiseView.onSwitch setOn:_is_on];
                }
                [self sendData:index];
                
                break;
            }
            
        }
    }
}


- (NSMutableArray *)getALLKeys {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *dic in _commandAray) {
        NSString *str = dic[@"key"];
        [tempArr addObject:str];
    }
    return tempArr;
}

//唤醒的初始化操作
- (void)onInitializing
{
    
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
    return nil;
}

- (void)printLogTextView:(NSString *)logString
{
    NSLog(@"打印log===%@",logString);
}

@end
