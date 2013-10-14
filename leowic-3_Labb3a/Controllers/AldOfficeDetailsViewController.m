//
//  AldOfficeDetailsViewController.m
//  leowic-3_Labb3a
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOfficeDetailsViewController.h"
#import "AldDataModelConstants.h"
#import "AldDataModel.h"
#import "AldAFOfficeDetails.h"

@interface AldOfficeDetailsViewController ()

@end

@implementation AldOfficeDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOffice:) name:kAldDataModelSignalOffice object:nil];
    
    [self setTitle:self.office.name];
    
    [[AldDataModel defaultModel] requestDetailsForOffice:self.office];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification center

-(void) receiveOffice: (NSNotification *)notification
{
    AldAFOfficeDetails *details = [notification.userInfo objectForKey:kAldDataModelSignalOffice];
    
    NSMutableString *html = [NSMutableString string];
    
    [html appendString:@"<!DOCTYPE html><html><head></head><body>"];
    [html appendFormat:@"<p>%@</p>", details.extraInformation];
    [html appendString:@"</body></html>"];
    
    [self.detailsView loadHTMLString:html baseURL:nil];
}

@end
