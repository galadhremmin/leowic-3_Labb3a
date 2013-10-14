//
//  AldAFCountyInterpreter.h
//  leowic-3_Labb3a
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONInterpreter.h"

@interface AldAFCountyInterpreter : NSObject<AldJSONInterpreter>

-(NSString *) interpretationId;

@end
