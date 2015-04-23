//
//  MenuItem.h
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (copy, nonatomic) void (^action)();

@end
