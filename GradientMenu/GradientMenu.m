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
@property (strong, nonatomic) UIView *triangleView;
@property (assign, nonatomic) BOOL expanded;
@property (strong, nonatomic) CAShapeLayer *triangleLayer;
@property (assign, nonatomic) UIBezierPath *originalTrianglePath;

@end

@implementation GradientMenu

#pragma mark - Init Methods
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _animationDuration = .2;
        self.backgroundColor = [UIColor clearColor];
        self.backingView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.backingView];
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
        _animationDuration = .2;
        self.backgroundColor = [UIColor clearColor];
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.backingView = [[UIView alloc]initWithFrame:self.bounds];
        self.triangleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
        [self addSubview:self.backingView];
        [self addSubview:self.triangleView];
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

- (void)addTriangleToView:(UIView *)view{
    _triangleLayer = [CAShapeLayer layer];
    CGFloat triangleSize = view.frame.size.height;
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    CGPoint topLeft = CGPointMake(triangleSize/4, CGRectGetMidY(view.bounds));
    CGPoint topRight = CGPointMake(CGRectGetMaxX(view.bounds) - triangleSize/4, CGRectGetMidY(view.bounds));
    CGPoint bottom = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMaxY(view.bounds) - triangleSize/4);
    [trianglePath moveToPoint:topLeft];
    [trianglePath addLineToPoint:topRight];
    [trianglePath addLineToPoint:bottom];
    [trianglePath closePath];
    _triangleLayer.path = trianglePath.CGPath;
    _triangleLayer.fillColor = [UIColor blackColor].CGColor;
    _triangleLayer.fillRule = kCAFillRuleNonZero;
    [view.layer addSublayer:self.triangleLayer];
    
    //
    self.originalTrianglePath.CGPath = self.triangleLayer.path;
}

//-(CAShapeLayer *)triangleLayer{
//    if (!_triangleLayer) {
//        CGFloat triangleSize = self.triangleView.frame.size.height;
//        _triangleLayer = [CAShapeLayer layer];
//        UIBezierPath *trianglePath = [UIBezierPath bezierPath];
//        CGPoint topLeft = CGPointMake(CGRectGetMidX(self.triangleView.bounds) - triangleSize, triangleSize);
//        CGPoint topRight = CGPointMake(CGRectGetMidX(self.triangleView.bounds) + triangleSize, triangleSize);
//        CGPoint bottom = CGPointMake(CGRectGetMidX(self.triangleView.bounds), CGRectGetMidY(self.triangleView.bounds));
//        [trianglePath moveToPoint:topLeft];
//        [trianglePath addLineToPoint:topRight];
//        [trianglePath addLineToPoint:bottom];
//        [trianglePath closePath];
//        _triangleLayer.path = trianglePath.CGPath;
//        _triangleLayer.fillColor = [UIColor blackColor].CGColor;
//        _triangleLayer.fillRule = kCAFillRuleNonZero;
//        
//    }
//    return _triangleLayer;
//}

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
    [self addTriangleToView:self.triangleView];
    self.backingView.userInteractionEnabled = NO;
    self.triangleView.center = CGPointMake(CGRectGetMidX(self.bounds), (CGRectGetMidY(self.bounds)));
    [self addTarget:self action:@selector(display) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *tmp = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(MenuItem *item, NSUInteger idx, BOOL *stop) {
        item.userInteractionEnabled = self.expanded; 
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
//    [self animateTriangle:self.triangleLayer];
    self.expanded ? [self collapse] : [self expand];
}

- (void)animateTriangle:(CAShapeLayer *)triangleLayer{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    if (!self.expanded) {
        UIBezierPath *newPath = [UIBezierPath bezierPath];
        CGPoint Left = CGPointMake(self.triangleView.bounds.size.height/4, CGRectGetMidY(self.triangleView.bounds));
        CGPoint Right = CGPointMake(CGRectGetMaxX(self.triangleView.bounds) - self.triangleView.bounds.size.height/4, CGRectGetMidY(self.triangleView.bounds));
        CGPoint top = CGPointMake(CGRectGetMidX(self.triangleView.bounds), self.triangleView.bounds.size.height/4);
        [newPath moveToPoint:Left];
        [newPath addLineToPoint:Right];
        [newPath addLineToPoint:top];
        [newPath closePath];
        pathAnimation.fromValue = (__bridge id) triangleLayer.path;
        pathAnimation.toValue = (__bridge id)newPath.CGPath;
    } else if(self.expanded){
        pathAnimation.toValue =(__bridge id) self.originalTrianglePath.CGPath;
    }
    pathAnimation.duration = self.animationDuration;
    pathAnimation.fillMode = kCAFillModeBoth;
    pathAnimation.removedOnCompletion = NO;
    [triangleLayer addAnimation:pathAnimation forKey:@"path"];

}

- (void)expand{
    [self.menuItems enumerateObjectsUsingBlock:^(MenuItem *obj, NSUInteger idx, BOOL *stop) {
        CGFloat delay = (self.animationDuration/self.menuItems.count)*idx;
        [UIView animateWithDuration:self.animationDuration delay:delay usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            obj.transform = CGAffineTransformTranslate(obj.transform, 0, (idx + 1) * -self.frame.size.height);
        } completion:^(BOOL finished) {
            self.expanded = YES;
            obj.displaying = self.expanded;
            
        }];
    }];
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.triangleView.transform = CGAffineTransformRotate(self.triangleView.transform, M_PI);
    }];
}

- (void)collapse{
    [self.menuItems enumerateObjectsUsingBlock:^(MenuItem *obj, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            obj.transform = CGAffineTransformIdentity;
            self.triangleView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.expanded = NO;
            obj.displaying = self.expanded; 
        }];
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //Because subviews are outside of the parents bounds, touchesBegan/gestureRecognizers will not work
    // Could this be done differently?
    for (UIView *view in self.subviews) {
        CGPoint pointForTargetView = [view convertPoint:point fromView:self];
        if (CGRectContainsPoint(view.bounds, pointForTargetView) && view.class == [MenuItem class] && self.expanded) {
            
            return [view hitTest:pointForTargetView withEvent:event];
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
