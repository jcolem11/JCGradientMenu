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

@end

@implementation DemoMenuController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.menu.startColor = [UIColor colorWithRed:0.46 green:0.22 blue:0.4 alpha:1];
    self.menu.endColor = [UIColor colorWithRed:0.74 green:0.36 blue:0.92 alpha:1];
    self.menu.itemFont = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    MenuItem *item1 = [[MenuItem alloc] initWithTitle:@"Home" action:^{
        //
    }];
    
    MenuItem *item2 = [[MenuItem alloc] initWithTitle:@"Friends" action:^{
        //
    }];
    
    MenuItem *item3 = [[MenuItem alloc] initWithTitle:@"ExploreExploreExplore" action:^{
        //
    }];
    
    MenuItem *item4 = [[MenuItem alloc] initWithTitle:@"Upload" action:^{
        //
    }];
    
    MenuItem *item5 = [[MenuItem alloc] initWithTitle:@"Log Out" action:^{
        //
    }];
    
    self.menu.items = @[item1, item2, item3, item4, item5];
}


@end
