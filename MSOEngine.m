//
//  MSOEngine.m
//  MSOEngine
//
//  Created by Matt on 4/6/10.
//  Copyright 2010 Matt's Apps. All rights reserved.
//

#import "MSOEngine.h"


@implementation MSOEngine


-(NSString *)apikey
{
	return [[_apikey retain] autorelease];
}
-(NSString *)url

{
	return [[_url retain] autorelease];

}



-(void)setAPIKey:(NSString *)newapikey
{
	[_apikey release];
	_apikey = [newapikey retain];

}
-(void)setURL:(NSString *)newurl
{
	[_url release];
	_url = [newurl retain];
}


-(NSArray *)connectMekThxBai:(NSString *)url firstkey:(NSString *)key1 secondkey:(NSString *)key2
{
	NSMutableArray *array = [NSMutableArray array];
	SBJSON *parser = [[SBJSON alloc] init];
	array = [[NSMutableArray alloc] init];

		// Prepare URL request to download statuses from Twitter
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	
		// Get JSON as a NSString from NSData response
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
		// parse the JSON response into an object
		// Here we're using NSArray since we're parsing an array of JSON status objects
	NSDictionary *jsonObj = [parser objectWithString:json_string error:nil];
	NSArray *two = [jsonObj objectForKey:key1];
	for (NSDictionary *one in two)
	{
		[array addObject:[one objectForKey:key2]];
	}
	return array;
}


-(NSString *)getUserID:(int)theID forKey:(NSString *)key
{
	
	NSString *theURL = [[NSString alloc] initWithFormat:@"%@users/%d?key=%@",_url, theID, _apikey];
	NSArray *array = [self connectMekThxBai:theURL 
						 firstkey:@"users" 
						 secondkey:key];
	NSString *result = [array objectAtIndex:0];
	return result;
}
-(NSString *)getStats:(NSString *)key
{
	
	NSString *theURL = [[NSString alloc] initWithFormat:@"%@stats?key=%@",_url, _apikey];
	NSArray *array = [self connectMekThxBai:theURL 
								   firstkey:@"statistics" 
								  secondkey:key];
	NSString *result = [array objectAtIndex:0];
	return result;
}

-(NSArray*)getBadgesforKey:(NSString*)key hasCustomURL:(NSString *)customurl;
{
	if (customurl == nil) {
		NSString *theURL = [[NSString alloc] initWithFormat:@"%@badges?key=%@",_url, _apikey];
		NSArray *result = [self connectMekThxBai:theURL 
										firstkey:@"badges" 
									   secondkey:key];
		return result;

	}
	else {
		NSString *theURL = [[NSString alloc] initWithFormat:@"%@%@?key=%@",_url,customurl,_apikey];
		NSArray *result = [self connectMekThxBai:theURL 
										firstkey:@"badges" 
									   secondkey:key];
		return result;
	}

	
}

-(NSArray*)getQuestions:(NSString *)key
{
	NSString *theURL = [[NSString alloc] initWithFormat:@"%@questions?key=%@",_url, _apikey];
	NSArray *result = [self connectMekThxBai:theURL 
									firstkey:@"questions" 
								   secondkey:key];
	return result;
}
-(NSArray*)getTagsforKey:(NSString*)key
{
	NSString *theURL = [[NSString alloc] initWithFormat:@"%@tags?key=%@",_url, _apikey];
	NSArray *result = [self connectMekThxBai:theURL 
									firstkey:@"tags" 
								   secondkey:key];
	return result;
}
	//Look ma! No memory management!
@end
