//
//  AldJSONInterpreter.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldJSONInterpreter.h"
#import "AldDataModelConstants.h"

@implementation AldJSONInterpreter

-(NSString *) interpretationId
{
    return kAldDataModelSignalDefault;
}

-(id) interpretJSON: (NSData *)data
{
    NSError *error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return [self interpretJSONDictionary:json];
}

-(id) interpretJSONDictionary: (NSDictionary *)data
{
    [NSException raise:@"Not implemented" format:@"This selector hasn't been implemented."];
    return nil;
}

@end
