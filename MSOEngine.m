//
//  MSOEngine.m
//  MSOEngine
//
//  Created by Matt on 4/6/10.
//  Copyright 2010 Matt's Apps. All rights reserved.
//

#import "MSOEngine.h"


@implementation MSOEngine


-(NSString*)initWithDataforURL:(NSString *)data
{
	NSString *theURL = [[NSString alloc] initWithFormat:@"%@%@key=%@", _url, data, _apikey];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:theURL]];
	
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	return json_string;
}

-(void)initWithAPIKey:(NSString *)newapikey
{
	[_apikey release];
	_apikey = [newapikey retain];

}
-(void)initWithURL:(NSString *)newurl
{
	[_url release];
	_url = [newurl retain];
}


-(NSArray *)connectMekThxBai:(NSString *)data firstkey:(NSString *)key1 secondkey:(NSString *)key2
{
	NSMutableArray *array;// = [NSMutableArray array];
	array = [[NSMutableArray alloc] init];
	SBJSON *parser = [[SBJSON alloc] init];
	
	NSMutableDictionary *jsonObj = [parser objectWithString:data error:nil];
	NSArray *two = [jsonObj objectForKey:key1];

		for (NSDictionary *one in two)
		{
			if ([one objectForKey:key2] != nil)
			{
				[array addObject:[one objectForKey:key2]];

			}
			else {
				[array addObject:@""];
			}

		}
		
	return array;

}
-(NSArray*)getOwnerfromAnswers:(NSString *)key forID:(NSString *)ID andData:(NSString *)data
{
	//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@questions/%@/answers?key=%@&body=true",_url, ID, _apikey];
	
	NSMutableArray *array;// = [NSMutableArray array];
	array = [[NSMutableArray alloc] init];
	SBJSON *parser = [[SBJSON alloc] init];
	
	// parse the JSON response into an object
	// Here we're using NSArray since we're parsing an array of JSON status objects
	NSMutableDictionary *jsonObj = [parser objectWithString:data error:nil];
	NSArray *two = [jsonObj objectForKey:@"answers"];
	for (NSDictionary *one in two)
	{
		if ([[one valueForKey:@"owner"] valueForKey:key] != nil)
		{
			[array addObject:[[one valueForKey:@"owner"] valueForKey:key]];
			
		}
		else {
			[array addObject:@""];
		}
	}
	return array;
	
	
}
-(NSString*)getOwnerfromQuestions:(NSString *)key forID:(NSString *)ID andData:(NSString *)data
{
	//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@questions/%@?key=%@",_url, ID, _apikey];
	
	NSMutableArray *array;// = [NSMutableArray array];
	array = [[NSMutableArray alloc] init];
	SBJSON *parser = [[SBJSON alloc] init];
	
	// parse the JSON response into an object
	// Here we're using NSArray since we're parsing an array of JSON status objects
	NSMutableDictionary *jsonObj = [parser objectWithString:data error:nil];
	
	NSArray *two = [jsonObj objectForKey:@"questions"]; 
	for (NSDictionary *one in two)
	{
		if ([[one valueForKey:@"owner"] valueForKey:key] != nil)
		{
			[array addObject:[[one valueForKey:@"owner"] valueForKey:key]];
			
		}
		else {
			[array addObject:@" "];
		}
	}
	
	NSString *final = [array objectAtIndex:0];
	return final;
	
}
-(NSString *)getBadgeCount:(NSString *)key andData:(NSString *)data
{
	NSMutableArray *array;// = [NSMutableArray array];
	array = [[NSMutableArray alloc] init];
	SBJSON *parser = [[SBJSON alloc] init];
	
	// parse the JSON response into an object
	// Here we're using NSArray since we're parsing an array of JSON status objects
	NSMutableDictionary *jsonObj = [parser objectWithString:data error:nil];
	
	NSArray *two = [jsonObj objectForKey:@"users"]; 
	for (NSDictionary *one in two)
	{
		if ([[one valueForKey:@"badge_counts"] valueForKey:key] != nil)
		{
			[array addObject:[[one valueForKey:@"badge_counts"] valueForKey:key]];
			
		}
		else {
			[array addObject:@"0"];
		}
	}
	
	NSString *final = [array objectAtIndex:0];
	return final;
}
-(NSString *)getUserID:(int)theID forKey:(NSString *)key andData:(NSString *)data
{
	
	//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@users/%d?key=%@",_url, theID, _apikey];
	NSArray *array = [self connectMekThxBai:data 
								   firstkey:@"users" 
								  secondkey:key];
	NSString *result = [array objectAtIndex:0];
//	NSLog(@"%@", result);
	return result;
}
-(NSString *)getStats:(NSString *)key andData:(NSString *)data
{
	
	//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@stats?key=%@",_url, _apikey];
	NSArray *array = [self connectMekThxBai:data 
								   firstkey:@"statistics" 
								  secondkey:key];
	NSString *result = [array objectAtIndex:0];
	return result;
}
-(NSString *)getSingleQuestions:(NSString *)ID forKey:(NSString *)key andData:(NSString *)data
{
	//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@questions/%@?key=%@",_url, ID, _apikey];
	NSArray *array = [self connectMekThxBai:data 
								   firstkey:@"questions" 
								  secondkey:key];
	NSString *result = [array objectAtIndex:0];
	
	return result;
	
}
-(NSArray*)getBadgesforKey:(NSString*)key hasCustomURL:(NSString *)customurl andData:(NSString *)data
{
	if (customurl == nil) {
		//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@badges?key=%@",_url, _apikey];
		NSArray *result = [self connectMekThxBai:data 
										firstkey:@"badges" 
									   secondkey:key];
		return result;
		
	}
	else {
		//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@%@?key=%@",_url,customurl,_apikey];
		NSArray *result = [self connectMekThxBai:data 
										firstkey:@"badges" 
									   secondkey:key];
		return result;
	}
	
	
}


