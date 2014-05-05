//
//  MenuTabView.h
//  TabMenu
//
//  Created by NCXT on 03/05/2014.
//  Copyright (c) Năm 2014 NCXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "TabObj.h"
#import "SharedData.h"

@interface MenuTabView : UIView
{
    UIView * contentView;
    NSArray * tabsArr;
    int selectedTab;
    CGRect rectContent ;
    UIButton *prevBtn;
    BOOL isHoriMode;
//    CGFloat tabWidth;
//    CGFloat tabHeight;
//    CGRect iconRect;
    
}
//---- icon rect should be (0,0,w,h)----
-(id)initMenuHorizontalWithFrame:(CGRect)frame tabHeight:(CGFloat)height titleFont:(UIFont*)font iconRect:(CGRect)rect tabs:(NSArray *)objects andSelectedIndex:(int)index;
-(id)initMenuVerticalWithFrame:(CGRect)frame tabWidth:(CGFloat)width titleFont:(UIFont*)font iconRect:(CGRect)rect tabs:(NSArray *)objects andSelectedIndex:(int)index;
-(BOOL)isHorizontalMode;
-(int)selectedTabIndex;

//-(void)setTitleFont:(UIFont*)font;
//-(void)setTabWidth:(CGFloat)width;
//-(void)setTabHeight:(CGFloat)height;
//-(void)setIconrect:(CGRect)rect;

@end
