//
//  AldRequestState.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONInterpreterProtocol.h"

@interface AldRequestState : NSObject

@property(nonatomic, strong) NSObject<AldJSONInterpreterProtocol> *interpreter;
@property(nonatomic, strong) NSMutableData                        *data;
@property(atomic, strong)    id                                    userData;

-(id) initWithInterpreter: (NSObject<AldJSONInterpreterProtocol> *)interpreter;

@end
