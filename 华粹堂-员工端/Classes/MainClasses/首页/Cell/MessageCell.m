//
//  MessageCell.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/12/2.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"MessageCell";
    MessageCell *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

-(void)initView {
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"default"];
    imageView.hidden = YES;
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = TFont(18.0);
    //nameLabel.text = @"通知";
    self.nameLabel = nameLabel;
    
    UILabel *SubLabel = [[UILabel alloc]init];
    SubLabel.font = TFont(13.0);
    SubLabel.textColor = [UIColor grayColor];
    //SubLabel.text = @"新通知";
    self.SubLabel = SubLabel;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = backviewColor;
    
    [self.contentView sd_addSubviews:@[imageView, nameLabel, SubLabel,lineView]];
    
    
    imageView.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,10)
    .widthIs(50).heightIs(50);
    imageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    nameLabel.sd_layout
    .leftSpaceToView(imageView,10)
    .topSpaceToView(self.contentView,10)
    .widthIs(100).heightIs(25);
    
    SubLabel.sd_layout
    .leftSpaceToView(imageView,10)
    .bottomSpaceToView(self.contentView,10)
    .widthIs(100).heightIs(20);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .heightIs(0.5);
    
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
