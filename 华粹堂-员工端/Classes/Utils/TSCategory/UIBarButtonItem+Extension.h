//
//  UIBarButtonItem+Extension.h
//  诚信平台
//
//  Created by 唐硕 on 16/7/12.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)



+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)targe
                      action:(SEL)action;


+(instancetype)itemWithImage:(NSString *)image target:(id)target action:(SEL)action;

+(instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
