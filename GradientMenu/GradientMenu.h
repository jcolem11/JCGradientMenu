//
//  GradientMenu.h
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuItem;

@interface GradientMenu : UIControl

@property (strong, nonatomic) UIColor *startColor;
@property (strong, nonatomic) UIColor *endColor;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *menuTitle;

@end
