//
//  NewsDetailCell.m
//  lingdaozhe
//
//  Created by aliviya on 16/7/8.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "NewsDetailCell.h"
#import "ModelMessage.h"
@implementation NewsDetailCell
+(NewsDetailCell *)cellWithIdentify:(NSString *)identify tableview:(UITableView *)tableview{
    NewsDetailCell *cell =  [tableview dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell  = [[[NSBundle mainBundle] loadNibNamed:@"NewsDetailCell" owner:self options:nil] lastObject];
        
        [cell addUnderlineWithLeftMargin:0];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
     self.lblMessageContent.verticalAlignment = VerticalAlignmentMiddle;
    self.lblMessageContent.font = FONT_TEXTSIZE_LargeMid;
    self.lblMessageContent.textColor = COLOR_Black;
    self.lblCreateDate.textColor = COLOR_darkGray;
}
-(void)loadData:(id)model{
    if(model){
        ModelMessage *msg = (ModelMessage *)model;
       
        self.lblMessageContent.text = [UtilString getNoNilString:msg.messageContent];
        NSString *string = [UtilString dateStringDetailWithIntevel:msg.sentTimestamp];
        self.lblCreateDate.text = string;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)cellHeight{
    return 79;
}
@end
