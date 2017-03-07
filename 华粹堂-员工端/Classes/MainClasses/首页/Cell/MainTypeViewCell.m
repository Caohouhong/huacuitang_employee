//
//  MainTypeViewCell.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MainTypeViewCell.h"


@implementation MainTypeViewCell

+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"MainTypeViewCell";
    MainTypeViewCell *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MainTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    return self;
}

-(void)initViews {
    
    UIImageView *iconimageView = [[UIImageView alloc]init];
    iconimageView.backgroundColor = [UIColor redColor];
    
    UIView *centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor clearColor];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"132";
    nameLabel.font = TFont(13);
    
    UILabel *PhoneLabel = [[UILabel alloc]init];
    PhoneLabel.text = @"123";
    PhoneLabel.font = TFont(11);
    
    UIImageView *arrowimageview = [[UIImageView alloc]init];
    arrowimageview.image = [UIImage imageNamed:@"ic_weixin"];
    
    UIImageView *seximageview = [[UIImageView alloc]init];
    seximageview.image = [UIImage imageNamed:@"boy"];

    [self.contentView sd_addSubviews:@[iconimageView,centerView,nameLabel,PhoneLabel,arrowimageview,seximageview]];
    
    iconimageView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(55).heightIs(55);
    iconimageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    centerView.sd_layout
    .leftSpaceToView(iconimageView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(1).heightIs(0.01);
    
    arrowimageview.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(15).heightIs(20);
    
    seximageview.sd_layout
    .rightSpaceToView(arrowimageview,5)
    .bottomSpaceToView(centerView,5)
    .widthIs(12).heightIs(12);
    
    nameLabel.sd_layout
    .leftSpaceToView(iconimageView,10)
    .bottomSpaceToView(centerView,0)
    .rightSpaceToView(seximageview,5)
    .heightIs(20);
    
    PhoneLabel.sd_layout
    .leftSpaceToView(iconimageView,10)
    .topSpaceToView(centerView,0)
    .rightSpaceToView(seximageview,5)
    .heightIs(20);
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
