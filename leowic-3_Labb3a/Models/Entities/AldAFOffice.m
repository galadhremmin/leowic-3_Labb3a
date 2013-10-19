//
//  AldAFOffice.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFOffice.h"

@implementation AldAFOffice

-(id) initWithDictionary: (NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setEntityId: [dict objectForKey:@"afplatskod"]];
        [self setName:     [dict objectForKey:@"afplatsnamn"]];
    }
    
    return self;
}

@end
