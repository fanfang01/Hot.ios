//
//  ColorPickerView.h
//  BeaconYun
//
//  Created by SACRELEE on 4/26/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(NSString *byteString);

@interface ColorPickerView : UIView

@property (copy) CompletionBlock completionBlock;


@end
