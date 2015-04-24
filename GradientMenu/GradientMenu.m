//
//  GradientMenu.m
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import "GradientMenu.h"
#import "UIColor+GradientPoints.h"
#import "MenuItem.h"

@interface GradientMenu()

@property (strong, nonatomic) NSArray *menuItems;
@property (strong, nonatomic) UIView *backingView;
@property (assign, nonatomic) BOOL expanded;
@property (strong, nonatomic) CAShapeLayer *triangleLayer;

@end

@implementation GradientMenu

#pragma mark - Init Methods
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.backingView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.backingView];
        self.backingView.userInteractionEnabled = NO;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

-(instancetype)initWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    if (self == [super init]) {
        _startColor = startColor;
        _endColor = endColor; 
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.backingView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.backingView];
        self.backingView.userInteractionEnabled = NO;
    }
    return self;
}

- (void)awakeFromNib{
    //Change!!
    CGFloat red = arc4random_uniform(255);
    CGFloat green = arc4random_uniform(255);
    CGFloat blue = arc4random_uniform(255);
    CGFloat redB = arc4random_uniform(255);
    CGFloat greenB = arc4random_uniform(255);
    CGFloat blueB = arc4random_uniform(255);
    self.startColor = [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:1];
    self.endColor = [UIColor colorWithRed:(redB/255.0) green:(greenB/255.0) blue:(blueB/255.0) alpha:1];
    self.textColor = [UIColor whiteColor];
    self.backingView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1];
    [self setup];
}

#pragma mark - Properties

-(CAShapeLayer *)triangleLayer{
    if (!_triangleLayer) {
        CGFloat triangleSize = 10.0;
        _triangleLayer = [CAShapeLayer layer];
        UIBezierPath *trianglePath = [UIBezierPath bezierPath];
        CGPoint topLeft = CGPointMake(CGRectGetMidX(self.bounds) - triangleSize, triangleSize);
        CGPoint topRight = CGPointMake(CGRectGetMidX(self.bounds) + triangleSize, triangleSize);
        CGPoint bottom = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        [trianglePath moveToPoint:topLeft];
        [trianglePath addLineToPoint:topRight];
        [trianglePath addLineToPoint:bottom];
        [trianglePath closePath];
        _triangleLayer.path = trianglePath.CGPath;
        _triangleLayer.fillColor = [UIColor blackColor].CGColor;
        _triangleLayer.fillRule = kCAFillRuleNonZero;
        
    }
    return _triangleLayer;
}

#pragma mark - Private Methods

// add default values to prevent this

-(void)setItemFont:(UIFont *)itemFont{
    _itemFont = itemFont;
    [self setup]; 
}

-(void)setItems:(NSArray *)items{
    _items = items;
    [self setup];
}

- (UIColor*)colorForItemAtIndex:(NSInteger)index{
    NSArray *colors = [UIColor numberOfColors:self.items.count betweenColor:self.startColor otherColor:self.endColor];
    return [colors objectAtIndex:index];
}

-(void)setup{
    //Move some of this to layoutsubviews?
    [self.backingView.layer addSublayer:self.triangleLayer] ;
    [self addTarget:self action:@selector(display) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *tmp = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(MenuItem *item, NSUInteger idx, BOOL *stop) {
        item.backgroundColor = [self colorForItemAtIndex:idx];
        item.frame = self.bounds;
        item.font = self.itemFont; 
        idx == 0 ? [self insertSubview:item belowSubview:self.backingView] : [self insertSubview:item belowSubview:[tmp objectAtIndex:idx - 1 ]];
        [tmp addObject:item];
    }];
    self.menuItems = [NSArray arrayWithArray:tmp];
}

#pragma mark - Actions

-(void)display{
    [self animateTriangle];

    self.expanded ? [self collapse] : [self expand];
}

- (void)animateTriangle{
    CGFloat myRotationAngle = M_PI/2;
    NSNumber *rotationAtStart = [self.triangleLayer valueForKeyPath:@"transform.rotation"];
    CATransform3D myRotationTransform = CATransform3DRotate(self.triangleLayer.transform, myRotationAngle, 0.0, 0.0, 1.0);
    self.triangleLayer.transform = myRotationTransform;
    CABasicAnimation *myAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    myAnimation.duration = 1.0;
    myAnimation.fromValue = rotationAtStart;
    myAnimation.toValue = [NSNumber numberWithFloat:([rotationAtStart floatValue] + myRotationAngle)];
    [self.triangleLayer addAnimation:myAnimation forKey:@"transform.rotation"];
//    [self.triangleLayer addAnimation:rotate forKey:@"rotate"];
}

- (void)expand{
    [self.menuItems enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat duration = .2;
        CGFloat delay = (duration/self.menuItems.count)*idx;
        [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            obj.transform = CGAffineTransformTranslate(obj.transform, 0, (idx + 1) * -self.frame.size.height);
        } completion:^(BOOL finished) {
            self.expanded = YES;
        }];
    }];
}

- (void)collapse{
    [self.menuItems enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            obj.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.expanded = NO;
        }];
    }];
}

@end
