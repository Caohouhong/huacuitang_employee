//
//  MainTwoTypeCell.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MainTwoTypeCellButton) {
    MainTwoTypeCellButton1      = 0,
    MainTwoTypeCellButton2      = 1,
    MainTwoTypeCellButton3      = 2,
    MainTwoTypeCellButton4      = 3,
    MainTwoTypeCellButton5      = 4,
    MainTwoTypeCellButton6      = 5,
};

@protocol MainTwoTypeCellDelegate <NSObject>

- (void)mianTwoTypeCellButtonClickWithTag:(int)tag;

@end

@interface MainTwoTypeCell : UITableViewCell

@property (nonatomic, strong) ModelMember *model;

@property (nonatomic, weak) id <MainTwoTypeCellDelegate> delegate;

+ (MainTwoTypeCell *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) UILabel *label1;
@property (nonatomic, weak) UILabel *label2;
@property (nonatomic, weak) UILabel *label3;
@property (nonatomic, weak) UILabel *label4;
@property (nonatomic, weak) UILabel *label5;
@property (nonatomic, weak) UILabel *label6;

@end
