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
-(void)setAPIKey:(NSString *)newapikey;
-(void)setURL:(NSString *)newurl;

	//methods
-(NSString *)getUserID:(int)theID forKey:(NSString *)key;
-(NSString *)getStats:(NSString *)key;
-(NSString *)getSingleQuestions:(NSString *)ID forKey:(NSString *)key;

-(NSArray*)getQuestions:(NSString *)key;
-(NSArray*)getBadgesforKey:(NSString*)key hasCustomURL:(NSString *)customurl;
-(NSArray*)getTagsforKey:(NSString*)key;

-(NSString *)apikey;
-(NSString *)url;
-(NSArray *)connectMekThxBai:(NSString *)url firstkey:(NSString *)key1 secondkey:(NSString *)key2;



@end
