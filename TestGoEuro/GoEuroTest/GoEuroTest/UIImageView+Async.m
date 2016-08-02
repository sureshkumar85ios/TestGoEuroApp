//
//  UIImageView+Async.m
//  MindValleytest
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//

#import "UIImageView+Async.h"

@implementation UIImageView (Async)

- (void)setImageURL:(NSString *)url placeholder:(UIImage *)placeholderImage {
    
     NSURLSessionHelper *help = [NSURLSessionHelper sharedHelper];
    
    self.image = placeholderImage;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [help fetchDataFromURL:url completion:^(NSData *data) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = [[UIImage alloc] initWithData:data];
            });
            
            
        }];
        
        
      
        
    });
    
  

}

@end
