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
    arrTab =[[NSMutableArray alloc]init];
    for (int i = 0 ; i < 20; i++) {
        TabObj * tab = [[TabObj alloc]init];
        CGRect rect = self.view.frame;
        rect.size.height = rect.size.height - 100;
        UIView * view = [[UIView alloc]initWithFrame:rect];
        [view setBackgroundColor:[UIColor whiteColor]];
        UILabel*lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = [ NSString stringWithFormat:@"this is the view of tab %d",i];
        [view addSubview:lbl];
        tab.view = view;
        
        if (i==0) {
            //only title
            tab.title = @"only title";
        }
        
        if (i==1) {
            //only icon

            tab.icon = [SharedData imageWithBundle:@"icon1" scaledToSize:CGSizeMake(20, 20)];
        }
        if (i==2) {
            //title + icon
            tab.title = @"icon + title1";
            tab.icon = [SharedData imageWithBundle:@"icon2" scaledToSize:CGSizeMake(20, 20)];

        }
        if (i==3) {
            //title + icon
            tab.title = @"icon + title2";
            tab.icon = [SharedData imageWithBundle:@"icon3" scaledToSize:CGSizeMake(20, 20)];

        }
        
        
        [arrTab addObject:tab];
        
    }
    //test menu rect
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0;
    rect.origin.y = 100;
    rect.size.height = self.view.frame.size.height - 100;
    menu = [[MenuTabView alloc]initMenuHorizontalWithFrame:rect tabHeight:60 titleFont:[UIFont systemFontOfSize:17] iconRect:CGRectMake(0, 5, 20, 20) tabs:arrTab andSelectedIndex:0];

//    menu = [[MenuTabView alloc]initMenuVerticalWithFrame:rect tabWidth:30 titleFont:[UIFont systemFontOfSize:17] iconRect:CGRectMake(0, 0, 30, 30) tabs:arrTab andSelectedIndex:1];
    
    [self.view addSubview:menu];

}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
{
    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
//        CGRect rect = self.view.frame;
//        
//        rect.origin.y = 50;
//        rect.size.height = self.view.frame.size.height - 50;
//        [menu removeFromSuperview];
//        
//        if ([menu isHorizonMode]) {
//            menu = [[MenuTabView alloc]initMenuHorizontalWithFrame:rect tabHeight:30 titleFont:[UIFont systemFontOfSize:17] iconRect:CGRectMake(0, 0, 30, 30) andTabs:arrTab];
//        }
//        
//        else menu = [[MenuTabView alloc]initMenuVerticalWithFrame:rect tabWidth:30 titleFont:[UIFont systemFontOfSize:17] iconRect:CGRectMake(0, 0, 30, 30) andTabs:arrTab];
//        
//        [self.view addSubview:menu];

    }
    else
    {


    }
}
- (void)didReceiveMemoryWarning
{
    NSLog(@"Memory warning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fixTabSize:(id)sender {
    if(menu.isHorizontalMode)
    [menu fixTabHeight:27];
    else [menu fixTabWidth:27];
}

- (IBAction)switchMode:(id)sender {
    if(!menu) return;
    CGRect rect = self.view.frame;
    rect.origin.y = 100;
    rect.origin.x = 0;
    rect.size.height = self.view.frame.size.height - 100;
    [menu removeFromSuperview];
    int index = [menu selectedTabIndex];
    if ([menu isHorizontalMode]) {
        menu = [[MenuTabView alloc]initMenuVerticalWithFrame:rect tabWidth:60 titleFont:[UIFont systemFontOfSize:17] iconRect:CGRectMake(0, 5, 20, 20) tabs:arrTab andSelectedIndex:index];
    }

    else     menu = [[MenuTabView alloc]initMenuHorizontalWithFrame:rect tabHeight:60 titleFont:[UIFont systemFontOfSize:17] iconRect:CGRectMake(0, 5, 20, 20) tabs:arrTab andSelectedIndex:index];


    [self.view addSubview:menu];
}

@end
