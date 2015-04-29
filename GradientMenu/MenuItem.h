//
//  MenuItem.h
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface MenuItem : UIControl

@property (strong, nonatomic) UIFont *font; 
@property (strong, nonatomic) NSString *title;
@property (copy, nonatomic) void (^action)();
@property (assign, nonatomic) BOOL displaying;

-(instancetype)initWithTitle:(NSString *)title action:(void(^)())action;
- (void)setUp; 
@end
