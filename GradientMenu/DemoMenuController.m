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
    self.menu.startColor = [UIColor colorWithRed:0.4 green:0.2 blue:0.6 alpha:1];
    self.menu.endColor = [UIColor colorWithRed:0.99 green:0.89 blue:0.65 alpha:1];
    self.menu.itemFont = [UIFont fontWithName:@"Avenir Next" size:18];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i =0; i < 5; i ++) {
        MenuItem *item = [[MenuItem alloc] initWithTitle:[NSString stringWithFormat:@"%i",i + 1] action:^{
            self.label.text = [NSString stringWithFormat:@"Item # %i Pressed!", i + 1];
        }];
        [array addObject:item];
    }
    self.menu.items = [NSArray arrayWithArray:array];
    
// Comment out this section to create a menu programatically
//    
//    GradientMenu *menu = [[GradientMenu alloc] initWithStartColor:[UIColor redColor] endColor:[UIColor blueColor]];
//    menu.frame = CGRectMake(150, 350, 100, 35);
//    [self.view addSubview:menu];
//    
//    MenuItem *item1 = [[MenuItem alloc] initWithTitle:@"Home" action:nil];
//    MenuItem *item2 = [[MenuItem alloc] initWithTitle:@"Yo" action:nil];
//    
//    NSArray *itemArray = @[item1, item2];
//    menu.items = itemArray;
//
//    
}


@end
