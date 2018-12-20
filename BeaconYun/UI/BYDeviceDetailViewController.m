//
//  BYDeviceDetailViewController.m
//  BeaconYun
//
//  Created by SACRELEE on 3/2/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYDeviceDetailViewController.h"
#import "AdvertiseView.h"
#import "WakeupManager.h"
#import "RecognizeManager.h"

#import "BDSEventManager.h"
#import "BDSASRDefines.h"
#import "BDSASRParameters.h"
#import "BDSWakeupDefines.h"
#import "BDSWakeupParameters.h"
#import "BDRecognizerViewController.h"


@interface BYDeviceDetailViewController ()<BDSClientASRDelegate,BDSClientWakeupDelegate>
@property (nonatomic, strong) AdvertiseView *advertiseView;


@property (nonatomic, strong) MinewModuleAPI *api;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (strong, nonatomic) WakeUpManager *wakeupManager;
@property (strong, nonatomic) RecognizeManager *recognizeManager;

@end

@implementation BYDeviceDetailViewController
{
    NSInteger _currentIndex;
    
    BOOL _is_on;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _api = [MinewModuleAPI sharedInstance];
    [self initData];
    // Do any additional setup after loading the view.

    
    [self initView];
    
    //    [self initCore];//开始语音识别
    
//    //唤醒服务开启
    [self wakeupManager];
//    [self recognizeConfiguration];

    
    //添加检测app进入后台的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    //app启动或者app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];

}

- (void)wakeUpConfiguration {
    _wakeupManager = [WakeUpManager sharedInstance];
    
    [_wakeupManager startWakeup];
}

- (void)recognizeConfiguration {
    _recognizeManager = [RecognizeManager sharedInstance];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_api disconnect:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)applicationDidBecomeActive {
    
//    [self startWakeup];//为了让识别不被停掉
}

- (void) applicationDidEnterBackground {
    
}

- (void)initData {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@{@"title":@"模式",@"command":@"0x03"},
                      @{@"title":@"快点快点",@"command":@"0x04"},
                      @{@"title":@"慢点慢点",@"command":@"0x05"},
                      @{@"title":@"加热",@"command":@"0x06"},
                      nil];
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
            
            [strongSelf sendData:index];
            
        };
    }
    return _advertiseView;
}

- (void)sendData:(NSInteger)index {
    MinewModule *module = self.api.lastModule;
    NSString *commandStr = self.dataArray[index][@"command"];
    
    NSData *data = [MinewCommonTool hexString:commandStr];
    
    NSLog(@"向设备发送的data==%@  commandStr== %@",data,commandStr);
    [module writeData:data hex:NO];
}





@end
