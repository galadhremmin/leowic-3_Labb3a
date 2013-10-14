//
//  AldDataModel.h
//  leowic-3_Labb3a
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldAFCounty.h"
#import "AldAFOffice.h"

@interface AldDataModel : NSObject<NSURLConnectionDelegate>

+(AldDataModel *) defaultModel;
-(void) requestCounties;
-(void) requestOfficesInCounty: (AldAFCounty *)county;
-(void) requestDetailsForOffice: (AldAFOffice *)office;

@end
