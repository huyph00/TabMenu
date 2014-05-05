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
}
-(id)initMenuHorizontalWithFrame:(CGRect)frame andTabs:(NSArray *)objects;

-(id)initMenuVerticalWithFrame:(CGRect)frame andTabs:(NSArray *)objects;

@end
