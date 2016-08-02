//
//  SimpleREST.h
//  SimpleREST
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const RAHUL;
extern NSString* const WEBSERVICENAME;
extern NSString* const WEBSERVICELOGIN;


@interface SimpleREST : NSObject<NSURLConnectionDelegate>

@property (nonatomic) NSString* url;
@property (nonatomic) BOOL logSuccess;
@property (nonatomic) BOOL logErrors;

- (id)init:(NSString*)urlStr;


- (NSDictionary*) Get:(NSString*) resource params:(NSDictionary*)params;
- (NSDictionary*) Post:(NSString*) resource params:(NSDictionary*)params;
- (NSDictionary*) Put:(NSString*) resource params:(NSDictionary*)params;
- (NSDictionary*) Delete:(NSString*) resource params:(NSDictionary*)params;
- (NSDictionary*) Post1:(NSString*) resource params:(NSMutableDictionary*)params;
- (NSDictionary*) Get1:(NSString*) resource params:(NSDictionary*)params;
@end
