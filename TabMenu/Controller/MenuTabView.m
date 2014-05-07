//
//  MenuTabView.m
//  TabMenu
//
//  Created by NCXT on 03/05/2014.
//  Copyright (c) Năm 2014 NCXT. All rights reserved.
//

#import "MenuTabView.h"
#import "TabObj.h"

#define COVER_TAB_SPACE 10 //
#define _SPACE 10 // space between icon, title

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
        self.backgroundColor = [UIColor clearColor];
        if(!objects || objects.count == 0) return self;
        isHoriMode = true;
        selectedTab = 0;
        if (index < objects.count) {
            selectedTab = index;
        }
        iconRect = rect;

        tabsArr = objects;
        scrTab = [[UIScrollView alloc]init];
        
        curFont = font;
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
            tabBtn.backgroundColor = [UIColor clearColor];
            [tabBtn addTarget:self action:@selector(didSelectTab:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrTab addSubview:tabBtn];
            //set title
            UILabel * lblTitle = [[UILabel alloc]init];
            lblTitle.font = font;
            CGFloat width ;

            if ([[NSString stringWithFormat:@"%@",obj.title] respondsToSelector:@selector( sizeWithFont:) ]) {
                width =  [[NSString stringWithFormat:@"%@",obj.title] sizeWithFont:lblTitle.font].width;
            }
            else
            {
                width =  [[NSString stringWithFormat:@"%@",obj.title] sizeWithAttributes:@{NSFontAttributeName:lblTitle.font}].width;
            }
            lblTitle.frame = CGRectMake(_SPACE*2 , 0, width,tabHeight);
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.text = [NSString stringWithFormat:@"%@",obj.title];
            
            [tabBtn addSubview:lblTitle];
            CGFloat btnWidth = width + _SPACE*4;
            //check icon
            if(obj.icon)
            {
                CGRect imgRect = iconRect;
                imgRect.origin.x =lblTitle.frame.size.width+lblTitle.frame.origin.x+_SPACE;
                UIImageView *icon = [[UIImageView alloc]initWithFrame:imgRect];
                
                icon.image = obj.icon;
                btnWidth = btnWidth +rect.size.width+_SPACE;

                [tabBtn addSubview:icon];

                
            }
            tabBtn.frame = CGRectMake(next_x_origin, 0, btnWidth, tabHeight);

            
            
            [tabBtn setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-normal" ofType:@"png"]]] forState:UIControlStateNormal];
            if(i == selectedTab)
            {
                
                [tabBtn setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-active" ofType:@"png"]]] forState:UIControlStateNormal];
                prevBtn = tabBtn;
                
            }
            
            next_x_origin = next_x_origin + btnWidth;
        }
        [scrTab setContentSize:CGSizeMake(next_x_origin, tabHeight)];
        [scrTab setBackgroundColor:[UIColor clearColor]];
        //set view content
        rectContent = self.frame;
        rectContent.origin.y = tabHeight;
        rectContent.size.height = self.frame.size.height - tabHeight;
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
        curFont = font;
        if (index < objects.count) {
            selectedTab = index;
        }
        tabsArr = objects;
        scrTab = [[UIScrollView alloc]init];
        iconRect = rect;
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
            lblTitle.frame = CGRectMake(0 , _SPACE*2,tabWidth , lblHeight );
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.textAlignment = NSTextAlignmentCenter;
            
            
            lblTitle.text = obj.title;
            NSString * convString = @"";
            for (int n=(int)obj.title.length - 1; n > -1; --n) {
                
                convString = [NSString stringWithFormat:@"%@\n%@", [obj.title substringWithRange:NSMakeRange(n, 1)], convString];
                
                lblTitle.text = convString;
                
            }
            
            [tabBtn addSubview:lblTitle];
            CGFloat btnHeight = lblHeight + _SPACE*4;
            if(obj.icon)
            {
                CGRect imgRect = iconRect;
                imgRect.origin.y = _SPACE*2;
                UIImageView *icon = [[UIImageView alloc]initWithFrame:imgRect];
                icon.image = obj.icon;
                [tabBtn addSubview:icon];
                lblTitle.frame = CGRectMake( 0,_SPACE*3 + imgRect.size.height , tabWidth,lblHeight);
                
                btnHeight = btnHeight + imgRect.origin.y + imgRect.size.height;
                
            }

            tabBtn.frame = CGRectMake(0, next_y_origin, tabWidth, btnHeight  );

            [tabBtn setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-normal-vertical" ofType:@"png"]]] forState:UIControlStateNormal];
            if(i == selectedTab)
            {

                [tabBtn setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-active-vertical" ofType:@"png"]]] forState:UIControlStateNormal];
                prevBtn = tabBtn;
                
            }

            
            next_y_origin = next_y_origin + btnHeight;

        }
        [scrTab setContentSize:CGSizeMake(tabWidth, next_y_origin)];
        
        //set view content
        rectContent = self.frame;
        rectContent.origin.x = tabWidth ;
        rectContent.origin.y = 0;

        rectContent.size.width = self.frame.size.width - tabWidth ;
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
//scale tab background
-(UIImage*)standarScaleWithImage:(UIImage *)imgStandar
{
    if (isHoriMode) {
        return [imgStandar resizableImageWithCapInsets:UIEdgeInsetsMake(imgStandar.size.height/2, COVER_TAB_SPACE * 2, imgStandar.size.height/2,COVER_TAB_SPACE * 2)];
    }
    else  return [imgStandar resizableImageWithCapInsets:UIEdgeInsetsMake(COVER_TAB_SPACE * 2, imgStandar.size.width/2, COVER_TAB_SPACE * 2, imgStandar.size.width/2)];
}
-(void)didSelectTab:(UIButton*)sender
{
    if(selectedTab == sender.tag) return;

    if (isHoriMode) {
        [prevBtn setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-normal" ofType:@"png"]]] forState:UIControlStateNormal];
        
        [sender setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-active" ofType:@"png"]]]  forState:UIControlStateNormal];
    }
    else {

        [prevBtn setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-normal-vertical" ofType:@"png"]]] forState:UIControlStateNormal];
        
        [sender setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-active-vertical" ofType:@"png"]]] forState:UIControlStateNormal];
    }

    
    selectedTab = (int)sender.tag;
    TabObj * tab = [tabsArr objectAtIndex:selectedTab];
    [contentView removeFromSuperview];
    contentView = tab.view;
    contentView.frame = rectContent;
    [self addSubview:contentView];
    prevBtn = sender;
    if(isOrderMode)[self orderTabs];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



-(void)fixTabFrame;
{
    
    isOrderMode = true;
    if (isHoriMode) {
        UIImage *imgStandarNormal = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-normal" ofType:@"png"]];

        float heightToFix = imgStandarNormal.size.height;
        [scrTab removeFromSuperview];
        scrTab = nil;
        scrTab = [[UIScrollView alloc]init];
        if (!buttonsArr) {
            buttonsArr = [[NSMutableArray alloc]init];
        }
        [buttonsArr removeAllObjects];

        //setup frame for scroll tabs
        CGFloat tabHeight = heightToFix;
        
        CGRect scrRect= CGRectMake(0, 0, self.frame.size.width, tabHeight);
        
        scrTab.frame = scrRect;
        [scrTab setBounces:NO];
        [self addSubview:scrTab];
        
        //add tab buttons into scroll
        float next_x_origin = 0;
        for (int i = 0; i< tabsArr.count; i++) {
            TabObj * obj = [tabsArr objectAtIndex:i];
            UIButton * tabBtn = [[UIButton alloc]init];
            tabBtn.tag = i;
            tabBtn.backgroundColor = [UIColor clearColor];
            [tabBtn addTarget:self action:@selector(didSelectTab:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrTab addSubview:tabBtn];
            
            UILabel * lblTitle = [[UILabel alloc]init];
            lblTitle.font = curFont;
            CGFloat width ;
            
            if ([[NSString stringWithFormat:@"%@",obj.title] respondsToSelector:@selector( sizeWithFont:) ]) {
                width =  [[NSString stringWithFormat:@"%@",obj.title] sizeWithFont:lblTitle.font].width;
            }
            else
            {
                width =  [[NSString stringWithFormat:@"%@",obj.title] sizeWithAttributes:@{NSFontAttributeName:lblTitle.font}].width;
            }
            lblTitle.frame = CGRectMake(_SPACE*2 , 0, width,tabHeight);
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.text = [NSString stringWithFormat:@"%@",obj.title];
            
            [tabBtn addSubview:lblTitle];
            CGFloat btnWidth = width + _SPACE*4;
            if(obj.icon)
            {
                CGRect rect = iconRect;
                rect.origin.x =rect.origin.x+_SPACE*2;
                UIImageView *icon = [[UIImageView alloc]initWithFrame:rect];
                
                icon.image = obj.icon;

                [tabBtn addSubview:icon];
                lblTitle.frame = CGRectMake(_SPACE*3 + rect.size.width , 0, width,tabHeight);
                btnWidth = btnWidth + rect.size.width + _SPACE;

            }
            tabBtn.frame = CGRectMake(next_x_origin, 0, btnWidth, tabHeight);
            //scale image for button background
            //standar image rect
            

            [tabBtn setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-normal" ofType:@"png"]]] forState:UIControlStateNormal];
            if(i == selectedTab)
            {

                [tabBtn setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-active" ofType:@"png"]]] forState:UIControlStateNormal];
                prevBtn = tabBtn;
                
            }
            next_x_origin = next_x_origin + btnWidth - COVER_TAB_SPACE;
            [buttonsArr addObject:tabBtn];
            
        }
        [scrTab setContentSize:CGSizeMake(next_x_origin + COVER_TAB_SPACE, tabHeight)];
        [scrTab setBackgroundColor:[UIColor clearColor]];
        [self orderTabs];
        //set view content
        rectContent = self.frame;
        rectContent.origin.y = tabHeight;
        rectContent.size.height = self.frame.size.height - tabHeight ;
        contentView = [(TabObj *)[tabsArr objectAtIndex:selectedTab] view];
        contentView.frame = rectContent;
        [self addSubview:contentView];

    }
    else
    {
    
        UIImage *imgStandarNormal = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-normal-vertical" ofType:@"png"]];
        [scrTab removeFromSuperview];
        scrTab = nil;
        scrTab = [[UIScrollView alloc]init];
        if (!buttonsArr) {
            buttonsArr = [[NSMutableArray alloc]init];
        }
        
        [buttonsArr removeAllObjects];
        //setup frame for scroll tabs
        CGFloat tabWidth = imgStandarNormal.size.width;
        CGRect scrRect = CGRectMake(0, 0, tabWidth, self.frame.size.height);
        
        scrTab.frame = scrRect;
        [scrTab setBounces:NO];
        [self addSubview:scrTab];
        
        //add tab buttons into scroll
        float next_y_origin = 0;
        for (int i = 0; i< tabsArr.count; i++) {
            TabObj * obj = [tabsArr objectAtIndex:i];
            UIButton * tabBtn = [[UIButton alloc]init];
            tabBtn.tag = i;
            [tabBtn addTarget:self action:@selector(didSelectTab:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrTab addSubview:tabBtn];
            
            
            UILabel * lblTitle = [[UILabel alloc]init];
            [lblTitle setLineBreakMode:NSLineBreakByCharWrapping];
            CGFloat lblHeight ;
            lblTitle.font = curFont;

            if ([[NSString stringWithFormat:@"%@",obj.title] respondsToSelector:@selector( sizeWithFont:) ]) {
                lblHeight =  [[NSString stringWithFormat:@"%@",obj.title] sizeWithFont:lblTitle.font].height * obj.title.length;
            }
            else
            {
                lblHeight =  [[NSString stringWithFormat:@"%@",obj.title] sizeWithAttributes:@{NSFontAttributeName:lblTitle.font}].height* obj.title.length;
            }
            
            
            lblTitle.numberOfLines = 0;
            lblTitle.frame = CGRectMake(0 , _SPACE*2,tabWidth , lblHeight );
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.textAlignment = NSTextAlignmentCenter;
            
            
            lblTitle.text = obj.title;
            NSString * convString = @"";
            for (int n=(int)obj.title.length - 1; n > -1; --n) {
                
                convString = [NSString stringWithFormat:@"%@\n%@", [obj.title substringWithRange:NSMakeRange(n, 1)], convString];
                
                lblTitle.text = convString;
                
            }
            
            [tabBtn addSubview:lblTitle];
            CGFloat btnHeight = lblHeight + _SPACE*4;
            if(obj.icon)
            {
                CGRect imgRect = iconRect;
                imgRect.origin.y = _SPACE*2;
                UIImageView *icon = [[UIImageView alloc]initWithFrame:imgRect];
                icon.image = obj.icon;
                [tabBtn addSubview:icon];
                lblTitle.frame = CGRectMake( 0,_SPACE*3 + imgRect.size.height , tabWidth,lblHeight);

                btnHeight = btnHeight + _SPACE + imgRect.size.height;

            }
            tabBtn.frame = CGRectMake(0, next_y_origin, tabWidth, btnHeight  );

            [tabBtn setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-normal-vertical" ofType:@"png"]]] forState:UIControlStateNormal];
            if(i == selectedTab)
            {

                [tabBtn setBackgroundImage:[self standarScaleWithImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab-active-vertical" ofType:@"png"]]] forState:UIControlStateNormal];
                prevBtn = tabBtn;
                
            }
            [buttonsArr addObject:tabBtn];
            //            [[tabBtn layer] setBorderWidth:1.0f];
            //            [[tabBtn layer] setBorderColor:[UIColor blackColor].CGColor];
            
            next_y_origin = next_y_origin + btnHeight - COVER_TAB_SPACE;
            
        }
        [scrTab setContentSize:CGSizeMake(tabWidth, next_y_origin +COVER_TAB_SPACE)];
        [self orderTabs];

        //set view content
        rectContent = self.frame;
        rectContent.origin.x = tabWidth ;
        rectContent.origin.y = 0;
        
        rectContent.size.width = self.frame.size.width - tabWidth ;
        contentView = [(TabObj *)[tabsArr objectAtIndex:selectedTab] view];
        contentView.frame = rectContent;
        [self addSubview:contentView];
        
        
    
    }
}

-(void)orderTabs
{
    for (int i = (int)buttonsArr.count-1; i >=0; i--) {
        [scrTab bringSubviewToFront:[buttonsArr objectAtIndex:i]];
    }
    [scrTab bringSubviewToFront:[buttonsArr objectAtIndex:selectedTab]];

}
@end
