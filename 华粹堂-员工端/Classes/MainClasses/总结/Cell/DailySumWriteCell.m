//
//  DailySumWriteCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "DailySumWriteCell.h"
@interface DailySumWriteCell()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel; //title
@end

@implementation DailySumWriteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self initView];
    }
    
    return self;
}

+ (DailySumWriteCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"DailySumWriteCell";
    DailySumWriteCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[DailySumWriteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)initView
{
    UIView *topHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 75)];
    topHoldView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topHoldView];
    
    UIView *textViewHoldView = [[UIView alloc] init];
    textViewHoldView.backgroundColor = [UIColor whiteColor];
    [topHoldView addSubview:textViewHoldView];
    
    _topTextView = [[UITextView alloc] init];
    _topTextView.placeholder = @"请填写总体评价";
    _topTextView.backgroundColor = [UIColor whiteColor];
    _topTextView.placeholderColor = COLOR_LightGray;
    _topTextView.font = SYSTEM_FONT_(14);
    _topTextView.textColor = COLOR_Gray;
    _topTextView.delegate = self;
    [textViewHoldView addSubview:_topTextView];
    
//    UIButton *upBtn = [[UIButton alloc] init];
//    [upBtn setBackgroundImage:[UIImage imageNamed:@"arrow_up_25x14"] forState:UIControlStateNormal];
//    [upBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [topHoldView addSubview:upBtn];
//    
//    UIButton *downBtn = [[UIButton alloc] init];
//    [downBtn setBackgroundImage:[UIImage imageNamed:@"arrow_down_25x14"] forState:UIControlStateNormal];
//    [downBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [topHoldView addSubview:downBtn];
    
    textViewHoldView.sd_layout
    .leftEqualToView(topHoldView)
    .topSpaceToView(topHoldView,0)
    .widthIs(ScreenWidth)
    .heightIs(75);
    
    _topTextView.sd_layout
    .leftEqualToView(textViewHoldView).offset(15)
    .topEqualToView(textViewHoldView).offset(5)
    .rightEqualToView(textViewHoldView).offset(-15)
    .bottomEqualToView(textViewHoldView).offset(-5);
    
//    upBtn.sd_layout
//    .rightEqualToView(topHoldView).offset(-2)
//    .topEqualToView(textViewHoldView).offset(10)
//    .widthIs(18)
//    .heightIs(10);
//    
//    downBtn.sd_layout
//    .rightEqualToView(upBtn)
//    .bottomEqualToView(textViewHoldView).offset(-10)
//    .widthIs(18)
//    .heightIs(10);
}

//- (void)buttonAction:(UIButton *)button
//{
//    
//}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.block){
        self.block(textView.text);
    }
}
@end
