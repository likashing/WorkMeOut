//
//  Global.h
//  WorkMeOut
//
//  Created by LiKaShing on 27/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCRN_WIDTH		[[UIScreen mainScreen] bounds].size.width
#define SCRN_HEIGHT		[[UIScreen mainScreen] bounds].size.height

#define IS_PHONE5 SCRN_HEIGHT > 480 ? TRUE:FALSE

#define APPDELEGATE [AppDelegate sharedAppDelegate]
#define SERVER_URL @"http://beinmedia.com/clients/workmeout/api/"


typedef enum {
    
    ADD_ALLERGIC,
    GET_ALLERGIC,
    DEL_ALLERGIC
    
} REQUEST_ALLERGIC;

typedef enum {
    
    ADD_UNWANTED_FOOD,
    GET_UNWANTED_FOOD,
    DEL_UNWANTED_FOOD

} REQUEST_UNWANTED_FOOD;

typedef enum {
    
    FREE_MEMBER,
    PAID_MEMBER

} MEMBER_KIND;


typedef enum {
    
    WITH_BODYPART,
    WITHOUT_BODYPART

} EXERCISE_ROUT;

typedef enum {
    
    GET_DIRECTORY,
    GET_COMMENTS,
    ADD_COMMENT
    
} DIRECTORYPART;


@interface Global : NSObject






@end
