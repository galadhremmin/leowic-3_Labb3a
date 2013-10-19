//
//  AldOfficeDetailsViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOfficeDetailsViewController.h"
#import "AldDataModelConstants.h"
#import "AldDataModel.h"
#import "AldAFOfficeDetails.h"

@interface AldOfficeDetailsViewController ()

@property (nonatomic, strong) AldDataModel *model;

@end

@implementation AldOfficeDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOffice:) name:kAldDataModelSignalOffice object:nil];
    
    [self setTitle:self.office.name];
    
    _model = [AldDataModel defaultModel];
    [_model requestDetailsForOffice:self.office];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification center

-(void) receiveOffice: (NSNotification *)notification
{
    AldAFOfficeDetails *details = [_model.offices objectForKey:self.office.entityId];
    
    NSMutableString *html = [NSMutableString string];
    
    [html appendString:@"<!DOCTYPE html><html><head><style>*{font-family:helvetica, sans-serif;}</style></head><body>"];
    [html appendFormat:@"<h1>%@</h1>", details.name];
    [html appendFormat:@"<h2>Besöksadress</h2><p>%@<br />%@</p>", details.visitorAddress, details.visitorCity];
    [html appendFormat:@"<h2>Postadress</h2><p>%@<br />%@ %@</p>", details.mailAddress, details.mailZipcode, details.mailCity];
    [html appendFormat:@"<h2>Telefonnummer</h2><p>%@<br />%@ (arbetsgivare)<br />%@</p>", details.publicPhoneNumber, details.employerPhoneNumber, details.phoneHours];
    [html appendFormat:@"<h2>Öppettider</h2><p>%@<br />%@ (självservice)</p>", details.personalServiceHours, details.selfServiceHours];
    
    if (details.extraInformation != nil && ![details.extraInformation isEqualToString:@""]) {
        [html appendFormat:@"<h2>Information</h2><p>%@</p>", details.extraInformation];
    }
    [html appendString:@"</body></html>"];
    
    [self.detailsView loadHTMLString:html baseURL:nil];
}

@end
