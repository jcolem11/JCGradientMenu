//
//  UIColor+GradientPoints.h
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GradientPoints)

+ (NSArray*)numberOfColors:(NSInteger)number betweenColor:(UIColor*)colorA otherColor:(UIColor*)colorB;

@end
