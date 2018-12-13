//
//  BCNavigationController.h
//  BeaconYun
//
//  Created by SACRELEE on 2/23/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemPushedBlock)();

@interface BYNavigationController : UINavigationController


- (void)addLeftItem:(UIBarButtonItem *)item push:(ItemPushedBlock)handler;

- (void)addRightItem:(UIBarButtonItem *)item push:(ItemPushedBlock)handler;


@end
