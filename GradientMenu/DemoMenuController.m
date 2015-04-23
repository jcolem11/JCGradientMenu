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
    self.menu.startColor = [UIColor purpleColor];
    self.menu.endColor = [UIColor orangeColor];
    
    MenuItem *item1 = [[MenuItem alloc] initWithTitle:@"Home" action:^{
        //
    }];
    
    MenuItem *item2 = [[MenuItem alloc] initWithTitle:@"Friends" action:^{
        //
    }];
    
    MenuItem *item3 = [[MenuItem alloc] initWithTitle:@"Explore" action:^{
        //
    }];
    
    MenuItem *item4 = [[MenuItem alloc] initWithTitle:@"Upload" action:^{
        //
    }];
    
    MenuItem *item5 = [[MenuItem alloc] initWithTitle:@"Upload" action:^{
        //
    }];
    
    self.menu.items = @[item1, item2, item3, item4, item5];
}


@end