-(NSArray*)getQuestions:(NSString *)key andData:(NSString *)data
{
//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@questions?key=%@&body=true",_url, _apikey];
	NSArray *result = [self connectMekThxBai:data 
									firstkey:@"questions" 
								   secondkey:key];
	return result;
}

-(NSArray*)getAnswersforID:(NSString*)ID forKey:(NSString *)key andData:(NSString *)data
{
//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@questions/%@/answers?key=%@&body=true",_url, ID, _apikey];
	NSArray *result = [self connectMekThxBai:data 
									firstkey:@"answers" 
								   secondkey:key];
	return result;
}
-(NSArray*)getTagsforKey:(NSString*)key andData:(NSString *)data
{
//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@tags?key=%@",_url, _apikey];
	NSArray *result = [self connectMekThxBai:data 
									firstkey:@"tags" 
								   secondkey:key];
	return result;
}
-(NSArray*)getAnswers:(NSString *)key  andData:(NSString *)data
{
	//	NSString *theURL = [[NSString alloc] initWithFormat:@"%@questions/%@?key=%@",_url, ID, _apikey];
	
	NSMutableArray *array;// = [NSMutableArray array];
	array = [[NSMutableArray alloc] init];
	SBJSON *parser = [[SBJSON alloc] init];
	
	// parse the JSON response into an object
	// Here we're using NSArray since we're parsing an array of JSON status objects
	NSMutableDictionary *jsonObj = [parser objectWithString:data error:nil];
	
	NSArray *two = [jsonObj objectForKey:@"questions"]; 
	for (NSDictionary *one in two)
	{
		if ([[one valueForKey:@"answers"] valueForKey:key] != nil)
		{
			[array addObject:[[one valueForKey:@"answers"] valueForKey:key]];
			
		}
		else {
			[array addObject:@" "];
		}
	}
	return [array autorelease];
	
}
-(NSString*)getVersion
{

	return @"1.1";

}

-(NSArray*)getSingleAnswers:(NSString *)key andData:(NSString *)data
{
	NSArray *result = [self connectMekThxBai:data 
									firstkey:@"answers" 
								   secondkey:key];
	return result;
	
}
-(NSArray*)getOwnerfromAnswers:(NSString *)key andData:(NSString *)data
{
	
	NSMutableArray *array;
	array = [[NSMutableArray alloc] init];
	SBJSON *parser = [[SBJSON alloc] init];
	
	NSMutableDictionary *jsonObj = [parser objectWithString:data error:nil];
	NSArray *two = [jsonObj objectForKey:@"answers"];
	for (NSDictionary *one in two)
	{
		if ([[one valueForKey:@"owner"] valueForKey:key] != nil)
		{
			[array addObject:[[one valueForKey:@"owner"] valueForKey:key]];
			
		}
		else {
			[array addObject:@""];
		}
	}
	return array;
	
}
-(NSString *)getSingleQuestions:(NSString *)key andData:(NSString *)data
{
	NSArray *array = [self connectMekThxBai:data 
								   firstkey:@"questions" 
								  secondkey:key];
	NSString *result = [array objectAtIndex:0];
	
	return result;
		
}
-(NSString*)getOwnerfromQuestions:(NSString *)key andData:(NSString *)data
{
	NSMutableArray *array;
	array = [[NSMutableArray alloc] init];
	SBJSON *parser = [[SBJSON alloc] init];
	
	NSMutableDictionary *jsonObj = [parser objectWithString:data error:nil];
	
	NSArray *two = [jsonObj objectForKey:@"questions"]; 
	for (NSDictionary *one in two)
	{
		if ([[one valueForKey:@"owner"] valueForKey:key] != nil)
		{
			[array addObject:[[one valueForKey:@"owner"] valueForKey:key]];
			
		}
		else {
			[array addObject:@" "];
		}
	}
	
	NSString *final = [array objectAtIndex:0];
	return final;
	
}
@end
