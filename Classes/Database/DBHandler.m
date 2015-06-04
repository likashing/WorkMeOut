//
//  DBHandler.m
//  WorkMeOut
//
//  Created by LiKaShing on 30/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//


#define strDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define strResourcePath [[NSBundle mainBundle] resourcePath]
#define DATABASE_NAME	@"reponse_data.sqlite"


#import "DBHandler.h"
#import "AppDelegate.h"


@implementation DBHandler

- (id)init
{
    self = [super init];
    return self;
    
}

-(sqlite3 *) openDatabase
{
    NSString *dbPath = [NSString stringWithFormat:@"%@/%@", strDocumentPath,DATABASE_NAME];
    
    NSLog(@"DB Data Path :%@", dbPath);
    
    sqlite3 *database = nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath])
    {
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS tbl_exercise_library (cpi_id INTEGER PRIMARY KEY, ci_bodypart_id TEXT, ci_name TEXT, ci_secondary_muscle TEXT, ci_equipment TEXT, ci_image_url TEXT)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                sqlite3_close(database);
                return nil;
            }
        }
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS tbl_bodysub_part (cpi_id INTEGER PRIMARY KEY, ci_bodypart_id TEXT, ci_name TEXT)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                sqlite3_close(database);
                return nil;
            }
        }
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS tbl_article_category (cpi_id INTEGER PRIMARY KEY, ci_article_category_id TEXT, ci_name TEXT)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                sqlite3_close(database);
                return nil;
            }
        }
        
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS tbl_article_subcategory (cpi_article_id INTEGER PRIMARY KEY, ci_article_subcategory_title TEXT, ci_updated_at TEXT)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                sqlite3_close(database);
                return nil;
            }
        }



    }
    else
    {
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
            //NSLog(@"Error : %s, ", sqlite3_errmsg(database));
            
            return database;
    }
    return nil;
}


