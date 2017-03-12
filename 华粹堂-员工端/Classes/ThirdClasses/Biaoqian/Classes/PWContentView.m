//
//  PWContentView.m
//  标签
//
//  Created by DFSJ on 17/1/18.
//  Copyright © 2017年 lihao Horizon. All rights reserved.
//

#import "PWContentView.h"

@implementation PWContentView

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array{

    if (self = [super initWithFrame:frame]) {
        
        
       
        for (int i = 0; i < array.count; i ++)
        {
            //        Area *are = cell_Array[i];
            
            NSString *name = array[i];
            static UIButton *recordBtn =nil;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            
            CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
            
            CGFloat BtnW = rect.size.width + 20;
            CGFloat BtnH = rect.size.height + 10;
            btn.layer.masksToBounds = YES;
            
            
            
            [btn.layer setBorderWidth:1];//设置边界的宽度
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = COLOR_LightGray.CGColor;
            //            btn.layer.cornerRadius = BtnH/2;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (i == 0)
            {
                btn.frame =CGRectMake(10, 10, BtnW, BtnH);
            }
            else{
                
                CGFloat yuWidth = self.frame.size.width - 20 -recordBtn.frame.origin.x -recordBtn.frame.size.width;
                
                if (yuWidth >= rect.size.width) {
                
                    btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 10, recordBtn.frame.origin.y, BtnW, BtnH);
                }else{
                    
                    btn.frame =CGRectMake(10, recordBtn.frame.origin.y+recordBtn.frame.size.height+10, BtnW, BtnH);
                }
                
            }
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:name forState:UIControlStateNormal];
            [self addSubview:btn];
            
            NSLog(@"btn.frame.origin.y  %f", btn.frame.origin.y);
            self.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20,CGRectGetMaxY(btn.frame)+10);
            recordBtn = btn;
            
            btn.tag = 100 + i;

            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }


    return self;

}

-(void) BtnClick:(UIButton *)sender{

    __weak typeof(self) weakSelf = self;
    
    if (weakSelf.btnBlock) {
        
        weakSelf.btnBlock(sender.tag);
    }

}

-(void) btnClickBlock:(BtnBlock)btnBlock{

    self.btnBlock = btnBlock;

}


@end
