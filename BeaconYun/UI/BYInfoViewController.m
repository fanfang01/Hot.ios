//
//  BYInfoViewController.m
//  BeaconYun
//
//  Created by SACRELEE on 3/9/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYInfoViewController.h"
#import "BYCommonMacros.h"
#import <Masonry.h>
#import "BYCommonTools.h"

@interface BYInfoViewController ()

@end

@implementation BYInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGUI];
}

- (void)initGUI
{
    self.view.backgroundColor = [BYCommonTools colorWithRgb:@"#eeeeee"];
    self.title = NSLocalizedString(@"About", nil);
    
    UIImageView *logoView = [[UIImageView alloc]init];
    [self.view addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake( 72.f, 72.f));
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, -sScreenHeight / 5));
    }];
    logoView.image = [UIImage imageNamed:@"Logo"];
    logoView.layer.cornerRadius = 10;
    logoView.layer.masksToBounds = YES;
    
    UILabel *appNameLabel = [[UILabel alloc]init];
    [self.view addSubview:appNameLabel];
    [appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(logoView).offset(-48.f);
        make.right.equalTo(logoView).offset(48.f);
        make.top.equalTo(logoView.mas_bottom).offset(5.f);
        make.height.mas_equalTo(30);
    }];
    appNameLabel.text = NSLocalizedString(@"Minew Lock", nil);
    appNameLabel.textColor = [UIColor blackColor];
    appNameLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *versionLabel = [[UILabel alloc]init];
    [self.view addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(appNameLabel);
        make.right.equalTo(appNameLabel);
        make.top.equalTo(appNameLabel.mas_bottom).offset(5.f);
        make.height.mas_equalTo(30);
    }];
    versionLabel.text = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    versionLabel.textColor = [UIColor grayColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel *copyrightLabel = [[UILabel alloc]init];
    [self.view addSubview:copyrightLabel];
    [copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset( -10.f);
        make.height.mas_equalTo(30);
    }];
    copyrightLabel.text = NSLocalizedString(@"Copyright Minewtech. All Rights Reserved", nil);
    copyrightLabel.textColor = [UIColor grayColor];
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
}

@end