-(void)insertDBInfoList:(NSMutableArray *)list
{
    
    //[self deleteDBInfoList];
    
    sqlite3_stmt *stmt = nil;
    sqlite3 *database = [self openDatabase];
    if (database)
    {
        const char *sql = "insert into tbl_exercise_library (cpi_id, ci_bodypart_id, ci_name, ci_secondary_muscle, ci_equipment, ci_image_url) Values(?, ?, ?, ?, ?, ?)";
        if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK)
        {
            sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, NULL);
            for (int i = 0; i < list.count; i++)
            {
                ReceivedInfo *info = [list objectAtIndex:i];
                
                sqlite3_bind_text(stmt, 1, [info.body_id UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 2, [info.body_subpart_id UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 3, [info.body_subpart_name UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 4, [info.body_secondary_muscle UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 5, [info.body_equipment UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 6, [info.body_image UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_step(stmt);
                
                sqlite3_clear_bindings(stmt);
                sqlite3_reset(stmt);
            }
            
            sqlite3_exec(database, "END TRANSACTION", NULL, NULL, NULL);
            sqlite3_finalize(stmt);
        }
        NSLog(@"Error : %s, ", sqlite3_errmsg(database));
        sqlite3_close(database);
    }
}

-(void)deleteDBInfoList
{
    sqlite3 *database = [self openDatabase];
    if (database)
    {
        const char *sql = "DELETE FROM tbl_exercise_library;";
        sqlite3_exec(database, sql, NULL, NULL, NULL);
        //NSLog(@"Error : %s, ", sqlite3_errmsg(database));
        sqlite3_close(database);
    }
}

-(NSMutableArray *)getDBInfoList:(NSMutableArray *)array
{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT cpi_id, ci_bodypart_id, ci_name, ci_secondary_muscle, ci_equipment, ci_image_url FROM tbl_exercise_library"];
    return [self getDBResult:array query:strQuery];
}


-(NSMutableArray *)getDBResult:(NSMutableArray *)array query:(NSString *)strQuery
{
    [array removeAllObjects];
    
    sqlite3_stmt *stmt = nil;
    sqlite3 *database = [self openDatabase];
    if (database)
    {
        const char *sql = [strQuery UTF8String];
        if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                ReceivedInfo *info = [[ReceivedInfo alloc] init];
                info.body_id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
                info.body_subpart_id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
                info.body_subpart_name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
                info.body_secondary_muscle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
                info.body_equipment = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)];
                info.body_image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
                
                [array addObject:info];
            }
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(database);
    }
    
    return array;
}


////////////////////===========**********===========/////////////////////
////////////////////=======Body Sub Part Data DB======///////////////////


-(void)insertDBInfoList01:(NSMutableArray *)list
{
    
    //[self deleteDBInfoList];
    
    sqlite3_stmt *stmt = nil;
    sqlite3 *database = [self openDatabase];
    if (database)
    {
        const char *sql = "insert into tbl_bodysub_part (cpi_id, ci_bodypart_id, ci_name) Values(?, ?, ?)";
        if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK)
        {
            sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, NULL);
            for (int i = 0; i < list.count; i++)
            {
                NSDictionary *dict = [list objectAtIndex:i];
                
                sqlite3_bind_text(stmt, 1, [[dict objectForKey:@"id"] UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 2, [[dict objectForKey:@"body_part_id"] UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 3, [[dict objectForKey:@"name"] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_step(stmt);
                
                sqlite3_clear_bindings(stmt);
                sqlite3_reset(stmt);
            }
            
            sqlite3_exec(database, "END TRANSACTION", NULL, NULL, NULL);
            sqlite3_finalize(stmt);
        }
        NSLog(@"Error : %s, ", sqlite3_errmsg(database));
        sqlite3_close(database);
    }
}

-(NSMutableArray *)getDBInfoList01:(NSMutableArray *)array
{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT cpi_id, ci_bodypart_id, ci_name FROM tbl_bodysub_part"];
    return [self getDBResult01:array query:strQuery];
}


-(NSMutableArray *)getDBResult01:(NSMutableArray *)array query:(NSString *)strQuery
{
    [array removeAllObjects];
    
    sqlite3_stmt *stmt = nil;
    sqlite3 *database = [self openDatabase];
    if (database)
    {
        const char *sql = [strQuery UTF8String];
        if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                ReceivedInfo *info = [[ReceivedInfo alloc] init];
                info.body_id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
                info.body_subpart_id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
                info.body_subpart_name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
                
                [array addObject:info];
            }
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(database);
    }
    
    return array;
}

////////////////////===========**********===========/////////////////////
////////////////////=======Articles Category Part Data DB======///////////////////


-(void)insertDBInfoListArtCategory:(NSMutableArray *)list
{
    
    //[self deleteDBInfoList];
    
    sqlite3_stmt *stmt = nil;
    sqlite3 *database = [self openDatabase];
    if (database)
    {
        const char *sql = "insert into tbl_article_category (cpi_id, ci_article_category_id, ci_name) Values(?, ?, ?)";
        if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK)
        {
            sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, NULL);
            for (int i = 0; i < list.count; i++)
            {
                NSDictionary *dict = [list objectAtIndex:i];
                
                sqlite3_bind_text(stmt, 1, [[dict objectForKey:@"id"] UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 2, [[dict objectForKey:@"article_category_id"] UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 3, [[dict objectForKey:@"name"] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_step(stmt);
                
                sqlite3_clear_bindings(stmt);
                sqlite3_reset(stmt);
            }
            
            sqlite3_exec(database, "END TRANSACTION", NULL, NULL, NULL);
            sqlite3_finalize(stmt);
        }
        NSLog(@"Error : %s, ", sqlite3_errmsg(database));
        sqlite3_close(database);
    }
}

-(NSMutableArray *)getDBInfoListArtCategory:(NSMutableArray *)array
{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT cpi_id, ci_article_category_id, ci_name FROM tbl_article_category"];
    return [self getDBResultArtCategory:array query:strQuery];
}


-(NSMutableArray *)getDBResultArtCategory:(NSMutableArray *)array query:(NSString *)strQuery
{
    [array removeAllObjects];
    
    sqlite3_stmt *stmt = nil;
    sqlite3 *database = [self openDatabase];
    if (database)
    {
        const char *sql = [strQuery UTF8String];
        if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                ReceivedInfo *info = [[ReceivedInfo alloc] init];
                info.body_id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
                info.body_subpart_id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
                info.body_subpart_name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
                
                [array addObject:info];
            }
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(database);
    }
    
    return array;
}

////////////////////===========**********===========/////////////////////
////////////////////=======Article Sub Category Part Data DB======///////////////////

-(void)insertDBInfoListArtSubCategory:(NSMutableArray *)list
{
    
    //[self deleteDBInfoList];
    
    sqlite3_stmt *stmt = nil;
    sqlite3 *database = [self openDatabase];
    if (database)
    {
        const char *sql = "insert into tbl_article_subcategory (cpi_article_id, ci_article_subcategory_title, ci_updated_at) Values(?, ?, ?)";
        if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK)
        {
            sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, NULL);
            for (int i = 0; i < list.count; i++)
            {
                NSDictionary *dict = [list objectAtIndex:i];
                
                sqlite3_bind_text(stmt, 1, [[dict objectForKey:@"id"] UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 2, [[dict objectForKey:@"title"] UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 3, [[dict objectForKey:@"updated_at"] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_step(stmt);
                
                sqlite3_clear_bindings(stmt);
                sqlite3_reset(stmt);
            }
            
            sqlite3_exec(database, "END TRANSACTION", NULL, NULL, NULL);
            sqlite3_finalize(stmt);
        }
        NSLog(@"Error : %s, ", sqlite3_errmsg(database));
        sqlite3_close(database);
    }
}

-(NSMutableArray *)getDBInfoListArtSubCategory:(NSMutableArray *)array
{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT cpi_article_id, ci_article_subcategory_title, ci_updated_at FROM tbl_article_subcategory"];
    return [self getDBResultArtSubCategory:array query:strQuery];
}


-(NSMutableArray *)getDBResultArtSubCategory:(NSMutableArray *)array query:(NSString *)strQuery
{
    [array removeAllObjects];
    
    sqlite3_stmt *stmt = nil;
    sqlite3 *database = [self openDatabase];
    if (database)
    {
        const char *sql = [strQuery UTF8String];
        if(sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                ReceivedInfo *info = [[ReceivedInfo alloc] init];
                info.body_id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
                info.body_subpart_id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
                info.body_subpart_name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
                
                [array addObject:info];
            }
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(database);
    }
    
    return array;
}


- (NSString *) getNotNullValue:(NSObject *) param
{
    if (param == [NSNull null])
    {
        return @"";
    }
    
    return (NSString *)param;
}


@end
