//
//  Manager.m
//  CodeChallenge
//
//  Created by Mohammed Abdelkarym on 4/22/14.
//  Copyright (c) 2014 Mohammed Abdelkarym. All rights reserved.
//

#import "Manager.h"
#import "Actor.h"
#import "Client.h"

@interface Manager ()<clientDelegate>

@property (nonatomic, strong, readwrite) NSString *movieTitle;
@property (nonatomic, strong, readwrite) NSString *year;
@property (nonatomic, strong, readwrite) NSArray  *cast;

@property (strong,nonatomic)Client *client;

@end


@implementation Manager

#pragma mark -
#pragma mark Manager object life cycle

-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}

-(void)fetchMovieDetailsWithUrl:(NSString *)movieLink{
    NSURL *movieUrl=[NSURL URLWithString:movieLink];
    self.client=[[Client alloc]initWithUrl:movieUrl];
    self.client.delegtae=self;
    [self.client fetchJSONFromCurentServiceUrl];
}

#pragma mark -
#pragma mark Client response handlers

-(void)downloadingFinishedWithData:(NSDictionary *)json{
    self.movieTitle=[json objectForKey:@"movieTitle"];
    self.year=[json objectForKey:@"year"];
    
    //Map persons t objective-c objects
    NSMutableArray *mCast=[[NSMutableArray alloc]init];
    for (id person in [json objectForKey:@"cast"]){
        Actor *actor=[MTLJSONAdapter modelOfClass:[Actor class] fromJSONDictionary:person error:nil];
        [mCast addObject:actor];
    }
    
    self.cast=[NSArray arrayWithArray:mCast];
    
    if([self.delegtae respondsToSelector:@selector(movieDetailDownloaded)]){
        [self.delegtae movieDetailDownloaded];
    }
    //Start download actors images
    for(Actor *actor in self.cast){
        [self.client downloadImageWithUrl:actor.imageURL inIndex:[self.cast indexOfObject:actor]];
    }
    
}

-(void)imageDownloadedWithSuccess:(UIImage *)image inIndex:(int)index{
    Actor *actor = self.cast[index];
    actor.image = image;
    
    if([self.delegtae respondsToSelector:@selector(actorImageDownloadedWithIndex:)]){
        [self.delegtae actorImageDownloadedWithIndex:index];
    }
}

@end
