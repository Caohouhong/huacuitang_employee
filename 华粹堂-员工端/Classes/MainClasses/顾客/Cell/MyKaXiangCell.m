//
//  MyKaXiangCell.m
//  华粹堂-客户端
//
//  Created by liqiang on 2016/11/22.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MyKaXiangCell.h"

@interface MyKaXiangCell()
@property (nonatomic, weak) UILabel *label;
@end

@implementation MyKaXiangCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        
        [self drawView];
    }
    
    return self;
}

+ (MyKaXiangCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"MyKaXiangCell";
    MyKaXiangCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MyKaXiangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = HEXCOLOR(0x333333);
    label.text = @"现金卡";
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    self.label = label;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"advance"];
    [self.contentView addSubview:arrowImageView];
    
    arrowImageView.sd_layout
    .rightSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(11)
    .heightIs(20);
    
    label.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(arrowImageView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
}

-(void)setModel:(MyKaModel *)model {
    
    _model =  model;
    
    self.label.text = [NSString stringWithFormat:@"%@ %@",[model.type isEqualToString:@"0"]?@"现金卡":@"商品卡", model.card_number];
    
}


@end
