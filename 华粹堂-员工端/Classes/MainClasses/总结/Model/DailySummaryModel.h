//
//  DailySummaryModel.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/1.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailySummaryModel : NSObject
/*id */
@property (nonatomic, copy) NSString *e_id;
/*名字 */
@property (nonatomic, copy) NSString *e_name;
/*是否完成*/
@property (nonatomic, copy) NSString *is_finished; //0 - 未完成  1 － 已完成
/* 内容 */
@property (nonatomic, copy) NSString *contenet;

@property (nonatomic, copy) NSString *workSummaryId;
@end
