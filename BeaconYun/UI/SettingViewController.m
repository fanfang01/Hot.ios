//
//  SettingViewController.m
//  BeaconYun
//
//  Created by 樊芳 on 2018/12/4.
//  Copyright © 2018 MinewTech. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (nonatomic, strong ) NSMutableArray *dataArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initView];
    
}

- (void) initView {
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [backImg setImage:[UIImage imageNamed:@"all_background"]];
    [self.view addSubview:backImg];
    
    CGFloat buttonWidth = (ScreenWidth-40)/2;
    CGFloat buttonHeight = 50;

    for (NSInteger i=0; i<_dataArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setFrame:CGRectMake(10+(buttonWidth+20)*(i%2), 100+(buttonHeight+10)*(i/2), buttonWidth, buttonHeight)];

        [button setTitle:_dataArray[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        button.backgroundColor = [UIColor lightGrayColor];
        button.layer.cornerRadius = 10;
        button.layer.masksToBounds = YES;
        [self.view addSubview:button];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) initData {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"模式1",@"模式2",@"模式3",@"模式4",@"模式5",@"模式6",@"模式7",@"模式8",@"模式9",@"模式10", nil];
    }
}

- (void)buttonClick:(UIButton *)btn {
    NSInteger index = btn.tag - 100;
    
    NSString *stateString = _dataArray[index];
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"你已设置%@",stateString]];
}
@end
