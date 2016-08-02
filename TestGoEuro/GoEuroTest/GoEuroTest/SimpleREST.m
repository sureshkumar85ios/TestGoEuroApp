//
//  SimpleREST.m
//  SimpleREST
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//
#import "SimpleREST.h"





@implementation SimpleREST

@synthesize url;
@synthesize logSuccess;
@synthesize logErrors;

- (id)init:(NSString*)urlStr
{
    self = [super init];
    if( self )
    {
        url = [NSString stringWithString:urlStr];
        logSuccess = NO;
        logErrors = NO;
    }
    return self;
}

- (NSDictionary*) SendRequest:(NSMutableURLRequest*) request
{
    NSHTTPURLResponse* urlResponse = nil;  
    NSError *error = [[NSError alloc] init];  
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];  
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
  //  DLog(@"the response request is %@",urlResponse);
    
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        if( logSuccess )
        {
            NSLog(@"Response Code: %ld", (long)[urlResponse statusCode]);
            NSLog(@"Response: %@", result);
        }
        //deserialize to json
        NSError *jsonParsingError = nil;
        NSDictionary *items = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];
        
     //   NSJSONReadingAllowFragments
        
//        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *e;
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:nil error:&e];
//        NSLog(@"THE RESPONSE IS %@",dict);
        
        
        return items;
    }
    else
    {
        if( logErrors )
        {
            NSLog(@"Response Code: %ld", (long)[urlResponse statusCode]);
            NSLog(@"Response: %@", result);
        }
        return Nil;
    }
}
- (NSDictionary*) Get1:(NSString*) resource params:(NSDictionary*)params
{
    NSString *paramStr = @"";
    bool first = true;
    for (NSString* key in params) {
        if( first ){
            paramStr = [NSString stringWithFormat:@"%@?%@=%@", paramStr, (NSString*)key, (NSString*)[params objectForKey:key]];
            first = false;
        }else {
            paramStr = [NSString stringWithFormat:@"%@&%@=%@", paramStr, (NSString*)key, (NSString*)[params objectForKey:key]];
        }
    }
    
    NSURL *urlstr = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",resource] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    //    NSURL *nsurl = [NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@%@", url, resource, paramStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlstr];
    [request setHTTPMethod:@"GET"];
    
    return [self SendRequest:request];
}

- (NSDictionary*) Get:(NSString*) resource params:(NSDictionary*)params
{
    NSString *paramStr = @"";
    bool first = true;
    for (NSString* key in params) {
        if( first ){
            paramStr = [NSString stringWithFormat:@"%@?%@=%@", paramStr, (NSString*)key, (NSString*)[params objectForKey:key]];
            first = false;
        }else {
            paramStr = [NSString stringWithFormat:@"%@&%@=%@", paramStr, (NSString*)key, (NSString*)[params objectForKey:key]];
        }
    }
    
       NSURL *urlstr = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",resource] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    
//    NSURL *nsurl = [NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@%@", url, resource, paramStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlstr];
    [request setHTTPMethod:@"GET"];

    return [self SendRequest:request];
}


- (NSString*) Post1:(NSString*) resource params:(NSMutableDictionary*)params
{
    
    NSError *error;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *s = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",resource] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    

    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil]; //TODO handle error
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    return [self SendRequest1:request];
    
}

- (NSString*) SendRequest1:(NSMutableURLRequest*) request
{
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
   // DLog(@"the response request is %@",urlResponse);
    
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        if( logSuccess )
        {
            NSLog(@"Response Code: %ld", (long)[urlResponse statusCode]);
            NSLog(@"Response: %@", result);
        }
        //deserialize to json
//        
//        NSError *jsonError;
//        NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
//                                                                     options:kNilOptions
//                                                                       error:&error];
//        NSLog(@"the json is %@",json);
   
        return result;
    }
    else
    {
        if( logErrors )
        {
            NSLog(@"Response Code: %ld", (long)[urlResponse statusCode]);
            NSLog(@"Response: %@", result);
        }
        return Nil;
    }
}
- (NSDictionary*) Post:(NSString*) resource params:(NSMutableDictionary*)params
{
    
    NSError *error;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *s = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    
    
    
       NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",resource] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
  //  NSURL *url = [NSURL URLWithString:@"https://xxxxxxx.com/questions"];
    

    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil]; //TODO handle error
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    return [self SendRequest:request];

}

- (NSDictionary*) Put:(NSString*) resource params:(NSDictionary*)params
{
    return Nil;
}

- (NSDictionary*) Delete:(NSString*) resource params:(NSDictionary*)params
{
    return Nil;
}

//AFNetworking Implementation Methods


//-(NSDictionary *)responseMethodCall:(id)responseobject
//{
//    
//}

@end
