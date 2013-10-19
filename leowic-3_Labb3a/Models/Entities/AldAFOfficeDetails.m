//
//  AldAFOfficeDetails.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFOfficeDetails.h"

@implementation AldAFOfficeDetails

-(id) initWithDictionary: (NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setEntityId:            [dict objectForKey:@"afplatskod"]];
        [self setName:                [dict objectForKey:@"afplatsnamn"]];
        [self setManagerName:         [dict objectForKey:@"afplatschef"]];
        [self setVisitorAddress:      [dict objectForKey:@"besoksadress"]];
        [self setVisitorCity:         [dict objectForKey:@"besoksort"]];
        [self setMailAddress:         [dict objectForKey:@"postadress"]];
        [self setMailZipcode:         [dict objectForKey:@"postnummer"]];
        [self setMailCity:            [dict objectForKey:@"postort"]];
        [self setEmail:               [dict objectForKey:@"epostadress"]];
        [self setPublicPhoneNumber:   [dict objectForKey:@"kontakttelefonnummer"]];
        [self setEmployerPhoneNumber: [dict objectForKey:@"arbetsgivartelefonnummer"]];
        [self setFaxNumber:           [dict objectForKey:@"faxnummer"]];
        [self setPhoneHours:          [dict objectForKey:@"telefontid"]];
        [self setSelfServiceHours:    [dict objectForKey:@"sjalvservicetid"]];
        [self setPersonalServiceHours:[dict objectForKey:@"personligservicetid"]];
        [self setExtraInformation:    [dict objectForKey:@"extra_information"]];
    }
    
    return self;
}

@end
