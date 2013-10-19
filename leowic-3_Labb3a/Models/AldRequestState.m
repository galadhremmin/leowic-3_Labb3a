//
//  AldRequestState.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldRequestState.h"

@implementation AldRequestState

-(id) initWithInterpreter: (NSObject<AldJSONInterpreterProtocol> *)interpreter
{
    self = [super init];
    if (self) {
        _interpreter = interpreter;
        _data = nil;
    }
    return self;
}

@end
