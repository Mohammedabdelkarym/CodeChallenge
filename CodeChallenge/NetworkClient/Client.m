//
//  Client.m
//  CodeChallenge
//
//  Created by Mohammed Abdelkarym on 4/22/14.
//  Copyright (c) 2014 Mohammed Abdelkarym. All rights reserved.
//

#import "Client.h"

@implementation Client

-(id)initWithUrl:(NSURL *)serviceUrl{

    if(self=[super init]){
        self.serviceUrl=serviceUrl;
    }
    return self;
}

- (void)fetchJSONFromCurentServiceUrl{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.serviceUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        //NSLog(@"Resposne status %li  error %@", (long)[(NSHTTPURLResponse *)response statusCode],error);
        if((long)[(NSHTTPURLResponse *)response statusCode]!=404){
            NSError *jsonError = nil;            
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if([self.delegtae respondsToSelector:@selector(downloadingFinishedWithData:)]){
                [self.delegtae downloadingFinishedWithData:json];
            }
        }
    }];
}

-(void)downloadImageWithUrl:(NSURL *)iamgeUrl inIndex:(int)index{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:iamgeUrl];
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        //NSLog(@"Image downloaded with status %li  error %@ ", (long)[(NSHTTPURLResponse *)response statusCode],error);
        if((long)[(NSHTTPURLResponse *)response statusCode]!=404){
            if([self.delegtae respondsToSelector:@selector(imageDownloadedWithSuccess:inIndex:)]){
                UIImage *frameImage=[UIImage imageWithData:data];
                [self.delegtae imageDownloadedWithSuccess:frameImage inIndex:index];
            }
        }
    }];
    
}

@end
