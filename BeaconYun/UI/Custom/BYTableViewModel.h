//
//  BYTableViewModel.h
//  BeaconYun
//
//  Created by SACRELEE on 2/23/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BYCellModel.h"
#import "BYSectionModel.h"


@class UITableView, UITableViewCell, BYCellModel;

typedef void(^CommonBlock)( UITableView *tableView, NSIndexPath *indexpath);
typedef BYCellModel *(^ModelForIndexpath)( NSIndexPath *indexpath);

static NSString const *sTitle = @"title";
static NSString const *sLogoName = @"logo";
static NSString const *sDetail = @"detail";

@interface BYTableViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, copy) CommonBlock cellSelect;
@property (nonatomic, copy) ModelForIndexpath cellModel;
@property (nonatomic, strong, nonnull) BYSectionModel *globalSectionModel;   // this property or the method below you must choose one.

- (void)setModel:(nullable BYSectionModel *)sm forSection:(NSInteger)section;

- (nullable NSString *)getDetailText;

@end
