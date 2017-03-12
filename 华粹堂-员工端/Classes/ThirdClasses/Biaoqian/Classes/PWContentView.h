//
//  PWContentView.h
//  标签
//
//  Created by DFSJ on 17/1/18.
//  Copyright © 2017年 lihao Horizon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BtnBlock)(NSInteger index);

@interface PWContentView : UIView

@property (nonatomic,copy) BtnBlock btnBlock;

-(void) btnClickBlock:(BtnBlock) btnBlock;

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array;

@end
