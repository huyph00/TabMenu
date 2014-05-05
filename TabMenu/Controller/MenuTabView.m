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
-(id)initMenuHorizontalWithFrame:(CGRect)frame tabHeight:(CGFloat)height titleFont:(UIFont*)font iconRect:(CGRect)rect tabs:(NSArray *)objects andSelectedIndex:(int)index;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        if(!objects || objects.count == 0) return self;
        isHoriMode = true;
        selectedTab = 0;
        if (index < objects.count) {
            selectedTab = index;
        }
        tabsArr = objects;
        UIScrollView * scrTab = [[UIScrollView alloc]init];

        //setup frame for scroll tabs
        CGFloat tabHeight = height;

        CGRect scrRect= CGRectMake(0, 0, self.frame.size.width, tabHeight);
        
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
            if(i == selectedTab)
            {
                tabBtn.backgroundColor = [UIColor whiteColor];
                prevBtn = tabBtn;

            }
            [tabBtn addTarget:self action:@selector(didSelectTab:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrTab addSubview:tabBtn];

            UILabel * lblTitle = [[UILabel alloc]init];
            lblTitle.font = font;
            CGFloat width ;

            if ([[NSString stringWithFormat:@" %@",obj.title] respondsToSelector:@selector( sizeWithFont:) ]) {
                width =  [[NSString stringWithFormat:@" %@",obj.title] sizeWithFont:lblTitle.font].width;
            }
            else
            {
                width =  [[NSString stringWithFormat:@" %@",obj.title] sizeWithAttributes:@{NSFontAttributeName:lblTitle.font}].width;
            }
            lblTitle.frame = CGRectMake(0 , 0, width,tabHeight);
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.text = [NSString stringWithFormat:@" %@",obj.title];
            
            [tabBtn addSubview:lblTitle];
            
            if(obj.icon)
            {
 //               iconRect = rect;
                rect.origin.x =lblTitle.frame.size.width;
                UIImageView *icon = [[UIImageView alloc]initWithFrame:rect];
                
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
        contentView = [(TabObj *)[objects objectAtIndex:selectedTab] view];
        contentView.frame = rectContent;
        [self addSubview:contentView];
    }
    return self;
}

//============================================
//============== Vertical mode ===============
//============================================
//
-(id)initMenuVerticalWithFrame:(CGRect)frame tabWidth:(CGFloat)width titleFont:(UIFont*)font iconRect:(CGRect)rect tabs:(NSArray *)objects andSelectedIndex:(int)index;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        if(!objects || objects.count == 0) return self;
        isHoriMode = false;
        selectedTab = 0;
        if (index < objects.count) {
            selectedTab = index;
        }
        tabsArr = objects;
        UIScrollView * scrTab = [[UIScrollView alloc]init];
        
        //setup frame for scroll tabs
        CGFloat tabWidth = width;
        CGRect scrRect = CGRectMake(0, 0, tabWidth, self.frame.size.height);

        scrTab.frame = scrRect;
        [scrTab setBounces:NO];
        [self addSubview:scrTab];
        
        //add tab buttons into scroll
        float next_y_origin = 0;
        for (int i = 0; i< objects.count; i++) {
            TabObj * obj = [objects objectAtIndex:i];
            UIButton * tabBtn = [[UIButton alloc]init];
            tabBtn.tag = i;
            tabBtn.backgroundColor = [UIColor yellowColor];
            if(i == selectedTab)
            {
                tabBtn.backgroundColor = [UIColor whiteColor];
                prevBtn = tabBtn;
                
            }
            [tabBtn addTarget:self action:@selector(didSelectTab:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrTab addSubview:tabBtn];
            
            
            UILabel * lblTitle = [[UILabel alloc]init];
            [lblTitle setLineBreakMode:NSLineBreakByCharWrapping];
            CGFloat lblHeight ;
            
            if ([[NSString stringWithFormat:@"%@",obj.title] respondsToSelector:@selector( sizeWithFont:) ]) {
                lblHeight =  [[NSString stringWithFormat:@"%@",obj.title] sizeWithFont:lblTitle.font].height * obj.title.length;
            }
            else
            {
                lblHeight =  [[NSString stringWithFormat:@"%@",obj.title] sizeWithAttributes:@{NSFontAttributeName:lblTitle.font}].height* obj.title.length;
            }
            
            
            lblTitle.numberOfLines = 0;
            lblTitle.frame = CGRectMake(0 , 0,tabWidth , lblHeight );
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.textAlignment = NSTextAlignmentCenter;
            
            
            lblTitle.text = obj.title;
            NSString * convString = @"";
            for (int n=(int)obj.title.length - 1; n > -1; --n) {
                
                convString = [NSString stringWithFormat:@"%@\n%@", [obj.title substringWithRange:NSMakeRange(n, 1)], convString];
                
                lblTitle.text = convString;
                
            }
            
            [tabBtn addSubview:lblTitle];
            
            if(obj.icon)
            {
  //             iconRect = rect;
                rect.origin.y = lblHeight;
                UIImageView *icon = [[UIImageView alloc]initWithFrame:rect];
                icon.image = obj.icon;
                
                [tabBtn addSubview:icon];
            }
            tabBtn.frame = CGRectMake(0, next_y_origin, tabWidth, tabWidth + lblHeight);
            //            [[tabBtn layer] setBorderWidth:1.0f];
            //            [[tabBtn layer] setBorderColor:[UIColor blackColor].CGColor];
            
            next_y_origin = next_y_origin + tabBtn.frame.size.height;
        }
        [scrTab setContentSize:CGSizeMake(tabWidth, next_y_origin)];
        
        //set view content
        rectContent = self.frame;
        rectContent.origin.x = tabWidth + 5;
        rectContent.origin.y = 0;

        rectContent.size.width = self.frame.size.width - (tabWidth + 5);
        contentView = [(TabObj *)[objects objectAtIndex:selectedTab] view];
        contentView.frame = rectContent;
        [self addSubview:contentView];

        
    }
    return self;
}
-(BOOL)isHorizontalMode;
{
    return isHoriMode;
}
-(int)selectedTabIndex;
{
    return selectedTab;
}
-(void)didSelectTab:(UIButton*)sender
{
    if(selectedTab == sender.tag) return;
    prevBtn.backgroundColor = [UIColor yellowColor];
    sender.backgroundColor = [UIColor whiteColor];
    
    selectedTab = (int)sender.tag;
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
