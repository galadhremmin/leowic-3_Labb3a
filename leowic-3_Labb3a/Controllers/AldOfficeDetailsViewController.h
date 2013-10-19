//
//  AldOfficeDetailsViewController.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AldAFOffice.h"

@interface AldOfficeDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *detailsView;
@property (weak, nonatomic) AldAFOffice *office;

@end
