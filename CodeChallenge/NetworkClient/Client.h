//
//  Client.h
//  CodeChallenge
//
//  Created by Mohammed Abdelkarym on 4/22/14.
//  Copyright (c) 2014 Mohammed Abdelkarym. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol clientDelegate;

@interface Client : NSObject

@property (strong, nonatomic)NSURL *serviceUrl;
@property(weak,nonatomic)id<clientDelegate> delegtae;

-(id)initWithUrl:(NSURL *)serviceUrl;
- (void)fetchJSONFromCurentServiceUrl;
-(void)downloadImageWithUrl:(NSURL *)iamgeUrl inIndex:(int)index;

@end

@protocol clientDelegate <NSObject>

-(void)downloadingFinishedWithData:(NSDictionary *)json;
-(void)downloadingFinishedWithFailure;

-(void)imageDownloadedWithSuccess:(UIImage *)image inIndex:(int)index;

@end