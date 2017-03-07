//
//  EditorTiaoLiCell.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "EditorTiaoLiCell.h"
#import "StarScoreView.h"

@interface EditorTiaoLiCell()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic, weak) UITextField *tiaolabel;
@property (nonatomic, weak) UITextView *textView1;
@property (nonatomic, weak) UITextView *textView2;
@property (nonatomic, strong)  StarScoreView *starView1;
@property (nonatomic, strong)  StarScoreView *starView2;
@end

@implementation EditorTiaoLiCell

+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"EditorTiaoLiCell";
    EditorTiaoLiCell *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[EditorTiaoLiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
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
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = HEXCOLOR(0x333333);
    label.text = @"调理方案";
    [self.contentView addSubview:label];
    
    UILabel *kanlabel = [[UILabel alloc] init];
    kanlabel.font = [UIFont systemFontOfSize:14];
    kanlabel.textColor = [UIColor blueColor];
    kanlabel.text = @"查看";
    kanlabel.userInteractionEnabled = YES;
    [self.contentView addSubview:kanlabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickKanLabel)];
    [kanlabel addGestureRecognizer:tap];
    
    
    UILabel *lilabel = [[UILabel alloc] init];
    lilabel.font = [UIFont systemFontOfSize:13];
    lilabel.textColor = HEXCOLOR(0x333333);
    lilabel.text = @"调理类型:";
    [self.contentView addSubview:lilabel];

    UITextField *textfield = [[UITextField alloc]init];
    textfield.font = TFont(14.0);
    textfield.placeholder = @"输入调理类型";
    textfield.delegate = self;
    textfield.textColor = [UIColor blackColor];
    [self.contentView addSubview:textfield];
    self.tiaolabel = textfield;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:lineView];
    
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
    textView.delegate = self;
    textView.tag = 1;
    [self.contentView addSubview:textView];
    self.textView1 = textView;
    
    UILabel *xingLabel = [[UILabel alloc]init];
    xingLabel.text = @"客户统合反馈:";
    xingLabel.font = TFont(13);
    xingLabel.textColor = HEXCOLOR(0x333333);
    [self.contentView addSubview:xingLabel];
    
    StarScoreView * starScroreViewA = [[StarScoreView alloc] initWithFrame:CGRectMake(ScreenWidth/2, 236, 120, 30) isEditable:YES ensembleStar:YES starNum:4];
    [self.contentView addSubview:starScroreViewA];
    self.starView1 = starScroreViewA;
    starScroreViewA.scoreblock = ^(CGFloat scoreNumber){
        NSLog(@"点了%.f个星星", scoreNumber);
        self.model.con_eva = [NSString stringWithFormat:@"%.f",scoreNumber];
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
    textView2.delegate = self;
    [self.contentView addSubview:textView2];
    self.textView2 = textView2;
    
    UILabel *xingLabel2 = [[UILabel alloc]init];
    xingLabel2.text = @"居家养生落实反馈:";
    xingLabel2.font = TFont(13);
    xingLabel2.textColor = HEXCOLOR(0x333333);
    [self.contentView addSubview:xingLabel2];
    
    StarScoreView * starScroreViewB = [[StarScoreView alloc] initWithFrame:CGRectMake(ScreenWidth/2, 433, 120, 30) isEditable:YES ensembleStar:YES starNum:4];
    [self.contentView addSubview:starScroreViewB];
    self.starView2 = starScroreViewB;
    starScroreViewB.scoreblock = ^(CGFloat scoreNumber){
        NSLog(@"点了%.f个星星", scoreNumber);
        self.model.con_home_heal = [NSString stringWithFormat:@"%.f",scoreNumber];
    };

    label.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .widthIs(100).heightIs(20);
    
    kanlabel.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .heightIs(20);
    [kanlabel setSingleLineAutoResizeWithMaxWidth:80];

    lilabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(label,15)
    .heightIs(15);
    [lilabel setSingleLineAutoResizeWithMaxWidth:100];
    
    textfield.sd_layout
    .leftSpaceToView(lilabel,10)
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(lilabel)
    .heightIs(20);
    
    lineView.sd_layout
    .leftEqualToView(textfield)
    .rightEqualToView(textfield)
    .topSpaceToView(textfield,0).heightIs(1);
    
    shuoLabel.sd_layout
    .topSpaceToView(lilabel,15)
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *toBeStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"--->%@",toBeStr);
    self.model.dialectics_program = toBeStr;
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView {
    if (textView.markedTextRange == nil) {
        if(textView.tag == 1) {
            self.model.other_description = textView.text;
        }else {
            self.model.home_health_req = textView.text;
        }
    }
}


-(void)clickKanLabel {
    if(self.block) {
        self.block();
    }
}


-(void)setModel:(ModelTrackManage *)model {
    _model = model;
    
    self.tiaolabel.text = [NSString stringWithFormat:@"%@",TSTRING_NOT_EMPTY(model.dialectics_program)?model.dialectics_program:@""];
    self.textView1.text = model.other_description;
    self.textView2.text = model.home_health_req;
    
    
    self.starView1.starScore = [model.con_eva integerValue];
    
    self.starView2.starScore = [model.con_home_heal integerValue];
    
    NSLog(@"---%@-----%@", model.con_eva, model.con_home_heal);
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
