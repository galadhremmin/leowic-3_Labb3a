//
//  AldAFOfficesInCountyInterpreter.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AldJSONInterpreter.h"

@interface AldAFOfficesInCountyInterpreter : AldJSONInterpreter

-(id) interpretJSONDictionary: (NSDictionary *)data;

@end
