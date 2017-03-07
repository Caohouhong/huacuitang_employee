//
//  MyKaXinCell.m
//  华粹堂-客户端
//
//  Created by 唐硕 on 16/12/1.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MyKaXinCell.h"

@interface MyKaXinCell()
@property (nonatomic ,weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@end

@implementation MyKaXinCell

+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"MyKaXinCell";
    MyKaXinCell *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MyKaXinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
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
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"消费";
    nameLabel.font = [UIFont systemFontOfSize:16];
    self.nameLabel = nameLabel;
    
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.text = @"+4426.0";
    priceLabel.font = [UIFont systemFontOfSize:16];
    priceLabel.textColor = [UIColor redColor];
    self.priceLabel = priceLabel;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"2016-09-21 21:00";
    timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel = timeLabel;
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView sd_addSubviews:@[nameLabel, priceLabel, timeLabel,lineV]];
 
    nameLabel.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,15)
    .widthIs(100).heightIs(20);
    
    priceLabel.sd_layout
    .rightSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,15)
    .heightIs(20);
    [priceLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    timeLabel.sd_layout
    .topSpaceToView(nameLabel,10)
    .leftSpaceToView(self.contentView,20)
    .widthIs(200).heightIs(15);
    
    lineV.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .heightIs(0.5);
    
}

-(void)setModel:(MyKaXinModel *)model {
    _model = model;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",[model.in_or_out isEqualToString:@"0"]?@"消费":@"充值"];
    self.timeLabel.text = model.create_datetime;
    if([model.in_or_out isEqualToString:@"0"]) {
        self.priceLabel.text = [NSString stringWithFormat:@"- %.2f",[model.actual_sum floatValue]] ;
    }else {
        self.priceLabel.text = [NSString stringWithFormat:@"+ %.2f",[model.actual_sum floatValue]] ;
    }
    
    
}


//-(void)setFrame:(CGRect)frame {
//    frame.size.height -= 1;
//    
//    [super setFrame:frame];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
