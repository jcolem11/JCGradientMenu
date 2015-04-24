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

@end

@implementation MenuItem

#pragma mark - 

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

#pragma mark - 

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.displaying = NO;
        [self setUp];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title action:(void (^)())action{
    if (self == [super init]) {
        _title = title;
        _action = action;
        [self setUp];
    }
    return self;
}

-(void)setDisplaying:(BOOL)displaying{
    _displaying = displaying;
    self.userInteractionEnabled = displaying ? YES : NO;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.action) {
        self.action();
    }
}

-(void)setUp{
    self.titleLabel.text = self.title;
    self.titleLabel.textColor = [UIColor whiteColor]; 
    [self addSubview:self.titleLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

@end
