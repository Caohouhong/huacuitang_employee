//
//  PersonalView.m
//  MyShop
//
//  Created by 唐硕 on 16/10/6.
//  Copyright © 2016年 TS. All rights reserved.
//

#import "PersonalView.h"

@implementation PersonalView

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imagestr:(NSString *)imagestr {
    self = [super initWithFrame:frame];
    if(self) {
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-15, 5, 30, 30)];
        imageview.image = [UIImage imageNamed:imagestr];
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30+7, frame.size.width, 20)];
        titlelab.text = title;
        titlelab.textAlignment = NSTextAlignmentCenter;
        titlelab.tintColor = [UIColor blackColor];
        titlelab.font = TFont(12);
        [self sd_addSubviews:@[imageview, titlelab]];
    
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageurl:(NSString *)imageurl {
    self = [super initWithFrame:frame];
    if(self) {
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-15, 5, 30, 30)];
        [imageview sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:nil];
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30+5, frame.size.width, 20)];
        titlelab.text = title;
        titlelab.textAlignment = NSTextAlignmentCenter;
        titlelab.tintColor = [UIColor blackColor];
        titlelab.font = TFont(13.0);
        [self sd_addSubviews:@[imageview, titlelab]];
        
    }
    return self;

}



@end
