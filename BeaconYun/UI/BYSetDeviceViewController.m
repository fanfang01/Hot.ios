//
//  BYSettingDeviceViewController.m
//  BeaconYun
//
//  Created by SACRELEE on 2/28/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYSetDeviceViewController.h"
#import "BYCommonTools.h"
#import "BYTableViewModel.h"
#import <Masonry.h>

@interface BYSetDeviceViewController ()

@property (nonatomic, strong) BYSectionModel *sectionModel;

@property (nonatomic, strong) BYTableViewModel *tvModel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BYSetDeviceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initGUI];
    
}

- (void)initGUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = NSLocalizedString(@"Name this device", nil);
    self.view.backgroundColor = [BYCommonTools colorWithRgb:@"#eeeeee"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Save", nil) style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonClick:)];
    
    _sectionModel = [[BYSectionModel alloc]init];
    _sectionModel.rowHeight = 40.f;
    _sectionModel.rowAtitude = 1;
    _sectionModel.headerHeight = 10.f;
    
    // set tableview model
    _tvModel = [[BYTableViewModel alloc]init];
    _tvModel.globalSectionModel = _sectionModel;
    _tvModel.cellModel = ^( NSIndexPath *indexpath){
        BYCellModel *cm = [[BYCellModel alloc]init];
        cm.type = CellModelTypeInput;
        cm.title = NSLocalizedString(@"Device Name", nil);
        cm.detailText = NSLocalizedString(@"Default", nil);
        return cm;
    };
    
    
    // set tableview
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64.f);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];

    _tableView.delegate = _tvModel;
    _tableView.dataSource = _tvModel;
    _tableView.backgroundColor = [BYCommonTools colorWithRgb:@"#eeeeee"];
    _tableView.scrollEnabled = NO;
    _tableView.allowsSelection = NO;

}


- (void)saveButtonClick:(UIButton *)sender
{
    _module.name = [_tvModel getDetailText];
}


- (void)didReceiveMemoryWarning
{
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
