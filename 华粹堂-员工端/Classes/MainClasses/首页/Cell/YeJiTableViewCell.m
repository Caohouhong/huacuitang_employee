//
//  YeJiTableViewCell.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "YeJiTableViewCell.h"

@implementation YeJiTableViewCell

+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"YeJiTableViewCell";
    YeJiTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[YeJiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
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
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"充卡业绩";
    nameLabel.font = TFont(13.0);
    
    UILabel *numLabel = [[UILabel alloc]init];
    numLabel.text = @"1000.0";
    numLabel.font = TFont(18.0);
    numLabel.textColor = [UIColor redColor];
    self.numLabel = numLabel;
    
    [self.contentView sd_addSubviews:@[nameLabel, numLabel]];
    
    nameLabel.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,20)
    .widthIs(ScreenWidth).heightIs(20);
    
    numLabel.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(nameLabel,15)
    .widthIs(ScreenWidth).heightIs(25);
}

-(void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    [super setFrame:frame];
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
