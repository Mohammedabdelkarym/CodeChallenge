//
//  Person.h
//  CodeChallenge
//
//  Created by Mohammed Abdelkarym on 4/22/14.
//  Copyright (c) 2014 Mohammed Abdelkarym. All rights reserved.
//

#import <Mantle.h>

@interface Actor : MTLModel <MTLJSONSerializing>


@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImage *image;



@end
