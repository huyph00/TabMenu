//
//  MenuTabView.m
//  TabMenu
//
//  Created by NCXT on 03/05/2014.
//  Copyright (c) Năm 2014 NCXT. All rights reserved.
//

#import "MenuTabView.h"
#import "TabObj.h"

@implementation MenuTabView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//============================================
//============== Horizontal mode =============
//============================================
//
-(id)initMenuHorizontalWithFrame:(CGRect)frame andTabs:(NSArray *)objects;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        if(!objects || objects.count == 0) return self;
        selectedTab = 0;
        tabsArr = objects;
        UIScrollView * scrTab = [[UIScrollView alloc]init];

        //setup frame for scroll tabs
        CGRect scrRect;
        float tabHeight;
        
        if ([SharedData sharedInstance].isIpad) {
            scrRect = CGRectMake(0, 0, frame.size.width, TAB_IPAD_HORI_HEIGHT);
            tabHeight = TAB_IPAD_HORI_HEIGHT;
        }
        else
        {
            scrRect = CGRectMake(0, 0, frame.size.width, TAB_IPHONE_HORI_HEIGHT);
            tabHeight = TAB_IPHONE_HORI_HEIGHT;

        }
        scrTab.frame = scrRect;
        [scrTab setBounces:NO];
        [self addSubview:scrTab];
        
        //add tab buttons into scroll
        float next_x_origin = 0;
        for (int i = 0; i< objects.count; i++) {
            TabObj * obj = [objects objectAtIndex:i];
            UIButton * tabBtn = [[UIButton alloc]init];
            tabBtn.tag = i;
            tabBtn.backgroundColor = [UIColor yellowColor];
            if(i == 0)
            {
                tabBtn.backgroundColor = [UIColor whiteColor];
                prevBtn = tabBtn;

            }
            [tabBtn addTarget:self action:@selector(didSelectTab:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrTab addSubview:tabBtn];

            
            UILabel * lblTitle = [[UILabel alloc]init];
            CGFloat width =  [[NSString stringWithFormat:@" %@",obj.title] sizeWithFont:lblTitle.font].width;
            
            lblTitle.frame = CGRectMake(0 , 0, width,tabHeight);
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.text = [NSString stringWithFormat:@" %@",obj.title];
            
            [tabBtn addSubview:lblTitle];
            
            if(obj.icon)
            {
                UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(lblTitle.frame.size.width, 0, tabHeight, tabHeight)];
                icon.image = obj.icon;
                
                [tabBtn addSubview:icon];
            }
            tabBtn.frame = CGRectMake(next_x_origin, 0, width + tabHeight, tabHeight);
//            [[tabBtn layer] setBorderWidth:1.0f];
//            [[tabBtn layer] setBorderColor:[UIColor blackColor].CGColor];

            next_x_origin = next_x_origin + tabBtn.frame.size.width;
        }
        [scrTab setContentSize:CGSizeMake(next_x_origin, tabHeight)];

        //set view content
        rectContent = self.frame;
        rectContent.origin.y = tabHeight + 5;
        rectContent.size.height = self.frame.size.height - (tabHeight + 5);
        contentView = [(TabObj *)[objects objectAtIndex:0] view];
        contentView.frame = rectContent;
        [self addSubview:contentView];
    }
    return self;
}

//============================================
//============== Vertical mode ===============
//============================================
//
-(id)initMenuVerticalWithFrame:(CGRect)frame andTabs:(NSArray *)objects
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        if(!objects || objects.count == 0) return self;
        selectedTab = 0;
        tabsArr = objects;
        UIScrollView * scrTab = [[UIScrollView alloc]init];
        
        //setup frame for scroll tabs
        CGRect scrRect;
        float tabHeight;
        
        if ([SharedData sharedInstance].isIpad) {
            scrRect = CGRectMake(0, 0, TAB_IPAD_VERTI_WIDTH, frame.size.height);
            tabHeight = TAB_IPAD_VERTI_WIDTH;
        }
        else
        {
            scrRect = CGRectMake(0, 0, TAB_IPHONE_VERTI_WIDTH, frame.size.height);
            tabHeight = TAB_IPHONE_VERTI_WIDTH;
            
        }
        scrTab.frame = scrRect;
        [scrTab setBounces:NO];
        [self addSubview:scrTab];
        
        //add tab buttons into scroll
        float next_x_origin = 0;
        for (int i = 0; i< objects.count; i++) {
            TabObj * obj = [objects objectAtIndex:i];
            UIButton * tabBtn = [[UIButton alloc]init];
            tabBtn.tag = i;
            tabBtn.backgroundColor = [UIColor yellowColor];
            if(i == 0)
            {
                tabBtn.backgroundColor = [UIColor whiteColor];
                prevBtn = tabBtn;
                
            }
            [tabBtn addTarget:self action:@selector(didSelectTab:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrTab addSubview:tabBtn];
            
            
            UILabel * lblTitle = [[UILabel alloc]init];
            [lblTitle setLineBreakMode:NSLineBreakByCharWrapping];

            lblTitle.frame = CGRectMake(0 , 0, width, obj.title.length * );
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.text = obj.title;
            
            [tabBtn addSubview:lblTitle];
            
            if(obj.icon)
            {
                UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(lblTitle.frame.size.width, 0, tabHeight, tabHeight)];
                icon.image = obj.icon;
                
                [tabBtn addSubview:icon];
            }
            tabBtn.frame = CGRectMake(next_x_origin, 0, width + tabHeight, tabHeight);
            //            [[tabBtn layer] setBorderWidth:1.0f];
            //            [[tabBtn layer] setBorderColor:[UIColor blackColor].CGColor];
            
            next_x_origin = next_x_origin + tabBtn.frame.size.width;
        }
        [scrTab setContentSize:CGSizeMake(next_x_origin, tabHeight)];
        
        //set view content
        rectContent = self.frame;
        rectContent.origin.y = tabHeight + 5;
        rectContent.size.height = self.frame.size.height - (tabHeight + 5);
        contentView = [(TabObj *)[objects objectAtIndex:0] view];
        contentView.frame = rectContent;
        [self addSubview:contentView];

        
    }
    return self;
}

-(void)didSelectTab:(UIButton*)sender
{
    if(selectedTab == sender.tag) return;
    prevBtn.backgroundColor = [UIColor yellowColor];
    sender.backgroundColor = [UIColor whiteColor];
    
    selectedTab = sender.tag;
    TabObj * tab = [tabsArr objectAtIndex:selectedTab];
    [contentView removeFromSuperview];
    contentView = tab.view;
    contentView.frame = rectContent;
    [self addSubview:contentView];
    prevBtn = sender;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
