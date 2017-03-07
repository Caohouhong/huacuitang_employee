//
//  GenderPickerView.h
//  WaterMan
//
//  Created by liqiang on 15/11/13.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import "BaseView.h"

@protocol GenderPickerViewDelegate <NSObject>

- (void)ensureWithGender:(NSString *)gender;

@end

@interface GenderPickerView : BaseView

@property (nonatomic, weak) id<GenderPickerViewDelegate> delegate;

- (void)showMyPicker;
- (void)showMyPickerWithIsMan:(BOOL)isMan;

@end
