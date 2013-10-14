//
//  AldAFCountyInterpreter.m
//  leowic-3_Labb3a
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFCountyInterpreter.h"
#import "AldAFCounty.h"
#import "AldDataModelConstants.h"

@implementation AldAFCountyInterpreter

-(NSString *) interpretationId
{
    return kAldDataModelSignalCounties;
}

-(id) interpret: (NSData *)data
{
    NSError *error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    id counties = [[json objectForKey:@"soklista"] objectForKey:@"sokdata"];
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *countyData in counties) {
        AldAFCounty *county = [[AldAFCounty alloc] initWithDictionary:countyData];
        [result addObject:county];
    }
    
    return result;
}

@end
