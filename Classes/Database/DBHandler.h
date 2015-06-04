//
//  DBHandler.h
//  WorkMeOut
//
//  Created by LiKaShing on 30/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DBHandler : NSObject





-(sqlite3 *) openDatabase;

-(void)insertDBInfoList:(NSMutableArray *)list;

-(void)deleteDBInfoList;

-(NSMutableArray *)getDBInfoList:(NSMutableArray *)array;
-(NSMutableArray *)getDBResult:(NSMutableArray *)array query:(NSString *)strQuery;

//Body Part
-(void)insertDBInfoList01:(NSMutableArray *)list;
-(NSMutableArray *)getDBInfoList01:(NSMutableArray *)array;

//Article Category
-(void)insertDBInfoListArtCategory:(NSMutableArray *)list;
-(NSMutableArray *)getDBInfoListArtCategory:(NSMutableArray *)array;

//Article Sub Category
-(void)insertDBInfoListArtSubCategory:(NSMutableArray *)list;
-(NSMutableArray *)getDBInfoListArtSubCategory:(NSMutableArray *)array;






@end
