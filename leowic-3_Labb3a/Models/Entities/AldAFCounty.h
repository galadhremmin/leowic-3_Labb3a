//
//  AldAFCounty.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONEntityProtocol.h"

@interface AldAFCounty : NSObject<AldJSONEntityProtocol>

@property(nonatomic, copy) NSString *entityId;
@property(nonatomic, copy) NSString *name;

@end
