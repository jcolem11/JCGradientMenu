//
//  ViewController.m
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import "ViewController.h"
#import "GradientMenu.h"
#import "UIColor+GradientPoints.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *randomButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (assign, nonatomic) CGFloat itemHeight;
@property (assign, nonatomic) CGFloat itemWidth;
@property (strong, nonatomic) NSArray *views;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(randomize:) withObject:nil afterDelay:.3];
    [self setup];
}

-(NSArray *)views{
    if (!_views) {
        self.itemHeight = self.contentView.frame.size.height/10;
        self.itemWidth = self.contentView.frame.size.width;
        NSMutableArray *tmp = [NSMutableArray array];
        for (int i = 0; i < 10; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.itemHeight * i, self.itemWidth , self.itemHeight)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            [self.contentView addSubview:label];
            [tmp addObject:label];
        }
        _views = [NSArray arrayWithArray:tmp];
    }
    return _views;
}

- (IBAction)randomize:(id)sender{

    NSArray *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];

    CGFloat red = arc4random_uniform(255);
    CGFloat green = arc4random_uniform(255);
    CGFloat blue = arc4random_uniform(255);
    CGFloat redB = arc4random_uniform(255);
    CGFloat greenB = arc4random_uniform(255);
    CGFloat blueB = arc4random_uniform(255);
    UIColor *color = [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:1];
    UIColor *colorB = [UIColor colorWithRed:(redB/255.0) green:(greenB/255.0) blue:(blueB/255.0) alpha:1];
    NSArray *colors =  [UIColor numberOfColors:array.count betweenColor:color otherColor:colorB];
    [self.views enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:.5 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            const CGFloat *colorVals = CGColorGetComponents(((UIColor*)[colors objectAtIndex:idx]).CGColor);
            label.text = [NSString stringWithFormat:@"R:%.2f G:%.2f B:%.2f", (NSInteger)colorVals[0]*255.0, colorVals[1]*255.0, colorVals[2]*255.0];
            UIColor *color = [colors objectAtIndex:idx];
            label.layer.backgroundColor = color.CGColor;
        } completion:^(BOOL finished) {
        }];
    }];
}

-(void)setup{
    self.randomButton.layer.cornerRadius = self.randomButton.frame.size.height/2;
    self.randomButton.layer.shadowOpacity = .6;
    self.randomButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.randomButton.layer.shadowOffset = CGSizeMake(1, 1);
    [self.view bringSubviewToFront:self.randomButton];
}

@end
