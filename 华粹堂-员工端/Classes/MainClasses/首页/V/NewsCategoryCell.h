//
//  NewsCategoryCell.h
//  lingdaozhe
//
//  Created by aliviya on 16/6/29.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCategoryCell : UITableViewCell

+(NewsCategoryCell *)cellWithIdentify:(NSString *)identify tableview:(UITableView *)tableview;
-(void)loadData:(id)model;
-(void)showRedDot:(BOOL)show;
@end
