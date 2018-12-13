//
//  BYDeviceViewController.m
//  BeaconYun
//
//  Created by SACRELEE on 2/23/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYBindDeviceViewController.h"
#import "BYTableViewModel.h"
#import "BYCommonMacros.h"
#import <Masonry.h>
#import "BYCellModel.h"
#import "BYHeaderView.h"
#import "BYSectionModel.h"
#import "BYHeaderView.h"
#import "BYScanDeviceViewController.h"
#import "BYDeviceDetailViewController.h"
#import "BYCommonTools.h"
#import "MinewModuleManager.h"
#import "MinewModuleAPI.h"
#import "MinewModule.h"


@interface  BYBindDeviceViewController()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BYTableViewModel *tvModel;
@property (nonatomic, strong) BYSectionModel *sectionModel;
@property (nonatomic, strong) MinewModuleManager *manager;
@property (nonatomic, strong) NSArray *bindModules;
@property (nonatomic, assign) BOOL tableViewInitalized;

@end

@implementation BYBindDeviceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initGUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self reloadTableView];
}

- (void)initGUI
{
    self.title = NSLocalizedString(@"BeaconYun", nil);
    self.view.backgroundColor = [BYCommonTools colorWithRgb:@"#eeeeee"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClick:)];

    _sectionModel = [[BYSectionModel alloc]init];
    _sectionModel.rowHeight = 60.f;
    _sectionModel.rowAtitude = 0;
    _sectionModel.headerHeight = 40.f;
    BYHeaderView *header = [[BYHeaderView alloc]initWithType:HeaderViewTypeNormal title:NSLocalizedString(@"All Devices", nil)];
    header.tapped = ^(){ BYLog(@"don't touche me, Bitch!");};
    _sectionModel.header = header;
    
    // set tableview model
    _tvModel = [[BYTableViewModel alloc]init];
    _tvModel.globalSectionModel = _sectionModel;
    
    __weak NSArray *weakModules = _bindModules;
    _tvModel.cellModel = ^( NSIndexPath *indexpath){
        
        __strong NSArray *strongModules = weakModules;
        
        MinewModule *module = strongModules[indexpath.row];
        
        BYCellModel *cm = [[BYCellModel alloc]init];
        cm.title = module.name;
        cm.detailText = @"Module Device";
        return cm;
    };
    
    __weak BYBindDeviceViewController *weakSelf = self;
    _tvModel.cellSelect = ^(UITableView *tableView, NSIndexPath *indexPath){
        
//        __strong BYBindDeviceViewController *strongSelf = weakSelf;
//        strongSelf.tableView.userInteractionEnabled = NO;
//        
//        BYDeviceDetailViewController *svc = [[BYDeviceDetailViewController alloc]init];
//        [strongSelf.navigationController pushViewController:svc animated:YES];
//        
//        strongSelf.tableView.userInteractionEnabled = YES;
//        [MinewModuleAPI sharedInstance].lastModule = strongSelf.bindModules[indexPath.row];
    };

    
    // set tableview
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = _tvModel;
    _tableView.dataSource = _tvModel;
    
    _tableViewInitalized = YES;
    [self reloadTableView];
}


- (void)reloadTableView
{
    if (!_tableViewInitalized)  return ;
        
    _bindModules = [MinewModuleManager sharedInstance].bindModules;
    _sectionModel.rowAtitude = _bindModules.count;
    
    
    __weak NSArray *weakModules = _bindModules;
    _tvModel.cellModel = ^( NSIndexPath *indexpath){
        
        __strong NSArray *strongModules = weakModules;
        
        MinewModule *module = strongModules[indexpath.row];
        
        BYCellModel *cm = [[BYCellModel alloc]init];
        cm.title = module.name;
        cm.detailText = @"Module Device";
        return cm;
    };

    [_tableView reloadData];
}


- (void)addButtonClick:(UIBarButtonItem *)sender
{
    BYScanDeviceViewController *svc = [[BYScanDeviceViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}

@end
