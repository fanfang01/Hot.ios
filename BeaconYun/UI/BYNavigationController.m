//
//  BCNavigationController.m
//  BeaconYun
//
//  Created by SACRELEE on 2/23/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYNavigationController.h"
#import "BYCustomManager.h"


@interface BYNavigationController ()

@end

@implementation BYNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        [self preSettings];
    }
    return self;
}

- (void)preSettings
{
    NSDictionary *settings = [BYCustomManager getCustomNavSettings:@"Common"];
    self.navigationBar.backgroundColor = [BYCommonTools colorWithRgb:settings[@"backgroundColor"]];
    self.navigationItem.leftBarButtonItem.tintColor = [BYCommonTools colorWithRgb:@"#eeeeee"];
    self.navigationItem.rightBarButtonItem.tintColor = [BYCommonTools colorWithRgb:@"#eeeeee"];
    self.navigationBar.tintColor = [BYCommonTools colorWithRgb:@"#000000"];
}

- (void)addLeftItem:(UIBarButtonItem *)item push:(ItemPushedBlock)handler
{
   
}

- (void)addRightItem:(UIBarButtonItem *)item push:(ItemPushedBlock)handler
{
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
