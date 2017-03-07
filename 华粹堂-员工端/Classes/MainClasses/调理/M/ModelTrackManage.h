//
//  ModelTrackManage.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelTrackManage : NSObject

#define TRACKTYPE_MORE 0;		// 复诊跟踪
#define TRACKTYPE_Track  1;		//调理跟踪
#define TRACKTYPE_PROBLEM  2;		// 问题跟踪
#define TRACKTYPE_OTHER  3;		//其它跟踪


#define STATE_UNWRITE  1;	  //未填写
#define STATE_REVIEWING 2;	  //审核中
#define STATE_REVIEWED  3;		//已审核

/*编号 */
@property (nonatomic, copy) NSString *sid;
/*客户编号 */
@property (nonatomic, copy) NSString *c_id;
/*填写人编号 */
@property (nonatomic, copy) NSString *e_id;
/*门店编号 */
@property (nonatomic, copy) NSString *s_id;
/*跟踪类型 */
@property (nonatomic, copy) NSString *track_type;
/*跟踪日期/调理日期/项目日期 */
@property (nonatomic, copy) NSString *track_date;
/*制定人类别 */
@property (nonatomic, copy) NSString *maker_type;
/*方案制定人 */
@property (nonatomic, copy) NSString *makers;
/*客户主诉 */
@property (nonatomic, copy) NSString *customers_complained;
/*咨询辩证/调理项目/其它项目 */
@property (nonatomic, copy) NSString *dialectics_program;
/*调理方案 */
@property (nonatomic, copy) NSString *d_program_detail;
/*家居养生要求 */
@property (nonatomic, copy) NSString *home_health_req;
/*其它说明/调理说明/项目说明 */
@property (nonatomic, copy) NSString *other_description;
/*家居养生评价 */
@property (nonatomic, copy) NSString *con_home_heal;
/*调理评价*/
@property (nonatomic, copy) NSString *con_eva;
/*院长审核编号 */
@property (nonatomic, copy) NSString *dean_id;
/*院长审核日期 */
@property (nonatomic, copy) NSString *dean_check_date;
/*院长审核意见*/
@property (nonatomic, copy) NSString *dean_check_view;
/*专家审核编号 */
@property (nonatomic, copy) NSString *expert_id;
/*专家审核日期 */
@property (nonatomic, copy) NSString *expert_check_date;
/*专家审核意见*/
@property (nonatomic, copy) NSString *expert_check_view;
/*问题级别 */
@property (nonatomic, copy) NSString *dic_pl_id;
/*问题客户说明*/
@property (nonatomic, copy) NSString *problem_description;
/*店面了解情况*/
@property (nonatomic, copy) NSString *sus;
/*dicwentiId */
@property (nonatomic, copy) NSString *dicwentiId;
/*exEva*/
@property (nonatomic, copy) NSString *exEva;
/*状态*/
@property (nonatomic, copy) NSString *state;
/*uuid(与回访关联)*/
@property (nonatomic, copy) NSString *uuid;
/*最后修改时戳*/
@property (nonatomic, copy) NSString *lastModified;

@property (nonatomic ,copy) NSString *customerMobilePhone;



/*冗余*/
/*客户头像*/
@property (nonatomic, copy) NSString *portrait;
/*客户姓名*/
@property (nonatomic, copy) NSString *customerName;
/*员工姓名*/
@property (nonatomic, copy) NSString *employeeName;
/*调理日期转化的时间戳*/
@property (nonatomic, copy) NSString *trackDateTime;
/*客户类别*/
@property (nonatomic, copy) NSString *dic_libie_id;
/*服务器时间戳*/
@property (nonatomic, copy) NSString *serverTime;
/*店名*/
@property (nonatomic, copy) NSString *shopName;


@end
