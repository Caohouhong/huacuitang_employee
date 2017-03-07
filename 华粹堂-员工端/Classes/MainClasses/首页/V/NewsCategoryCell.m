//
//  NewsCategoryCell.m
//  lingdaozhe
//
//  Created by aliviya on 16/6/29.
//  Copyright © 2016年 bckj. All rights reserved.
//






//---------------------------------------------------------------
//
//       imgvRedDot    lblMessageName       lblMessageDate
// imgvImage           lblMessageContent
//
//
//
//---------------------------------------------------------------
#import "NewsCategoryCell.h"
#import "TYAttributedLabel.h"
#import "ModelMessage.h"
#import "EaseConvertToCommonEmoticonsHelper.h"

@interface NewsCategoryCell()
{
    UILabel *lblMessageName;
//    TYAttributedLabel *lblMessageContent;
    UILabel *lblMessageContent;
    UILabel *lblMessageDate;
    
    UIImageView *imgvImage;
    UIImageView *imgvRedDot;
    float hMargin;
    float vMargin;
    
}

@end
@implementation NewsCategoryCell
+(NewsCategoryCell *)cellWithIdentify:(NSString *)identify tableview:(UITableView *)tableview{
    NewsCategoryCell *cell =  [tableview dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[NewsCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell addUnderlineWithLeftMargin:0];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        hMargin = 8;
        vMargin = 13;
        [self drawView];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)drawView{
    //msg
    imgvImage = [UIImageView createImageViewWithFrame:CGRectMake(hMargin, vMargin, 55, 55)  backgroundColor:nil image:nil];
    imgvImage.layer.cornerRadius = 5.0;
    imgvImage.layer.masksToBounds = YES;
    [self.contentView addSubview:imgvImage];
    imgvRedDot = [UIImageView createImageViewWithFrame:CGRectMake(hMargin+50, vMargin-5, 9, 9)  backgroundColor:nil image:nil];
    imgvRedDot.image = [UIImage imageNamed:@"redDot"];
    [self.contentView addSubview:imgvRedDot];
    
    float orginx =CGRectGetMaxX(imgvImage.frame)+10;
    lblMessageName = [UILabel createLabelWithFrame:CGRectMake(orginx, vMargin, ScreenWidth -orginx - 70-2*hMargin, 20) backgroundColor:[UIColor clearColor] textColor:COLOR_Black font:FONT_TEXTSIZE_Big textalignment:NSTextAlignmentLeft text:@""];
    [self.contentView addSubview:lblMessageName];
    
    lblMessageDate = [UILabel createLabelWithFrame:CGRectMake(ScreenWidth - 150 -hMargin, vMargin+2, 150, 16) backgroundColor:[UIColor clearColor] textColor:COLOR_darkGray font:FONT_TEXTSIZE_Mid textalignment:NSTextAlignmentRight text:@""];
    [self.contentView addSubview:lblMessageDate];
    float orginy = CGRectGetMaxY(lblMessageName.frame);
    orginy+=5;
    
    lblMessageContent = [[UILabel alloc] init];
    lblMessageContent.font = FONT_TEXTSIZE_Mid;
    lblMessageContent.textColor = COLOR_darkGray;
    [self.contentView addSubview:lblMessageContent];
    
    lblMessageContent.sd_layout
    .leftEqualToView(lblMessageName)
    .rightEqualToView(lblMessageName)
    .bottomEqualToView(imgvImage)
    .heightIs(18);
    
//    lblMessageContent = [[TYAttributedLabel alloc] init];
//    lblMessageContent.backgroundColor = [UIColor redColor];
//    lblMessageContent.textColor = COLOR_darkGray;
//    lblMessageContent.numberOfLines = 2;
//    lblMessageContent.linesSpacing = 0.5;
//    lblMessageContent.font = FONT_TEXTSIZE_Mid;
//    lblMessageContent.verticalAlignment = VerticalAlignmentTop;
//    [self.contentView addSubview:lblMessageContent];
//    imgvRedDot.hidden = YES;
    
    
}
///* 消息所属分组-课程推荐 */
//public static final short GROUP_TYPE_COURSE_RECOMMEND = 1;
///* 消息所属分组-活动通知  */
//public static final short GROUP_TYPE_TEACHER_NEWS = 2;
///* 消息所属分组-老师动态 */
//public static final short GROUP_TYPE_ACTIVITY_NOTICE = 3;
///* 消息所属分组-学院公告 */
//public static final short GROUP_TYPE_ENTERPRISE_PUBLIC_NOTICE = 4;
//
-(void)loadData:(id)model{
    if ([model isKindOfClass:[ModelMessage class]]) {
        ModelMessage *mod = (ModelMessage *)model;
        
        if (mod.groupType == 0) {
            imgvImage.image = [UIImage imageNamed:@"ic_mess"];
            lblMessageName.text  = @"系统消息";
        }else if (mod.groupType ==1) {
            imgvImage.image = [UIImage imageNamed:@"ic_sysmess"];
            lblMessageName.text = @"满意度调查";
        }
//        else if (mod.groupType ==3) {
//            imgvImage.image = [UIImage imageNamed:@"msg_teacher"];
//            lblMessageName.text = @"老师动态";
//        }else if (mod.groupType ==5) {
//            imgvImage.image = [UIImage imageNamed:@"msg_teacher"];
//            lblMessageName.text = @"社区消息";
//        }
        else{
            imgvImage.image = [UIImage imageNamed:@"msg_college"];
            lblMessageName.text = @"公司公告";
        }
   
        lblMessageDate.text = [UtilString dateStringDetailWithIntevel:mod.sentTimestamp];
        
//        lblMessageName.text = [UtilString getNoNilString:mod.linkParamsName];
        
        lblMessageContent.text = [EaseConvertToCommonEmoticonsHelper convertToSystemEmoticons:[UtilString getNoNilString:mod.messageContent]];
        
        if(mod.isViewed ==1){
            imgvRedDot.hidden = YES;
        }else{
            imgvRedDot.hidden = NO;
        }
    
    }

}


-(void)showRedDot:(BOOL)show{
    imgvRedDot.hidden = !show;
}


@end
