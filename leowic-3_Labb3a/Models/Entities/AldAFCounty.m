//
//  AldAFCounty.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFCounty.h"

@implementation AldAFCounty

-(id) initWithDictionary: (NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setEntityId: [dict objectForKey:@"id"]];
        [self setName:     [dict objectForKey:@"namn"]];
    }
    
    return self;
}

@end
