//
//  AldJSONInterpreter.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONInterpreterProtocol.h"

@interface AldJSONInterpreter : NSObject<AldJSONInterpreterProtocol>

-(id) interpretJSON:(NSData *)data;
-(id) interpretJSONDictionary:(NSDictionary *)data; // <~~ "abstract" ie must be implemented

@end
