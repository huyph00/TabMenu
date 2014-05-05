//
//  ViewController.m
//  TabMenu
//
//  Created by NCXT on 03/05/2014.
//  Copyright (c) Năm 2014 NCXT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //test 20 tabs
    NSMutableArray * arrTab =[[NSMutableArray alloc]init];
    for (int i = 0 ; i < 20; i++) {
        TabObj * tab = [[TabObj alloc]init];
        tab.title = [NSString stringWithFormat:@"this is the tab %d",i];
        if(i % 2 == 0)tab.title = [NSString stringWithFormat:@"test title %d",i];
        
        tab.icon = [UIImage imageNamed:@"Sample-icon"];
        
        CGRect rect = self.view.frame;
        rect.size.height = rect.size.height - 100;
        UIView * view = [[UIView alloc]initWithFrame:rect];
        
        if (i%2==0) {
            view.backgroundColor = [UIColor yellowColor];
        }
        else view.backgroundColor = [UIColor blueColor];
        UILabel*lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = [ NSString stringWithFormat:@"this is the view of tab %d",i];
        [view addSubview:lbl];
        tab.view = view;
        [arrTab addObject:tab];
        
    }
    //test menu rect
    CGRect rect = self.view.frame;
    rect.origin.y = 50;
    rect.size.height = self.view.frame.size.height - 50;
//    MenuTabView * menu = [[MenuTabView alloc]initMenuHorizontalWithFrame:rect andTabs:[NSArray arrayWithArray:arrTab]];
    
    MenuTabView * menu = [[MenuTabView alloc]initMenuVerticalWithFrame:rect andTabs:[NSArray arrayWithArray:arrTab]];
    
    [self.view addSubview:menu];

}

- (void)didReceiveMemoryWarning
{
    NSLog(@"Memory warning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
