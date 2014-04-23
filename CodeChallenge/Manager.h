//
//  Manager.h
//  CodeChallenge
//
//  Created by Mohammed Abdelkarym on 4/22/14.
//  Copyright (c) 2014 Mohammed Abdelkarym. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol managerDelegate;

@interface Manager : NSObject

@property(weak,nonatomic)id<managerDelegate> delegtae;

@property (nonatomic, strong, readonly) NSString *movieTitle;
@property (nonatomic, strong, readonly) NSString *year;
@property (nonatomic, strong, readonly) NSArray  *cast;

-(void)fetchMovieDetailsWithUrl:(NSString *)movieLink;

@end

@protocol managerDelegate <NSObject>

-(void)movieDetailDownloaded;
-(void)actorImageDownloadedWithIndex:(int)index;

@end
