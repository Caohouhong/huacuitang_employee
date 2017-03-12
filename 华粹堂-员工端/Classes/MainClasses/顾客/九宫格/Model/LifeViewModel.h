//
//  LifeViewModel.h
//  华粹堂-员工端
//
//  Created by baichun on 17/3/2.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LifeViewModel : NSObject
/* 生活作息值 */
@property (nonatomic, copy) NSString *dic_ls_values;
/* 工作情况值*/
@property (nonatomic, copy) NSString *dic_work_values;
/* 压力情绪值 */
@property (nonatomic, copy) NSString *dic_es_values;
/* 饮食状况值 */
@property (nonatomic, copy) NSString *dic_fs_values;
/* 早餐值 */
@property (nonatomic, copy) NSString *dic_bf_values;
/* 口味值 */
@property (nonatomic, copy) NSString *dic_flavor_values;
/* 口感值 */
@property (nonatomic, copy) NSString *dic_texture_values;
/* 饮水情况值 */
@property (nonatomic, copy) NSString *dic_ws_values;
/*饮水情况量值 */
@property (nonatomic, copy) NSString *dic_ws_amount_values;
/* 小便值 */
@property (nonatomic, copy) NSString *dic_piss_values;
/* 小便量值 */
@property (nonatomic, copy) NSString *dic_piss_amount_values;
/* 大便值 */
@property (nonatomic, copy) NSString *dic_faeces_values;
/* 间隔时间 */
@property (nonatomic, copy) NSString *dic_faeces_interval;


@end
