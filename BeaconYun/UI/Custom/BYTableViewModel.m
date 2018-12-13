//
//  BYTableViewModel.m
//  BeaconYun
//
//  Created by SACRELEE on 2/23/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "BYTableViewModel.h"
#import <UIKit/UIKit.h>
#import "BYCellModel.h"
#import "BYSectionModel.h"
#import "BYCommonMacros.h"

@interface BYTableViewModel ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableDictionary *sectionDict;

@end

@implementation BYTableViewModel
{
    NSString *_detailText;
}

#pragma mark *************************************Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _sectionDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}

#pragma mark **************************************Logic

- (void)setModel:(nullable BYSectionModel *)sm forSection:(NSInteger)section;
{
    if (!section)
        _globalSectionModel = sm;
    
    [_sectionDict setValue:sm forKey:[NSString stringWithFormat:@"%ld", (long)section]];
}

- (BYSectionModel *)modelForSection:(NSInteger)section
{
    BYSectionModel *sm = [_sectionDict valueForKey:[NSString stringWithFormat:@"%ld",(long)section]];
    
    if (sm)
        return sm;
    
    if (_globalSectionModel)
        return _globalSectionModel;
    
    BYLog(@"error! null model for section:%ld", (long)section);
    
    return nil;
}

- (id)customObjectForSection:(NSInteger)section class:(Class)cls header:(BOOL)header
{
    BYSectionModel *sm = [self modelForSection:section];
    
    id obj = header? sm.header: sm.footer;
    
    if ([obj isKindOfClass:cls])
        return obj;
    
    return nil;
}

- (nullable NSString *)getDetailText
{
    return _detailText;
}



#pragma mark **************************************Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_sectionDict.allKeys.count > 1)
        return _sectionDict.allKeys.count;
    
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (_cellSelect)
        _cellSelect( tableView, indexPath);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.imageView setImage:[UIImage imageNamed:@"Device"]];
    }
    
    BYCellModel *cm = _cellModel( indexPath);
    [self resetCell:cell.contentView];

    switch (cm.type)
    {
        case CellModelTypeCommon:
        {
            if (cm.logoName.length)
                cell.imageView.image = [UIImage imageNamed:cm.logoName];
            
            cell.textLabel.text = cm.title;
            NSLog(@"cm.title===%@",cm.title);
            cell.detailTextLabel.text = cm.detailText;
            cell.detailTextLabel.textColor = [UIColor grayColor];
            
        }
            break;
        case CellModelTypeInput:
        {
            UITextField *textField = [[UITextField alloc]init];
            textField.delegate = self;
            textField.frame = CGRectMake( 20, 0, sScreenWidth - 40, [self modelForSection:indexPath.section].rowHeight);
            textField.text = cm.detailText;
            textField.font = [UIFont systemFontOfSize:14.f];
            textField.textColor = [UIColor blackColor];
            textField.tag = 100;
            textField.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:textField];
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake( 20, 0, sScreenWidth / 3.0 - 20, [self modelForSection:indexPath.section].rowHeight);
            label.text = cm.title;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14.f];
            [cell.contentView addSubview:label];
        }
            break;
            
        default:
            break;
    }
    
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self modelForSection:section].rowAtitude;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self modelForSection:indexPath.section].rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self customObjectForSection:section class:[UIView class] header:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self customObjectForSection:section class:[UIView class] header:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self modelForSection:section].headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [self modelForSection:section].footerHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [self customObjectForSection:section class:[NSString class] header:NO];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self customObjectForSection:section class:[NSString class] header:YES];
}

- (void)resetCell:(UIView *)contentView
{
    for ( UIView * v in contentView.subviews)
    {
        if (v.tag > 99)
            [v removeFromSuperview];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _detailText = textField.text;
}



@end
