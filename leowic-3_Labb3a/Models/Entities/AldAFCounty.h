//
//  AldAFCounty.h
//  leowic-3_Labb3a
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONEntityProtocol.h"

@interface AldAFCounty : NSObject<AldJSONEntityProtocol>

@property(nonatomic)       NSInteger  entityId;
@property(nonatomic, copy) NSString  *description;

@end
