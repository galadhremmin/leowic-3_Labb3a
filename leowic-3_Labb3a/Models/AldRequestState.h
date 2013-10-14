//
//  AldRequestState.h
//  leowic-3_Labb3a
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONInterpreter.h"

@interface AldRequestState : NSObject

@property(nonatomic, strong) NSObject<AldJSONInterpreter> *interpreter;
@property(nonatomic, strong) NSMutableData                *data;

-(id) initWithInterpreter: (NSObject<AldJSONInterpreter> *)interpreter;

@end
