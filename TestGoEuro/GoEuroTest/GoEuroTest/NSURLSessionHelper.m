//
//  NSURLSessionHelper.m
//  MindValleytest
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//

#import "NSURLSessionHelper.h"

@implementation NSURLSessionHelper

+ (id)sharedHelper {
    static NSURLSessionHelper *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[self alloc] init];
    });
    return sharedHelper;
}

-(id)init{
    if (self = [super init]) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
        self.session = session;
    }
    
    return self;
}

-(void)fetchDataFromURL:(NSString*)URL completion:(DataFn)completion{
    NSURL *url			       = [NSURL URLWithString:URL];
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data.length > 0) {
            completion(data);
        }
        else {
            completion(nil);
        }
    }];
    
    [task resume];
}

- (NSDictionary*)SerializeFetchedDataToJSON:(NSData *)responseData{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData options:kNilOptions
                          error:&error];
    return json;
}

@end
