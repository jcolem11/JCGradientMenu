//
//  MenuItem.m
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import "MenuItem.h"

@interface MenuItem ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (assign,nonatomic) CGAffineTransform currentTransform;

@end

@implementation MenuItem


#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.displaying = NO;
        [self setUp];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title action:(void (^)())action{
    if (self == [super init]) {
        _title = title;
        _action = action;
        [self setUp];
    }
    return self;
}

# pragma mark - Properties

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}


-(void)setFont:(UIFont *)font{
    _font = font;
    self.titleLabel.font = font;
}


- (void)setDisplaying:(BOOL)displaying{
    _displaying = displaying;
    self.userInteractionEnabled = displaying;
}

#pragma mark - Layout

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

- (void)setUp{
    self.titleLabel.text = self.title;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
}

#pragma mark - Touch Tracking

- (void) jiggle{
    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1 options:0 animations:^{
        self.currentTransform = self.currentTransform;
        self.transform = self.currentTransform;
    } completion:^(BOOL finished) {
        
    }];
    if (self.action) {
        self.action();
    }
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    [UIView animateWithDuration:.2 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:1 options:0 animations:^{
        self.currentTransform = self.transform;
        self.transform = CGAffineTransformScale(self.transform, 0.97, 0.97);
    } completion:^(BOOL finished) {
        
    }];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    [self jiggle]; 

}
@end
