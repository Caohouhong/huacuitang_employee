//
//  TSMainThreeTypeCell.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "TSMainThreeTypeCell.h"

@implementation TSMainThreeTypeCell


+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"TSMainThreeTypeCell";
    TSMainThreeTypeCell *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[TSMainThreeTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
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
    //iconimageView.backgroundColor = [UIColor redColor];
    iconimageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconimageView = iconimageView;
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = FONT_TEXTSIZE_LargeMid;
    self.nameLabel = nameLabel;
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.font = TFont(13.0);
    rightLabel.textColor = [UIColor grayColor];
    self.rightLabel = rightLabel;
    
    [self.contentView sd_addSubviews:@[iconimageView,nameLabel,rightLabel]];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"advance"];
    [self.contentView addSubview:arrowImageView];
    
    iconimageView.sd_layout
    .leftSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(30).heightIs(30);
    
    nameLabel.sd_layout
    .leftSpaceToView(iconimageView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(100).heightIs(25);
    
    rightLabel.sd_layout
    .rightSpaceToView(self.contentView,25)
    .centerYEqualToView(self.contentView)
    .heightIs(25);
    [rightLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    arrowImageView.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(11)
    .heightIs(20);
    
}

-(void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
