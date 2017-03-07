//
//  MainTwoTypeCell.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MainTwoTypeCell.h"

@implementation MainTwoTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (MainTwoTypeCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"MainTwoTypeCell";
    MainTwoTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MainTwoTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *label1_1 = [[UILabel alloc] init];
    label1_1.font = [UIFont systemFontOfSize:14];
    label1_1.textColor = HEXCOLOR(0x333333);
    label1_1.text = @"本月已服务";
    label1_1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label1_1];
    
    UILabel *label2_1 = [[UILabel alloc] init];
    label2_1.font = [UIFont systemFontOfSize:14];
    label2_1.textColor = HEXCOLOR(0x333333);
    label2_1.text = @"本月待服务";
    label2_1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label2_1];
    
    UILabel *label3_1 = [[UILabel alloc] init];
    label3_1.font = [UIFont systemFontOfSize:14];
    label3_1.textColor = HEXCOLOR(0x333333);
    label3_1.text = @"今明日待服务";
    label3_1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label3_1];
    
    UILabel *label4_1 = [[UILabel alloc] init];
    label4_1.font = [UIFont systemFontOfSize:14];
    label4_1.textColor = HEXCOLOR(0x333333);
    label4_1.text = @"本月销售业绩";
    label4_1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label4_1];
    
    UILabel *label5_1 = [[UILabel alloc] init];
    label5_1.font = [UIFont systemFontOfSize:14];
    label5_1.textColor = HEXCOLOR(0x333333);
    label5_1.text = @"本月消耗业绩";
    label5_1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label5_1];
    
    UILabel *label6_1 = [[UILabel alloc] init];
    label6_1.font = [UIFont systemFontOfSize:14];
    label6_1.textColor = HEXCOLOR(0x333333);
    label6_1.text = @"今日目标";
    label6_1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label6_1];
    
    UILabel *label1_2 = [[UILabel alloc] init];
    label1_2.font = [UIFont systemFontOfSize:14];
    label1_2.textColor = HEXCOLOR(0x44b8f6);
    label1_2.text = [NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"serve_count"]];;
    label1_2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label1_2];
    self.label1 = label1_2;
    
    UILabel *label2_2 = [[UILabel alloc] init];
    label2_2.font = [UIFont systemFontOfSize:14];
    label2_2.textColor = HEXCOLOR(0x44b8f6);
    label2_2.textAlignment = NSTextAlignmentCenter;
    label2_2.text = [NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"money_in_sum"]];
    [self.contentView addSubview:label2_2];
    self.label2 = label2_2;
    
    UILabel *label3_2 = [[UILabel alloc] init];
    label3_2.font = [UIFont systemFontOfSize:14];
    label3_2.textColor = HEXCOLOR(0xe43140);
    label3_2.textAlignment = NSTextAlignmentCenter;
    label3_2.text = [NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"money_out_sum"]];
    [self.contentView addSubview:label3_2];
    self.label3 = label3_2;
    
    UILabel *label4_2 = [[UILabel alloc] init];
    label4_2.font = [UIFont systemFontOfSize:14];
    label4_2.textColor = HEXCOLOR(0x44b8f6);
    label4_2.textAlignment = NSTextAlignmentCenter;
    label4_2.text = [NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"money_out_sum"]];
    [self.contentView addSubview:label4_2];
    self.label4 = label4_2;
    
    UILabel *label5_2 = [[UILabel alloc] init];
    label5_2.font = [UIFont systemFontOfSize:14];
    label5_2.textColor = HEXCOLOR(0x44b8f6);
    label5_2.textAlignment = NSTextAlignmentCenter;
    label5_2.text = [NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"money_out_sum"]];
    [self.contentView addSubview:label5_2];
    self.label5 = label5_2;
    
    UILabel *label6_2 = [[UILabel alloc] init];
    label6_2.font = [UIFont systemFontOfSize:14];
    label6_2.textColor = HEXCOLOR(0x44b8f6);
    label6_2.textAlignment = NSTextAlignmentCenter;
    label6_2.text = [NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"money_out_sum"]];
    [self.contentView addSubview:label6_2];
    self.label6 = label6_2;
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = backviewColor;
    //HEXCOLOR(0x666666);
    [self.contentView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = backviewColor;
    //HEXCOLOR(0x666666);
    [self.contentView addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = backviewColor;
    //HEXCOLOR(0x666666);
    [self.contentView addSubview:lineView3];
    
    /**按钮点击**/
    UIButton *button1 = [[UIButton alloc] init];
    button1.tag = MainTwoTypeCellButton1;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] init];
    button2.tag = MainTwoTypeCellButton2;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] init];
    button3.tag = MainTwoTypeCellButton3;
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] init];
    button4.tag = MainTwoTypeCellButton4;
    [button4 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button4];
    
    UIButton *button5 = [[UIButton alloc] init];
    button5.tag = MainTwoTypeCellButton5;
    [button5 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button5];
    
    UIButton *button6 = [[UIButton alloc] init];
    button6.tag = MainTwoTypeCellButton6;
    [button6 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button6];
    
    label1_2.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,15)
    .widthIs((ScreenWidth - 1)/3)
    .heightIs(20);
    
    label1_1.sd_layout
    .leftEqualToView(label1_2)
    .topSpaceToView(label1_2,10)
    .widthRatioToView(label1_2,1)
    .heightRatioToView(label1_2,1);
    
    lineView1.sd_layout
    .leftSpaceToView(label1_2,0)
    .topSpaceToView(self.contentView,2)
    .bottomSpaceToView(self.contentView,5)
    .widthIs(1);
    
    label2_2.sd_layout
    .leftSpaceToView(lineView1,0)
    .topEqualToView(label1_2)
    .widthRatioToView(label1_2,1)
    .heightRatioToView(label1_2,1);
    
    label2_1.sd_layout
    .leftEqualToView(label2_2)
    .topSpaceToView(label2_2,10)
    .widthRatioToView(label2_2,1)
    .heightRatioToView(label2_2,1);
    
    lineView2.sd_layout
    .leftSpaceToView(label2_1,0)
    .topSpaceToView(self.contentView,2)
    .bottomSpaceToView(self.contentView,5)
    .widthIs(1);
    
    label3_2.sd_layout
    .leftSpaceToView(lineView2,0)
    .topEqualToView(label1_2)
    .widthRatioToView(label1_2,1)
    .heightRatioToView(label1_2,1);
    
    label3_1.sd_layout
    .leftEqualToView(label3_2)
    .topSpaceToView(label3_2,10)
    .widthRatioToView(label3_2,1)
    .heightRatioToView(label3_2,1);
    
    lineView3.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(label1_1,20)
    .rightSpaceToView(self.contentView,10)
    .heightIs(1);
    
    label4_2.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(lineView3,15)
    .widthIs((ScreenWidth - 1)/3)
    .heightIs(20);
    
    label4_1.sd_layout
    .leftEqualToView(label4_2)
    .topSpaceToView(label4_2,10)
    .widthRatioToView(label4_2,1)
    .heightRatioToView(label4_2,1);
    
    label5_2.sd_layout
    .leftSpaceToView(lineView1,0)
    .topEqualToView(label4_2)
    .widthRatioToView(label4_2,1)
    .heightRatioToView(label4_2,1);
    
    label5_1.sd_layout
    .leftEqualToView(label5_2)
    .topSpaceToView(label5_2,10)
    .widthRatioToView(label5_2,1)
    .heightRatioToView(label5_2,1);
    
    label6_2.sd_layout
    .leftSpaceToView(lineView2,0)
    .topEqualToView(label4_2)
    .widthRatioToView(label4_2,1)
    .heightRatioToView(label4_2,1);
    
    label6_1.sd_layout
    .leftEqualToView(label6_2)
    .topSpaceToView(label6_2,10)
    .widthRatioToView(label6_2,1)
    .heightRatioToView(label6_2,1);
    
    /**按钮**/
    button1.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .widthIs((ScreenWidth - 1)/3)
    .heightIs(170/2);
    
    button2.sd_layout
    .leftEqualToView(label2_1)
    .topEqualToView(self.contentView)
    .widthRatioToView(button1,1)
    .heightRatioToView(button1,1);
    
    button3.sd_layout
    .leftEqualToView(label3_1)
    .topEqualToView(self.contentView)
    .widthRatioToView(button1,1)
    .heightRatioToView(button1,1);
    
    button4.sd_layout
    .leftEqualToView(button1)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(button1,1)
    .heightRatioToView(button1,1);
    
    button5.sd_layout
    .leftEqualToView(button2)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(button1,1)
    .heightRatioToView(button1,1);
    
    button6.sd_layout
    .leftEqualToView(button3)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(button1,1)
    .heightRatioToView(button1,1);
}


//按钮点击
- (void)buttonAction:(UIButton *)button{
    if (self.delegate != nil){
        [self.delegate mianTwoTypeCellButtonClickWithTag:(int)button.tag];
    }
}
@end
