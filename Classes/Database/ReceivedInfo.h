//
//  ReceivedInfo.h
//  WorkMeOut
//
//  Created by LiKaShing on 30/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceivedInfo : NSObject

//edit_my_profile
@property (strong, nonatomic) NSDictionary  *dict_allergic;
@property (strong, nonatomic) NSString      *allergic_id;
@property (strong, nonatomic) NSString      *allergic_name;

@property (strong, nonatomic) NSDictionary  *dict_unwantedFood;
@property (strong, nonatomic) NSString      *unwanted_food_id;
@property (strong, nonatomic) NSString      *unwanted_food_name;

@property (strong, nonatomic) NSString      *condition_name;

@property (strong, nonatomic) NSString      *special_note;

@property (strong, nonatomic) NSMutableArray *arrAllergic;
@property (strong, nonatomic) NSMutableArray *arrUnwantedFood;


//get_exercises
@property (strong, nonatomic) NSDictionary  *dict_get_exercises;
@property (strong, nonatomic) NSString      *body_id;
@property (strong, nonatomic) NSString      *body_subpart_id;
@property (strong, nonatomic) NSString      *body_subpart_name;
@property (strong, nonatomic) NSString      *body_primary_muscle;
@property (strong, nonatomic) NSString      *body_secondary_muscle;
@property (strong, nonatomic) NSString      *body_equipment;
@property (strong, nonatomic) NSString      *body_image;
@property (strong, nonatomic) NSMutableArray    *arr_get_exercises;



@property (strong, nonatomic) NSString      *exercise_id;

//get_exercise_steps
@property (strong, nonatomic) NSDictionary  *dict_get_steps;
@property (strong, nonatomic) NSString      *step_id;
@property (strong, nonatomic) NSString      *step_index;
@property (strong, nonatomic) NSString      *step_name;
@property (strong, nonatomic) NSString      *step_description;
@property (strong, nonatomic) NSString      *step_image;

//workout_library part
@property (strong, nonatomic) NSString      *trainee_program_id;
@property (strong, nonatomic) NSString      *frequency;

@property (strong, nonatomic) NSString      *workout_day_id;
@property (strong, nonatomic) NSString      *workday_title;
@property (strong, nonatomic) NSString      *weekday;

//get_free_activities/incomplete
@property (strong, nonatomic) NSString      *workout_program_name;
@property (strong, nonatomic) NSString      *progress;
@property (strong, nonatomic) NSString      *created_at;
@property (strong, nonatomic) NSString      *updated_at;

//get_article/article category
@property (strong, nonatomic) NSMutableArray *arrArtCategory;
@property (strong, nonatomic) NSMutableArray *arrArticles;

























@end
