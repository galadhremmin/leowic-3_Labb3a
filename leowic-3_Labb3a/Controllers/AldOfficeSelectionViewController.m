//
//  AldOfficeSelectionViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOfficeSelectionViewController.h"
#import "AldOfficeDetailsViewController.h"
#import "AldDataModel.h"
#import "AldAFOffice.h"
#import "AldDataModelConstants.h"

@interface AldOfficeSelectionViewController ()

@property (nonatomic, strong) AldDataModel *model;

@end

@implementation AldOfficeSelectionViewController

-(id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOfficesInCountyArray:) name:kAldDataModelSignalOffices object:nil];
    
    [self setTitle:self.county.name];
    
    _model = [AldDataModel defaultModel];
    [_model requestOfficesInCounty:self.county];
}

-(void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification center

-(void) receiveOfficesInCountyArray: (NSNotification *)notification
{
    UITableView *view = (UITableView *)self.view;
    [view reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Table view data source

-(NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    if (_model.officesInCounties == nil) {
        return 0;
    }
    
    NSArray *offices = [_model.officesInCounties objectForKey:self.county.entityId];
    if (offices == nil) {
        return 0;
    }
    
    return offices.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *offices = [_model.officesInCounties objectForKey:self.county.entityId];
    AldAFOffice *object = offices[indexPath.row];
    cell.textLabel.text = [object name];
    return cell;
}

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"officeDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *offices = [_model.officesInCounties objectForKey:self.county.entityId];
        id object = offices[indexPath.row];
        
        AldOfficeDetailsViewController *nextController = (AldOfficeDetailsViewController *)segue.destinationViewController;
        [nextController setOffice:object];
    }
}


@end
