//
//  EditorHuiFangCell2.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/25.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "EditorHuiFangCell2.h"


@interface EditorHuiFangCell2()<UITextViewDelegate>
@property (nonatomic, weak) UITextView *textView1;
@property (nonatomic, weak) UITextView *textView2;

@end
@implementation EditorHuiFangCell2


+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"EditorHuiFangCell";
    EditorHuiFangCell2 *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[EditorHuiFangCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
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
    
    UILabel *huiLabel = [[UILabel alloc]init];
    huiLabel.textColor = HEXCOLOR(0x333333);
    huiLabel.font = TFont(13.0);
    huiLabel.text = @"回访时间:";
    
    UIImageView *arrimage = [[UIImageView alloc]init];
    arrimage.image = [UIImage imageNamed:@"advance"];
    
    UIButton *timeBtn = [[UIButton alloc]init];
    [timeBtn setTitle:@"2016-11-25 >" forState:UIControlStateNormal];
    timeBtn.titleLabel.font = TFont(13.0);
    [timeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [timeBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(clcikTimeBtn) forControlEvents:UIControlEventTouchUpInside];
    self.timeButton = timeBtn;
    
    UILabel *muLabel = [[UILabel alloc]init];
    muLabel.textColor = HEXCOLOR(0x333333);
    muLabel.font = TFont(13.0);
    muLabel.text = @"回访目的:";
    
    UITextView *textView = [[UITextView alloc] init];
    textView.font = [UIFont systemFontOfSize:14];
    textView.text = @"实打实大打算打算打算打算打打打算的";
    textView.layer.borderColor = HEXCOLOR(0x666666).CGColor;
    textView.layer.borderWidth = 0.5;
    textView.tag = 1;
    textView.delegate  = self;
    [self.contentView addSubview:textView];
    self.textView1 = textView;
    
    UILabel *keLabel = [[UILabel alloc]init];
    keLabel.textColor = HEXCOLOR(0x333333);
    keLabel.font = TFont(13.0);
    keLabel.text = @"客户反馈:";
    
    UITextView *textView2 = [[UITextView alloc] init];
    textView2.font = [UIFont systemFontOfSize:14];
    textView2.text = @"大家好我叫TSSSSSSSSSS";
    textView2.layer.borderColor = HEXCOLOR(0x666666).CGColor;
    textView2.layer.borderWidth = 0.5;
    textView2.delegate  = self;
    [self.contentView addSubview:textView2];
    self.textView2 = textView2;
    
    [self.contentView sd_addSubviews:@[huiLabel, timeBtn, muLabel, textView, keLabel,textView2,arrimage]];
    
    huiLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .widthIs(100).heightIs(15);
    
    arrimage.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .heightIs(13).widthIs(9);
    
    timeBtn.sd_layout
    .rightSpaceToView(arrimage,5)
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .heightIs(15);

    muLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(huiLabel,15)
    .widthIs(100).heightIs(15);
    
    textView.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(muLabel,7)
    .leftSpaceToView(self.contentView,10)
    .heightIs(120);
    
    keLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(textView,10)
    .widthIs(100).heightIs(15);
    
    textView2.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(keLabel,7)
    .leftSpaceToView(self.contentView,10)
    .heightIs(120);

}

-(void)textViewDidChange:(UITextView *)textView {
    if (textView.markedTextRange == nil) {
        if(textView.tag == 1) {
            self.model.feedback = textView.text;
        }else {
            self.model.remark = textView.text;
        }
    }
}

-(void)clcikTimeBtn {
    if(self.block) {
        self.block();
    }
}

-(void)setModel:(HuiFangModel *)model {
    _model = model;
    
    self.textView1.text = model.feedback;
    self.textView2.text = model.remark;
    [self.timeButton setTitle:model.visit_time forState:UIControlStateNormal];
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
