//
//  ModelMessage.h
//  lingdaozhe
//
//  Created by aliviya on 16/6/29.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelMessage : NSObject
//public static final short RECEIVERTYPE_MEMBER = 1;
//
///* 状态-未推送 */
//public static final short STATE_NEW = 1;
///* 状态-已推送 */
//public static final short STATE_SENT = 2;
///* 状态-删除 */
//public static final short STATE_DELETED = 9;
//
//
///* 消息所属分组-课程推荐 */
//public static final short GROUP_TYPE_COURSE_RECOMMEND = 1;
///* 消息所属分组-老师动态 */
//public static final short GROUP_TYPE_TEACHER_NEWS = 2;
///* 消息所属分组-活动通知 */
//public static final short GROUP_TYPE_ACTIVITY_NOTICE = 3;
///* 消息所属分组-学院公告 */
//public static final short GROUP_TYPE_ENTERPRISE_PUBLIC_NOTICE = 4;
//
///* 消息指向实体-课程 */
//public static final short LINK_TYPE_COURSE = 1;
///* 消息指向实体-专题 */
//public static final short LINK_TYPE_TOPIC = 2;
///* 消息指向实体-老师*/
//public static final short LINK_TYPE_TEACHER = 3;
///* 消息指向实体-新闻*/
//public static final short LINK_TYPE_NEWS = 3;
///* 消息指向实体-通知*/
//public static final short LINK_TYPE_NOTICE = 3;
///* 消息指向实体-考试*/
//public static final short LINK_TYPE_EXAM = 3;
///* 消息指向实体-链接*/
//public static final short LINK_TYPE_HTTP = 3;
///* 消息指向实体-无指向*/
//public static final short LINK_TYPE_NONE = 99;

///* 消息指向实体-课程 */
//public static final short LINK_TYPE_COURSE = 1;
///* 消息指向实体-老师*/
//public static final short LINK_TYPE_TEACHER = 2;
///* 消息指向实体-专题 */
//public static final short LINK_TYPE_TOPIC = 3;
///* 消息指向实体-新闻*/
//public static final short LINK_TYPE_NEWS = 4;
///* 消息指向实体-通知*/
//public static final short LINK_TYPE_NOTICE = 5;
///* 消息指向实体-考试*/
//public static final short LINK_TYPE_EXAM = 6;
///* 消息指向实体-链接*/
//public static final short LINK_TYPE_HTTP = 7;
///* 消息指向实体-无指向*/
//public static final short LINK_TYPE_NONE = 99;

/* 内容模板-老师动态--老师有了新课程 */
//public static final String CONTENTTEMPLATE_TEACHER_ADD_COURSE = "{teacherName}的课程《{courseName}》上架啦，快来学习吧！";

/* 消息标识 */
@property (nonatomic, assign) int messageId;
/* 所属分组，取值见常量 */
@property (nonatomic, assign) short groupType;
/* 状态，取值见常量 */
@property (nonatomic, assign) short state;
/* 消息指向实体，取值见常量 */
@property (nonatomic, assign) short linkType;
/* 消息指向实体参数 */
@property (nonatomic, copy) NSString * linkParams;
/* 消息指向实体参数的名称 */
@property (nonatomic, copy) NSString * linkParamsName;
/* 消息标题(预留) */
@property (nonatomic, copy) NSString * messageTitle;
/* 消息内容，如果是老师动态消息，内容参照模板，替换参数 */
@property (nonatomic, copy) NSString * messageContent;
/* 创建消息的学院标识 */
@property (nonatomic, assign) int createEnterpriseId;
/* 创建时戳 */
@property (nonatomic, assign) int createdTimestamp;
/* 消息已读还是未读 已读 ＝ 1 未读 ＝ 0 */
@property (nonatomic, assign) int isViewed;
/* 创建人标识 */
@property (nonatomic, assign) int creatorId;
/* 创建人姓名 */
@property (nonatomic, copy) NSString * creatorName;
/* 推送时戳 */
@property (nonatomic, assign) int sentTimestamp;
/* 删除时戳 */
@property (nonatomic, assign) int deletedTime;

/*冗余*/
/*消息发布范围中的学院标识集合*/
@property (nonatomic, retain) NSArray * enterpriseIds;
/*多个消息接收者标识 */
@property (nonatomic, retain) NSArray * receverIds;
@end
