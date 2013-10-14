//
//  AldDetailViewController.h
//  leowic-3_Labb3a
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AldDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
