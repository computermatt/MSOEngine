//
//  MSOEngine.h
//  MSOEngine
//
//  Created by Matt on 4/6/10.
//  Copyright 2010 Matt's Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JSON.h"


@interface MSOEngine : NSObject {
	NSString *_apikey;
	NSString *_url;
	
}

	//required
-(void)initWithAPIKey:(NSString *)newapikey;
-(void)initWithURL:(NSString *)newurl;
-(NSString*)initWithDataforURL:(NSString *)url;
-(NSString*)getVersion;
	//methods

-(NSString *)getUserID:(int)theID forKey:(NSString *)key andData:(NSString *)data;
-(NSString *)getStats:(NSString *)key andData:(NSString *)data;

-(NSString *)getBadgeCount:(NSString *)key andData:(NSString *)data;

-(NSArray*)getQuestions:(NSString *)key andData:(NSString *)data;
-(NSArray*)getBadgesforKey:(NSString*)key hasCustomURL:(NSString *)customurl andData:(NSString *)data;
-(NSArray*)getTagsforKey:(NSString*)key andData:(NSString *)data;

-(NSArray *)connectMekThxBai:(NSString *)data firstkey:(NSString *)key1 secondkey:(NSString *)key2;
-(NSArray*)getAnswers:(NSString *)key  andData:(NSString *)data;


//New methods
-(NSArray*)getSingleAnswers:(NSString *)key andData:(NSString *)data;
-(NSArray*)getOwnerfromAnswers:(NSString *)key andData:(NSString *)data;
-(NSString *)getSingleQuestions:(NSString *)key andData:(NSString *)data;
-(NSString*)getOwnerfromQuestions:(NSString *)key andData:(NSString *)data;


//Deprecated
-(NSArray*)getAnswersforID:(NSString*)ID forKey:(NSString *)key andData:(NSString *)data DEPRECATED_ATTRIBUTE;
-(NSArray*)getOwnerfromAnswers:(NSString *)key forID:(NSString *)ID andData:(NSString *)data DEPRECATED_ATTRIBUTE;
-(NSString *)getSingleQuestions:(NSString *)ID forKey:(NSString *)key andData:(NSString *)data DEPRECATED_ATTRIBUTE;
-(NSString*)getOwnerfromQuestions:(NSString *)key forID:(NSString *)ID andData:(NSString *)data DEPRECATED_ATTRIBUTE;

@end
