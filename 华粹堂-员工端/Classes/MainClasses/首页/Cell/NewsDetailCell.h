//
//  NewsDetailCell.h
//  lingdaozhe
//
//  Created by aliviya on 16/7/8.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailCell : UITableViewCell
@property(nonatomic,weak) IBOutlet MyVerticalLable *lblMessageContent;
@property(nonatomic,weak) IBOutlet UILabel *lblCreateDate;

+(NewsDetailCell *)cellWithIdentify:(NSString *)identify tableview:(UITableView *)tableview;
-(void)loadData:(id)model;
+(CGFloat)cellHeight;
@end
