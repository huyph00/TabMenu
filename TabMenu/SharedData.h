//
//  SharedData.h
//  TabMenu
//
//  Created by NCXT on 03/05/2014.
//  Copyright (c) Năm 2014 NCXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedData : NSObject


@property(nonatomic)BOOL isIpad;
+ (UIImage *)imageWithBundle:(NSString *)bundle scaledToSize:(CGSize)newSize ;

+ (SharedData*)sharedInstance;
@end
