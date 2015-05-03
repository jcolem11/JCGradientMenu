//
//  MenuItem.h
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


@protocol MenuItemDelegate <NSObject>

- (void)menuItemPressed; 

@end
@interface MenuItem : UIControl

@property (strong, nonatomic) UIFont *font; 
@property (strong, nonatomic) NSString *title;
@property (copy, nonatomic) void (^action)();
@property (assign, nonatomic) BOOL displaying;
@property (weak, nonatomic) id delegate;

-(instancetype)initWithTitle:(NSString *)title action:(void(^)())action;

@end
