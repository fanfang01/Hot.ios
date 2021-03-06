//
//  BYScanViewController.m
//  BeaconYun
//
//  Created by SACRELEE on 2/24/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYScanDeviceViewController.h"
#import "BYTableViewModel.h"
#import "BYSectionModel.h"
#import "BYHeaderView.h"
#import "BYCommonMacros.h"
#import "BYCellModel.h"
#import <Masonry.h>
#import "BYCommonTools.h"
#import "BYSetDeviceViewController.h"
#import "MinewModuleManager.h"
#import "MinewModule.h"
#import "BYDeviceDetailViewController.h"
#import "MinewModuleAPI.h"
#import "BYInfoViewController.h"
#import "MTPeripheralManager.h"
#import "AdvertiseView.h"
#import "SettingViewController.h"


#define INTERVAL_KEYBOARD 0

@interface BYScanDeviceViewController ()<MinewModuleManagerDelegate,UITextFieldDelegate,CAAnimationDelegate>

@property (nonatomic, strong) BYTableViewModel *tvModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) BYSectionModel *sectionModel;

@property (nonatomic, strong) MinewModuleManager *manager;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *moduleArray;

@property (nonatomic, strong) UIView *noneDeviceView;

@property(nonatomic,strong) NSMutableArray *tempArr ;//存放当前扫描到的设备

@end

// iPhone bind device mac Address
@implementation BYScanDeviceViewController
{
    NSString *_testString;
    NSString *_deviceName;
    UIImageView *_scanBGImageView;
    UILabel *_showLabel;
    UILabel *_titleLabel;

}

static NSInteger scanCount;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scanCount = 0;
    [self initGUI];
    [self initCore];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (scanCount != 0) {
        [_manager stopScan];
        _showLabel.text = @"请点击上方按钮开始扫描";
    }
    scanCount = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if (@available(iOS 11.0, *)) {
//
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}

- (void)initGUI
{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(startToSetup)];

    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backgroundImageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:backgroundImageView];
    
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 60)];
    _titleLabel = hintLabel;

    hintLabel.text = @"使用前请先打开手机蓝牙";
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.textColor = COLOR_RGBA(160, 160, 160, 1);
    [self.view addSubview:hintLabel];
    
    UIImageView *scanBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    scanBGImageView.userInteractionEnabled = NO;
    scanBGImageView.layer.cornerRadius = 50.;
    scanBGImageView.layer.masksToBounds = YES;
    _scanBGImageView = scanBGImageView;
    scanBGImageView.center = CGPointMake(ScreenWidth/2.0, ScreenHeight/2.0);
    scanBGImageView.image = [UIImage imageNamed:@"scan"];
    [self.view addSubview:scanBGImageView];
    
    UIControl *scanControl = [[UIControl alloc] initWithFrame:scanBGImageView.frame];
    [scanControl addTarget:self action:@selector(startToScan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanControl];
    
    UILabel *showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    _showLabel = showLabel;
    
    showLabel.center = CGPointMake(scanBGImageView.center.x, ScreenHeight - 160);
    showLabel.numberOfLines = 0;
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.textColor = COLOR_RGBA(160, 160, 160, 1);
    showLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.view addSubview:showLabel];
    showLabel.text = @"请点击上方按钮开始扫描";
}

#pragma mark ---- 连接搜索成功的Module
- (void)connectToModules:(MinewModule *)module {
    
    MinewModuleAPI *api = [MinewModuleAPI sharedInstance];
    api.lastModule = module;
    
    [api connect:nil completion:^(id result, BOOL keepAlive) {
        if ([((NSDictionary *)result)[@"state"] integerValue])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (scanCount == 0) {
                    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"成功连接设备:%@",module.name]];
                    
                    [self scanSucessSkipToNextVC];
                    scanCount ++;
                }
            });

            return ;
        }

    }];
}

- (void)startToScan {
    [_manager stopScan];
    [_manager startScan];
    [self scanAction];
    
#ifdef debug

#else
#endif
}

#pragma mark --- 动画开始
- (void)scanAction {
    [_scanBGImageView.layer removeAnimationForKey:@"transform"];
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
    theAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,0,1)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0,0,1)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.26, 0,0,1)],
                           nil];
    theAnimation.cumulative = YES;
    theAnimation.duration = 1.5;
    theAnimation.repeatCount = MAXFLOAT;
    theAnimation.removedOnCompletion = YES;
    theAnimation.delegate = self;
    [_scanBGImageView.layer addAnimation:theAnimation forKey:@"transform"];
    
    _showLabel.text = @"开始扫描";
}

- (void)initCore
{
    _manager = [MinewModuleManager sharedInstance];
    _manager.delegaate = self;
//    [_manager startScan];
    [self startToScan];
    
    __weak BYScanDeviceViewController *weakSelf = self;
    _manager.findDevice = ^(MinewModule *module) {
        __strong BYScanDeviceViewController *strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            _showLabel.text = [NSString stringWithFormat:@"扫描到%@",module.name];
            if (scanCount == 0) {
                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"成功扫描到设备%@",module.name]];
                
                //连接搜索的设备
                [strongSelf connectToModules:module];
                
            }
        });
        
    };

    if (_timer)
        [_timer invalidate];
        
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.4 target:self selector:@selector(reloadTableView) userInfo:nil repeats:YES];
    
    [_timer fire];
}

- (void)reloadTableView
{
    _moduleArray = [_manager.allModules copy];
    _sectionModel.rowAtitude = _moduleArray.count;
    
#warning 添加HToy的测试  记录所有的设备
    if (!_tempArr) {
        _tempArr = [NSMutableArray array];
    }
    [_tempArr removeAllObjects];

    for (MinewModule *module in _moduleArray) {
        if ([module.name isEqualToString:@"HToy"]) {
            [_tempArr addObject:module];
        }
    }
    
    if (_tempArr.count>0) {
//        MinewModule *module = [_tempArr firstObject];
        
    }

}

- (void) scanSucessSkipToNextVC {
    
    BYDeviceDetailViewController *detailVC = [[BYDeviceDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [_manager stopScan];
}

- (NSString *)hexStringFromString:(NSString *)string

{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];//16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}



- (void)startToSetup {
    SettingViewController *setVC = [[SettingViewController alloc] init];
    
    [self.navigationController pushViewController:setVC animated:YES];

}

#pragma mark ---- CBManagerDelegate 的回调
- (void)manager:(MinewModuleManager *)manager didChangeModule:(MinewModule *)module linkStatus:(LinkStatus)status {
    switch (status) {
        case LinkStatusConnected:
        {
            if (scanCount == 0) {
                
                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"成功连接上设备:%@",module.name]];
                
                [self scanSucessSkipToNextVC];
                scanCount ++;
                
                //2s后提示消失
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
            
        }
            break;
            
        default:
            break;
    }
}

- (void)infoButtonClick:(UIButton *)sender
{
    BYInfoViewController *bvc = [[BYInfoViewController alloc]init];
    [self.navigationController pushViewController:bvc animated:YES];
}

#pragma mark - animation
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"%@",anim);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%@ | %d",anim,flag);
}
@end
