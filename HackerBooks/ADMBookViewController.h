//
//  ADMBookViewController.h
//  HackerBooks
//
//  Created by Alberto Di Martino on 4/1/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

@import UIKit;
#import "ADMBook.h"
#import "ADMLibraryTableViewController.h"

@interface ADMBookViewController : UIViewController  <UISplitViewControllerDelegate,ADMLibraryTableViewControllerDelegate>

//title, cover, tags, evrytin execpt pf
//Make method to mark as favorite


@property (nonatomic,strong) ADMBook *model;
@property (nonatomic, weak) IBOutlet UIImageView *coverView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *tagsLabel;
@property (nonatomic, weak) IBOutlet UILabel *authorLabel;

//bottom to show PDF, need to show in another controller

-(id) initWithModel:(ADMBook *) model;

@end
