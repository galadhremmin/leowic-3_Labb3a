//
//  AldOfficeSelectionViewController.m
//  leowic-3_Labb3a
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOfficeSelectionViewController.h"
#import "AldOfficeDetailsViewController.h"
#import "AldDataModel.h"
#import "AldAFOffice.h"
#import "AldDataModelConstants.h"

@interface AldOfficeSelectionViewController ()  {
    NSArray *_objects;
}
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
    [[AldDataModel defaultModel] requestOfficesInCounty:self.county];
}

-(void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification center

-(void) receiveOfficesInCountyArray: (NSNotification *)notification
{
    _objects = [notification.userInfo objectForKey:kAldDataModelSignalOffices];
    
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
    return _objects.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    AldAFOffice *object = _objects[indexPath.row];
    cell.textLabel.text = [object name];
    return cell;
}

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"officeDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        id object = _objects[indexPath.row];
        
        AldOfficeDetailsViewController *nextController = (AldOfficeDetailsViewController *)segue.destinationViewController;
        [nextController setOffice:object];
    }
}


@end
