//
//  BianJiTiaoLiCell_3.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "BianJiTiaoLiCell_3.h"
#import "StarScoreView.h"

@interface BianJiTiaoLiCell_3 ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UITextView *textView1;
@property (nonatomic, weak) UITextView *textView2;
@property (nonatomic, strong)  StarScoreView *starView1;
@property (nonatomic, strong)  StarScoreView *starView2;
@end

@implementation BianJiTiaoLiCell_3


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (BianJiTiaoLiCell_3 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"BianJiTiaoLiCell_3";
    BianJiTiaoLiCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[BianJiTiaoLiCell_3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = HEXCOLOR(0x333333);
    label.text = @"调理类型:   元气灸";
    [self.contentView addSubview:label];
    self.label = label;
    
    UILabel *shuoLabel = [[UILabel alloc]init];
    shuoLabel.text = @"调理说明:";
    shuoLabel.font = TFont(13);
    shuoLabel.textColor = HEXCOLOR(0x333333);
    [self.contentView addSubview:shuoLabel];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.font = [UIFont systemFontOfSize:14];
    textView.text = @"实打实大打算打算打算打算打打打算的";
    textView.layer.borderColor = HEXCOLOR(0x666666).CGColor;
    textView.layer.borderWidth = 0.5;
    textView.userInteractionEnabled = NO;
    [self.contentView addSubview:textView];
    self.textView1 = textView;
    
    UILabel *xingLabel = [[UILabel alloc]init];
    xingLabel.text = @"客户统合反馈:";
    xingLabel.font = TFont(13);
    xingLabel.textColor = HEXCOLOR(0x333333);
    [self.contentView addSubview:xingLabel];
    
    StarScoreView * starScroreViewA = [[StarScoreView alloc] initWithFrame:CGRectMake(ScreenWidth/2, 200, 120, 30) isEditable:NO ensembleStar:NO starNum:4];
    [self.contentView addSubview:starScroreViewA];
    self.starView1 = starScroreViewA;
    starScroreViewA.scoreblock = ^(CGFloat scoreNumber){
        NSLog(@"点了%.f个星星", scoreNumber);
    };

    UILabel *shuoLabel2 = [[UILabel alloc]init];
    shuoLabel2.text = @"居家养生落实情况:";
    shuoLabel2.font = TFont(13);
    shuoLabel2.textColor = HEXCOLOR(0x333333);
    [self.contentView addSubview:shuoLabel2];
    
    UITextView *textView2 = [[UITextView alloc] init];
    textView2.font = [UIFont systemFontOfSize:14];
    textView2.text = @"大家好我叫TSSSSSSSSSS";
    textView2.layer.borderColor = HEXCOLOR(0x666666).CGColor;
    textView2.layer.borderWidth = 0.5;
    textView2.userInteractionEnabled = NO;
    [self.contentView addSubview:textView2];
    self.textView2 = textView2;
    
    UILabel *xingLabel2 = [[UILabel alloc]init];
    xingLabel2.text = @"居家养生落实反馈:";
    xingLabel2.font = TFont(13);
    xingLabel2.textColor = HEXCOLOR(0x333333);
    [self.contentView addSubview:xingLabel2];
    
    StarScoreView * starScroreViewB = [[StarScoreView alloc] initWithFrame:CGRectMake(ScreenWidth/2, 400, 120, 30) isEditable:NO ensembleStar:NO starNum:4];
    [self.contentView addSubview:starScroreViewB];
    self.starView2 = starScroreViewB;
    starScroreViewB.scoreblock = ^(CGFloat scoreNumber){
        NSLog(@"点了%.f个星星", scoreNumber);
    };
    
    label.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .widthIs(200).heightIs(15);
    
    shuoLabel.sd_layout
    .topSpaceToView(label,15)
    .leftEqualToView(label)
    .rightSpaceToView(self.contentView,10)
    .heightIs(15);
    
    textView.sd_layout
    .topSpaceToView(shuoLabel,10)
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .heightIs(120);
    
    xingLabel.sd_layout
    .topSpaceToView(textView,20)
    .leftEqualToView(label)
    .heightIs(15);
    [xingLabel setSingleLineAutoResizeWithMaxWidth:150];
    
//    starScroreViewA.sd_layout
//    .leftSpaceToView(xingLabel,10)
//    .centerYEqualToView(xingLabel)
//    .widthIs(200).heightIs(40);
    
    shuoLabel2.sd_layout
    .topSpaceToView(xingLabel,20)
    .leftEqualToView(label)
    .rightSpaceToView(self.contentView,10)
    .heightIs(15);
    
    textView2.sd_layout
    .topSpaceToView(shuoLabel2,10)
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .heightIs(120);
    
    xingLabel2.sd_layout
    .topSpaceToView(textView2,20)
    .leftEqualToView(label)
    .heightIs(15);
    [xingLabel2 setSingleLineAutoResizeWithMaxWidth:150];

}

-(void)setModel:(ModelTrackManage *)model {
    _model = model;
    
    self.label.text = [NSString stringWithFormat:@"调理类型:   %@",model.dialectics_program];
    self.textView1.text = model.other_description;
    self.textView2.text = model.home_health_req;
    
    
    self.starView1.starScore = [model.con_eva integerValue];
    
    self.starView2.starScore = [model.con_home_heal integerValue];

    NSLog(@"---%@-----%@", model.con_eva, model.con_home_heal);
}

//- (void)setStr:(NSString *)str
//{
//    _str = str;
//    
//    self.label.text = str;
//}


@end
