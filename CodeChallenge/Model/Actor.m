//
//  Person.m
//  CodeChallenge
//
//  Created by Mohammed Abdelkarym on 4/22/14.
//  Copyright (c) 2014 Mohammed Abdelkarym. All rights reserved.
//

#import "Actor.h"

@implementation Actor


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"titleText": @"titleText",
             @"detailText": @"detailText",
             @"imageURL": @"imageURL",
            };
}

+ (NSValueTransformer *)imageURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
