//
//  UIColor+GradientPoints.m
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import "UIColor+GradientPoints.h"

@implementation UIColor (GradientPoints)

+ (NSArray *)numberOfColors:(NSInteger)number betweenColor:(UIColor *)colorA otherColor:(UIColor *)colorB{
    //Color A components
   const CGFloat * colorAComponents = CGColorGetComponents(colorA.CGColor);
    CGFloat redA = colorAComponents [0];
    CGFloat greenA = colorAComponents [1];
    CGFloat blueA = colorAComponents [2];
    CGFloat alphaA = CGColorGetAlpha(colorA.CGColor);

    //Color B components
    const CGFloat * colorBComponents = CGColorGetComponents(colorB.CGColor);
    CGFloat redB = colorBComponents [0];
    CGFloat greenB = colorBComponents [1];
    CGFloat blueB = colorBComponents [2];
    CGFloat alphaB = CGColorGetAlpha(colorB.CGColor);
    
    //New Colors
    NSMutableArray *colors = [NSMutableArray array];
    for (int i = 0; i <= number; i++) {
        CGFloat percentOnGradient = (1/(CGFloat)number) * i;
        CGFloat newColorRed = redA + percentOnGradient * (redB - redA);
        CGFloat newColorGreen = greenA + percentOnGradient * (greenB - greenA);
        CGFloat newColorBlue = blueA + percentOnGradient * (blueB - blueA);
        CGFloat newColorAlpha = alphaA + percentOnGradient * (alphaB - alphaA);
        UIColor *newColor = [UIColor colorWithRed:newColorRed green:newColorGreen blue:newColorBlue alpha:newColorAlpha];
        [colors addObject:newColor];
    }
    return [NSArray arrayWithArray:colors];
}

@end
