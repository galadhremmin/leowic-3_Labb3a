//
//  AldAFOfficeDetails.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONEntityProtocol.h"

@interface AldAFOfficeDetails : NSObject<AldJSONEntityProtocol>

@property(nonatomic, copy) NSString  *entityId;
@property(nonatomic, copy) NSString  *name;
@property(nonatomic, copy) NSString  *managerName;
@property(nonatomic, copy) NSString  *visitorAddress;
@property(nonatomic, copy) NSString  *visitorCity;
@property(nonatomic, copy) NSString  *mailAddress;
@property(nonatomic, copy) NSString  *mailZipcode;
@property(nonatomic, copy) NSString  *mailCity;
@property(nonatomic, copy) NSString  *email;
@property(nonatomic, copy) NSString  *publicPhoneNumber;
@property(nonatomic, copy) NSString  *employerPhoneNumber;
@property(nonatomic, copy) NSString  *faxNumber;
@property(nonatomic, copy) NSString  *phoneHours;
@property(nonatomic, copy) NSString  *selfServiceHours;
@property(nonatomic, copy) NSString  *personalServiceHours;
@property(nonatomic, copy) NSString  *extraInformation;

@end
