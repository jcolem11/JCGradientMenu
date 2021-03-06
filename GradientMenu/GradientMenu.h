//
//  GradientMenu.h
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

@interface GradientMenu : UIControl

@property (assign, nonatomic) NSTimeInterval animationDuration;
@property (strong, nonatomic) UIColor *startColor;
@property (strong, nonatomic) UIColor *endColor;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *itemFont;
@property (strong, nonatomic) NSArray *items;

- (instancetype)initWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor;

@end
