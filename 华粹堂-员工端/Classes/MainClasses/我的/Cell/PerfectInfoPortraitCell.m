//
//  PerfectInfoPortraitCell.m
//  WaterMan
//
//  Created by liqiang on 15/12/25.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import "PerfectInfoPortraitCell.h"
#import "MWPhotoBrowser.h"
#import "AppDelegate.h"

@interface PerfectInfoPortraitCell()<MWPhotoBrowserDelegate>
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (nonatomic, strong) NSMutableArray *photos;
@end

@implementation PerfectInfoPortraitCell


- (MWPhotoBrowser *)photoBrowser
{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.showLongPress = YES;
        _photoBrowser.displayActionButton = NO;
        _photoBrowser.displayNavArrows = YES;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = NO;
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
        [_photoBrowser setCurrentPhotoIndex:0];
    }
    
    return _photoBrowser;
}

- (UINavigationController *)photoNavigationController
{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (PerfectInfoPortraitCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"PerfectInfoPortraitCell";
    PerfectInfoPortraitCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[PerfectInfoPortraitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *label = [[UILabel alloc] init];
    label.font = FONT_TEXTSIZE_Big;
    label.textColor = COLOR_Black;
    label.text = @"头像";
    [self.contentView addSubview:label];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"touxiang"];
    iconImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"advance"];
    [self.contentView addSubview:arrowImageView];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_LineViewColor;
    [self.contentView addSubview:lineView];
    
    label.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(150);
    
    arrowImageView.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(label)
    .widthIs(11)
    .heightIs(20);
    

    iconImageView.sd_layout
    .rightSpaceToView(arrowImageView,10)
    .centerYEqualToView(label)
    .heightIs(60)
    .widthIs(60);
    iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(0.5);
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickIcon)];
    [iconImageView addGestureRecognizer:tap];
}

- (void)didClickIcon
{
    NSLog(@"查看大图");
    
    self.photos = [NSMutableArray arrayWithArray:@[[MWPhoto photoWithImage:self.iconImageView.image]]];
    
//    AppDelegate *dele = APPDELEGATE;
//    if ([[LDZDataManager sharedManager] isHasEnterprice])
//    {
//        [dele.qiyeTabBar presentViewController:self.photoNavigationController animated:YES completion:nil];
//    }
//    else
//    {
//        [dele.pingTaiTabBar presentViewController:self.photoNavigationController animated:YES completion:nil];
//    }
}

#pragma mark -
#pragma mark ================= MWPhotoBrowserDelegate =================
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count)
    {
        return [self.photos objectAtIndex:index];
    }
    
    return nil;
}


@end
