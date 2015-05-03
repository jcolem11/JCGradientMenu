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

@interface GradientMenu() <MenuItemDelegate>

@property (strong, nonatomic) NSArray *menuItems;
@property (strong, nonatomic) UIView *backingView;
@property (strong, nonatomic) UIView *triangleView;
@property (strong, nonatomic) CAShapeLayer *triangleLayer;
@property (assign, nonatomic) BOOL expanded;

@end

@implementation GradientMenu

#pragma mark - Init Methods

-(instancetype)initWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    if (self == [super init]) {
        self.startColor = startColor;
        self.endColor = endColor;
        self.animationDuration = .2;
        self.backgroundColor = [UIColor clearColor];
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.backingView = [[UIView alloc]initWithFrame:self.bounds];
        self.triangleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
        [self addSubview:self.backingView];
        [self addSubview:self.triangleView];
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.animationDuration = .2;
        self.backgroundColor = [UIColor clearColor];
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.backingView = [[UIView alloc]initWithFrame:self.bounds];
        self.triangleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
        [self addSubview:self.backingView];
        [self addSubview:self.triangleView];
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super initWithCoder:aDecoder]) {
        self.animationDuration = .2;
        self.backgroundColor = [UIColor clearColor];
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.backingView = [[UIView alloc]initWithFrame:self.bounds];
        self.triangleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
        [self addSubview:self.backingView];
        [self addSubview:self.triangleView];
        [self setup];
    }
    return self;
}



#pragma mark - Properties

-(void)setItemFont:(UIFont *)itemFont{
    _itemFont = itemFont;
    [self setup];
}

-(void)setItems:(NSArray *)items{
    _items = items;
    [self setup];
}

#pragma mark - Private Methods

- (UIColor*)colorForItemAtIndex:(NSInteger)index{
    NSArray *colors = [UIColor numberOfColors:self.items.count betweenColor:self.startColor otherColor:self.endColor];
    return [colors objectAtIndex:index];
}


- (void)addTriangleToView:(UIView *)view{
    _triangleLayer = [CAShapeLayer layer];
    CGFloat triangleSize = view.frame.size.height;
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    CGPoint topLeft = CGPointMake(triangleSize/4, CGRectGetMidY(view.bounds));
    CGPoint topRight = CGPointMake(CGRectGetMaxX(view.bounds) - triangleSize/4, CGRectGetMidY(view.bounds));
    CGPoint top = CGPointMake(CGRectGetMidX(view.bounds), view.bounds.size.height/4);
    [trianglePath moveToPoint:topLeft];
    [trianglePath addLineToPoint:topRight];
    [trianglePath addLineToPoint:top];
    [trianglePath closePath];
    _triangleLayer.path = trianglePath.CGPath;
    _triangleLayer.fillColor = [UIColor blackColor].CGColor;
    _triangleLayer.fillRule = kCAFillRuleNonZero;
    [view.layer addSublayer:self.triangleLayer];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backingView.frame = self.bounds;
    self.triangleView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
    self.triangleView.center = CGPointMake(CGRectGetMidX(self.bounds), (CGRectGetMidY(self.bounds)));
    [self addTriangleToView:self.triangleView];
}

-(void)setup{
    self.backingView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1];
    [self addTriangleToView:self.triangleView];
    self.triangleView.userInteractionEnabled = NO; 
    self.backingView.userInteractionEnabled = NO;
    self.triangleView.center = CGPointMake(CGRectGetMidX(self.bounds), (CGRectGetMidY(self.bounds)));
    [self addTarget:self action:@selector(display) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *tmp = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(MenuItem *item, NSUInteger idx, BOOL *stop) {
        item.userInteractionEnabled = self.expanded; 
        item.backgroundColor = [self colorForItemAtIndex:idx];
        item.frame = self.bounds;
        item.font = self.itemFont;
        item.delegate = self;
        idx == 0 ? [self insertSubview:item belowSubview:self.backingView] : [self insertSubview:item belowSubview:[tmp objectAtIndex:idx - 1 ]];
        [tmp addObject:item];
    }];
    self.menuItems = [NSArray arrayWithArray:tmp];
}


#pragma mark - Actions

-(void)display{
    self.expanded ? [self collapse] : [self expand];
}

- (void)expand{
    [self.menuItems enumerateObjectsUsingBlock:^(MenuItem *obj, NSUInteger idx, BOOL *stop) {
        CGFloat delay = (self.animationDuration/self.menuItems.count)*idx;
        [UIView animateWithDuration:self.animationDuration delay:delay usingSpringWithDamping:.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            obj.transform = CGAffineTransformTranslate(obj.transform, 0, (idx + 1) * -self.frame.size.height);
            self.expanded = YES;
        } completion:^(BOOL finished) {
            obj.displaying = self.expanded;
            
        }];
    }];
    [UIView animateWithDuration:self.animationDuration * 1.5 animations:^{
        self.triangleView.transform = CGAffineTransformRotate(self.triangleView.transform, M_PI);
    }];
}

- (void)collapse{
    [self.menuItems enumerateObjectsUsingBlock:^(MenuItem *obj, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            obj.transform = CGAffineTransformIdentity;
            self.triangleView.transform = CGAffineTransformIdentity;
            self.expanded = NO;
        } completion:^(BOOL finished) {
            obj.displaying = self.expanded;
        }];
    }];
}

-(void)menuItemPressed{
    [self collapse]; 
}

#pragma mark - Touch Tracking

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *view in self.subviews) {
        CGPoint pointForTargetView = [view convertPoint:point fromView:self];
        if (CGRectContainsPoint(view.bounds, pointForTargetView) && view.class == [MenuItem class] && self.expanded) {
             [view hitTest:pointForTargetView withEvent:event];
            return view;
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
