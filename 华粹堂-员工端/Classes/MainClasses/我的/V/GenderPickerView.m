//
//  GenderPickerView.m
//  WaterMan
//
//  Created by liqiang on 15/11/13.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import "GenderPickerView.h"

@interface GenderPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic)  UIPickerView *pickerView;
@property (strong, nonatomic) UIView *maskView;

@property (nonatomic, weak) UIView *backgroundView;

@end

@implementation GenderPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self drawView];
    }
    
    return self;
}

- (void)drawView
{
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.3;
    [self addSubview:maskView];
    [maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 230)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    self.backgroundView = backgroundView;
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 0, 50, 50)];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn1.frame), self.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:229/255. green:229/255. blue:229/255. alpha:1];
    [backgroundView addSubview:line];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, 200)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [backgroundView addSubview:pickerView];
    self.pickerView = pickerView;
}

- (void)showMyPicker
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.frame = CGRectMake(0, self.frame.size.height-230, self.frame.size.width, 230);
    }];
}

- (void)showMyPickerWithIsMan:(BOOL)isMan
{
    if (isMan) {
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
    }else{
        [self.pickerView selectRow:1 inComponent:0 animated:NO];
    }
    
    [self showMyPicker];
}

- (void)hidePickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 230);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *array = @[@"男",@"女"];
    return [array objectAtIndex:row];
}

- (void)ensure
{
    NSArray *array = @[@"男",@"女"];
    NSString *gender = [array objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    
    if ([self.delegate respondsToSelector:@selector(ensureWithGender:)]) {
        [self.delegate ensureWithGender:[NSString stringWithFormat:@"%@",gender]];
    }
    
    [self hidePickerView];
}

@end
