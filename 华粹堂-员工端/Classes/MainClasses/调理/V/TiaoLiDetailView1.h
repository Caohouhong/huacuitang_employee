//
//  TiaoLiDetailView1.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/26.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TiaoLiDetailView1Block)(NSString *);

@interface TiaoLiDetailView1 : UIView
@property (nonatomic, strong) UILabel *titleLabel; //title
@property (nonatomic, strong) UITextView *topTextView;

@property (nonatomic, strong) NSString *trackTime;

@property (nonatomic, copy) TiaoLiDetailView1Block textBlock;

@end
