//
//  MyKaModel.h
//  华粹堂-客户端
//
//  Created by 唐硕 on 16/12/1.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyKaModel : NSObject
/*id */
@property (nonatomic, copy) NSString *sid;
/*是否有效 */
@property (nonatomic, copy) NSString *is_valid;
/*商品名称*/
@property (nonatomic, copy) NSString *goods_name;
/*goods_num*/
@property (nonatomic, copy) NSString *goods_num;
/*客户 */
@property (nonatomic, copy) NSString *c_id;
/*余额 */
@property (nonatomic, copy) NSString *balance;
/*类型 */
@property (nonatomic, copy) NSString *type;
/*goods_code */
@property (nonatomic, copy) NSString *goods_code;
/*创建时间 */
@property (nonatomic, copy) NSString *create_datetime;
/*goods_id */
@property (nonatomic, copy) NSString *goods_id;
/*卡号 */
@property (nonatomic, copy) NSString *card_number;
/*goods_price */
@property (nonatomic, copy) NSString *goods_price;
/*技师 */
@property (nonatomic, copy) NSString *e_id;
/*门店 */
@property (nonatomic, copy) NSString * s_id;

/*
 * 冗余
 * */
/*充值总额*/
@property (nonatomic, copy) NSString *totalAmount;


@end
