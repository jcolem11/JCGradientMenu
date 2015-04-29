//
//  DemoMenuController.m
//  GradientMenu
//
//  Created by Owner on 4/12/15.
//  Copyright (c) 2015 Josh Coleman. All rights reserved.
//

#import "DemoMenuController.h"
#import "GradientMenu.h"
#import "UIColor+GradientPoints.h"

@interface DemoMenuController()

@property (weak, nonatomic) IBOutlet GradientMenu *menu;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DemoMenuController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.menu.endColor = [UIColor colorWithRed:0.99 green:0.89 blue:0.65 alpha:1];
    self.menu.startColor = [UIColor colorWithRed:0.4 green:0.25 blue:0.45 alpha:1];
    self.menu.itemFont = [UIFont fontWithName:@"Avenir Next" size:18];
    
//    MenuItem *item1 = [[MenuItem alloc] initWithTitle:@"Home" action:^{
//        NSLog(@"Menu 1 pressed!");
//    }];
//    
//    MenuItem *item2 = [[MenuItem alloc] initWithTitle:@"Friends" action:^{
//        //
//    }];
//    
//    MenuItem *item3 = [[MenuItem alloc] initWithTitle:@"Explore" action:^{
//        //
//    }];
//    
//    MenuItem *item4 = [[MenuItem alloc] initWithTitle:@"Upload" action:^{
//        //
//    }];
//    
//    MenuItem *item5 = [[MenuItem alloc] initWithTitle:@"Log Out" action:^{
//        //
//    }];
//
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i =0; i < 5; i ++) {
        MenuItem *item = [[MenuItem alloc] initWithTitle:[NSString stringWithFormat:@"%i",i + 1] action:^{
            self.label.text = [NSString stringWithFormat:@"Item # %i Pressed!", i + 1];
        }];
        [array addObject:item];
    }
    
    self.menu.items = [NSArray arrayWithArray:array];
}


@end
