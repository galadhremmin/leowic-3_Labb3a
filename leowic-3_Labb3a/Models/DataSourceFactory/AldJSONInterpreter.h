//
//  AldJSONInterpreter.h
//  leowic-3_Labb3a
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AldJSONInterpreter <NSObject>

-(NSString *) interpretationId;
-(id) interpret: (NSData *)data;

@end
