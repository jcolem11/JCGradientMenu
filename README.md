# JCGradientMenu

<h3> 
   <a href="http://imgur.com/ToPStWB"><img src="http://i.imgur.com/ToPStWB.gif?1" title="source: imgur.com" /></a>
</h3>

##Usage
###Creating the menu
The control can be added to a Storyboard file. Or, if you prefer to use it prorgramatically:
```objective-c
//Creating Menu
- (instancetype)initWithStartColor:(UIColor*)startColor endColor:(UIColor*)endColor;
```
Setting up GradientMenu is as easy as assigning it a start and endcolor as well as some MenuItems.
```objective-c
//Creating Menu
MenuItem *homeItem = [MenuItem alloc] initWithTitle:@"Home" action:^{NSLog(@"Home Pressed");}];
self.menu.items = @[homeItem]; 
```

###Menu Items
Each opiton in the menu is represented by a MenuItem. A MenuItem has a title, an action that is performed upon pressing it, and a font (optional). MenuItems are created like so:
```objective-c
//Creating MenuItem
MenuItem *item = [[MenuItem alloc] initWithTitle:@"Log Out" action:^{
            [self logout]; 
        }];
```

###Author
Me :)
Joshua Coleman. Shoot me an email if you have any questions

###License, Blah, Blah, Blah...
Licensed under MIT. If you're going to use this in a project I would love to know!
https://twitter.com/_joshington
