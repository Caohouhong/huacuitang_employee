//
//  TiaoLiDetailView2.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/26.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TiaoLiDetailView2.h"
#import "TiaoliOnceCellView.h"
@interface TiaoLiDetailView2 (){
    
    NSString *LiLiaoStr;
    NSString *feedBackStr;
}
@end

@implementation TiaoLiDetailView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = COLOR_BackgroundColor;
        [self initView];
        
    }
    return self;
}

- (void)initView
{
    UIView *topHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    topHoldView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topHoldView];
    
    TiaoliOnceCellView *topPlanCell = [[TiaoliOnceCellView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    topPlanCell.leftNameLabel.text = @"到店理疗配合情况：";
    topPlanCell.rightButton.hidden = YES;
    [topHoldView addSubview:topPlanCell];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = COLOR_BackgroundColor;
    
    UIButton *selectBtn0 = [self creatBtnWithTitle:@"不选" andTag:10000];
    UIButton *selectBtn1 = [self creatBtnWithTitle:@"差" andTag:10001];
    UIButton *selectBtn2 = [self creatBtnWithTitle:@"一般" andTag:10002];
    UIButton *selectBtn3 = [self creatBtnWithTitle:@"较好" andTag:10003];
    UIButton *selectBtn4 = [self creatBtnWithTitle:@"好" andTag:10004];

    [topHoldView sd_addSubviews:@[selectBtn0,selectBtn1,selectBtn2,selectBtn3,selectBtn4,dividerLine1,dividerView]];
    
    selectBtn0.sd_layout
    .leftEqualToView(topHoldView).offset(15)
    .topSpaceToView(topPlanCell,10)
    .widthIs((ScreenWidth - 50)/5)
    .heightIs(30);
    
    selectBtn1.sd_layout
    .leftSpaceToView(selectBtn0,5)
    .topEqualToView(selectBtn0)
    .widthRatioToView(selectBtn0,1)
    .heightRatioToView(selectBtn0,1);
    
    selectBtn2.sd_layout
    .leftSpaceToView(selectBtn1,5)
    .topEqualToView(selectBtn0)
    .widthRatioToView(selectBtn0,1)
    .heightRatioToView(selectBtn0,1);
    
    selectBtn3.sd_layout
    .leftSpaceToView(selectBtn2,5)
    .topEqualToView(selectBtn0)
    .widthRatioToView(selectBtn0,1)
    .heightRatioToView(selectBtn0,1);
    
    selectBtn4.sd_layout
    .leftSpaceToView(selectBtn3,5)
    .topEqualToView(selectBtn0)
    .widthRatioToView(selectBtn0,1)
    .heightRatioToView(selectBtn0,1);
    
    dividerLine1.sd_layout
    .leftEqualToView(topHoldView)
    .bottomEqualToView(topHoldView).offset(-10)
    .widthRatioToView(topHoldView,1)
    .heightIs(1);
    
    dividerView.sd_layout
    .leftEqualToView(topHoldView)
    .bottomEqualToView(topHoldView)
    .widthRatioToView(topHoldView,1)
    .heightIs(10);
    
    /*******************/
    
    UIView *bottomHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 90)];
    bottomHoldView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomHoldView];
    
    TiaoliOnceCellView *topSuggesCell = [[TiaoliOnceCellView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    topSuggesCell.leftNameLabel.text = @"客户综合反馈：";
    topSuggesCell.rightButton.hidden = YES;
    [bottomHoldView addSubview:topSuggesCell];
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_LineViewColor;
    
    UIView *dividerView2 = [[UIView alloc] init];
    dividerView2.backgroundColor = COLOR_BackgroundColor;
    
    UIButton *adviceBtn0 = [self creatBtnWithTitle:@"不太满意" andTag:20000];
    UIButton *adviceBtn1 = [self creatBtnWithTitle:@"一般" andTag:20001];
    UIButton *adviceBtn2 = [self creatBtnWithTitle:@"较满意" andTag:20002];
    UIButton *adviceBtn3 = [self creatBtnWithTitle:@"很满意" andTag:20003];
    
    [bottomHoldView sd_addSubviews:@[adviceBtn0,adviceBtn1,adviceBtn2,adviceBtn3,dividerLine2,dividerView2]];
    
    adviceBtn0.sd_layout
    .leftEqualToView(bottomHoldView).offset(15)
    .topSpaceToView(topSuggesCell,10)
    .widthIs((ScreenWidth - 45)/4)
    .heightIs(30);
    
    adviceBtn1.sd_layout
    .leftSpaceToView(adviceBtn0,5)
    .topEqualToView(adviceBtn0)
    .widthRatioToView(adviceBtn0,1)
    .heightRatioToView(adviceBtn0,1);
    
    adviceBtn2.sd_layout
    .leftSpaceToView(adviceBtn1,5)
    .topEqualToView(adviceBtn0)
    .widthRatioToView(adviceBtn0,1)
    .heightRatioToView(adviceBtn0,1);
    
    adviceBtn3.sd_layout
    .leftSpaceToView(adviceBtn2,5)
    .topEqualToView(adviceBtn0)
    .widthRatioToView(adviceBtn0,1)
    .heightRatioToView(adviceBtn0,1);
    
    dividerLine2.sd_layout
    .leftEqualToView(bottomHoldView)
    .bottomEqualToView(bottomHoldView).offset(-10)
    .widthRatioToView(bottomHoldView,1)
    .heightIs(1);
    
    dividerView2.sd_layout
    .leftEqualToView(bottomHoldView)
    .bottomEqualToView(bottomHoldView)
    .widthRatioToView(bottomHoldView,1)
    .heightIs(10);

}

- (UIButton *)creatBtnWithTitle:(NSString *)title andTag:(int)tag {
    
    UIButton *selectBtn = [[UIButton alloc] init];
    selectBtn.layer.cornerRadius = 2;
    selectBtn.layer.borderWidth = 1;
    selectBtn.tag = tag;
    selectBtn.selected = NO;
    selectBtn.layer.borderColor = COLOR_LightGray.CGColor;
    selectBtn.titleLabel.font = SYSTEM_FONT_(15);
    [selectBtn setTitle:title forState:UIControlStateNormal];
    [selectBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    [selectBtn setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return selectBtn;
}

- (void)buttonAction:(UIButton *)btn
{
    
    if (btn.tag < 15000){ //第一组
    
      for(int i = 0; i < 5; i ++){
        if (btn.tag == 10000+i){
            btn.selected = YES;
            btn.layer.borderColor = COLOR_Text_Blue.CGColor;
            [btn setBackgroundColor:COLOR_BG_DARK_BLUE];
            continue;//结束本次循环
        }
          UIButton *button = (UIButton *)[self viewWithTag:10000 + i];
          button.selected = NO;
          button.layer.borderColor = COLOR_LightGray.CGColor;
          [button setBackgroundColor:[UIColor whiteColor]];
    }
        
      
        
    }else { //第二组
        
        for(int i = 0; i < 4; i ++){
            if (btn.tag == 20000+i){
                btn.selected = YES;
                btn.layer.borderColor = COLOR_Text_Blue.CGColor;
                [btn setBackgroundColor:COLOR_BG_DARK_BLUE];
                continue;//结束本次循环
            }
            UIButton *button = (UIButton *)[self viewWithTag:20000 + i];
            button.selected = NO;
            button.layer.borderColor = COLOR_LightGray.CGColor;
            [button setBackgroundColor:[UIColor whiteColor]];
      }
   }
    
    [self changeLiLiaoSelectWithTag:(int)btn.tag];
    
    if (self.selectBlock){
        self.selectBlock(LiLiaoStr,feedBackStr);
    }
}
//到店理疗配合（-100,0,60,100整数字）对应字符串   null：不选  -100：较差  0：一般  60：较好100：好

//客户综合反馈（1-4整数） 1：不太满意 2：一般 3：较满意 4：很满意
- (void)changeLiLiaoSelectWithTag:(int)tag{

    switch (tag) {
        case 10000:
            LiLiaoStr = nil;
            break;
        case 10001:
            LiLiaoStr = @"-100";
            break;
        case 10002:
            LiLiaoStr = @"0";
            break;
        case 10003:
            LiLiaoStr = @"60";
            break;
        case 10004:
            LiLiaoStr = @"-100";
            break;
        case 20000:
            feedBackStr = @"-100";
            break;
        case 20001:
            feedBackStr = @"-100";
            break;
        case 20002:
            feedBackStr = @"-100";
            break;
        case 20003:
            feedBackStr = @"-100";
            break;
        default:
            break;
    }
}

@end
