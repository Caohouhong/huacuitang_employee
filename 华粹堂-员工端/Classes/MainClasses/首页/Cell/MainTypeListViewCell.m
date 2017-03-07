//
//  MainTypeListViewCell.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MainTypeListViewCell.h"

@implementation MainTypeListViewCell


+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"MainTypeListViewCell";
    MainTypeListViewCell *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MainTypeListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
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
    iconimageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconimageView = iconimageView;
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = FONT_TEXTSIZE_LargeMid;
    nameLabel.text = @"123";
    self.nameLabel = nameLabel;
    
    UIImageView *arrowimageview = [[UIImageView alloc]init];
    arrowimageview.image = [UIImage imageNamed:@"advance"];
    self.arrowimageView = arrowimageview;
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.font = FONT_TEXTSIZE_LargeMid;
    self.phoneLabel = phoneLabel;

    [self.contentView sd_addSubviews:@[iconimageView,nameLabel,arrowimageview,phoneLabel]];
    
    iconimageView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(25).heightIs(25);
    
    nameLabel.sd_layout
    .leftSpaceToView(iconimageView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(100).heightIs(25);
    
    arrowimageview.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(11).heightIs(20);
    
    phoneLabel.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
    [phoneLabel setSingleLineAutoResizeWithMaxWidth:200];

}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
