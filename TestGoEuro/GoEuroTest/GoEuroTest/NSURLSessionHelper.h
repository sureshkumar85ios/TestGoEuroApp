//
//  NSURLSessionHelper.h
//  MindValleytest
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DataFn)(NSData *data);


@interface NSURLSessionHelper : NSObject

@property (nonatomic, strong) NSURLSession *session;

+ (id)sharedHelper;

-(void)fetchDataFromURL:(NSString*)URL completion:(DataFn)completion;
-(NSDictionary*)SerializeFetchedDataToJSON:(NSData *)responseData;
@end
