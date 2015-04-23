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
@property (strong, nonatomic) UILabel *titleLabel;
@property (assign, nonatomic) BOOL expanded;

@end

@implementation GradientMenu

#pragma mark - Init
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        [self addSubview:self.titleLabel];
        self.titleLabel.userInteractionEnabled = NO;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        [self addSubview:self.titleLabel];
        self.titleLabel.userInteractionEnabled = NO;
        self.textColor = [UIColor whiteColor];
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
    self.titleLabel.text = @"MENU";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor darkGrayColor];
    [self setup];
}

#pragma mark - Lazy loaded properties
-(NSArray *)items{
    if (!_items) {
        _items = @[@"Home", @"Score", @"Yo Moms", @"Bye"];
    }
    return _items;
}


#pragma mark - Private Methods
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.titleLabel.textColor = textColor;
    
}

- (UIColor*)colorForItemAtIndex:(NSInteger)index{
    NSArray *colors = [UIColor numberOfColors:self.items.count betweenColor:self.startColor otherColor:self.endColor];
    return [colors objectAtIndex:index];
}

-(void)setup{
    [self addTarget:self action:@selector(display) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *tmp = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc]initWithFrame:self.bounds];
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        label.text = string;
        label.textColor = self.textColor;
        label.backgroundColor = [self colorForItemAtIndex:idx];
        [view addSubview:label];
        label.userInteractionEnabled = NO;
        label.textAlignment = NSTextAlignmentCenter;
        view.userInteractionEnabled = NO;
        view.clipsToBounds = YES;
        idx == 0 ? [self insertSubview:view belowSubview:self.titleLabel] : [self insertSubview:view belowSubview:[tmp objectAtIndex:idx - 1 ]];
        [tmp addObject:view];
    }];
    self.menuItems = [NSArray arrayWithArray:tmp];
}

#pragma mark - Actions

-(void)display{
    self.expanded ? [self collapse] : [self expand];
}

- (void)expand{
    [self.menuItems enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat duration = .2;
        CGFloat delay = (duration/self.menuItems.count)*idx;
        [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            obj.transform = CGAffineTransformTranslate(obj.transform, 0, (idx + 1) * -self.frame.size.height);
            self.titleLabel.textColor = [UIColor blackColor];
        } completion:^(BOOL finished) {
            self.expanded = YES;
        }];
    }];
}

- (void)collapse{
    [self.menuItems enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            obj.transform = CGAffineTransformIdentity;
            self.titleLabel.textColor = [UIColor whiteColor];
        } completion:^(BOOL finished) {
            self.expanded = NO;
        }];
    }];
}

@end
