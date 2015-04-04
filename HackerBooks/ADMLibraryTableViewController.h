//
//  ADMLibraryTableViewController.h
//  HackerBooks
//
//  Created by Alberto Di Martino on 4/1/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

@import UIKit;
#import "ADMLibrary.h"

//For the notifications
#define NEW_BOOK_NOTIFICATION_NAME @"newBook"
#define BOOK_KEY @"book"


@class ADMLibraryTableViewController;
@protocol ADMLibraryTableViewControllerDelegate <NSObject>

@optional
-(void) libraryTableViewController:(ADMLibraryTableViewController *) lVC
                     didSelectBook:(ADMBook *) book;

@end

@interface ADMLibraryTableViewController : UITableViewController

@property (strong,nonatomic) ADMLibrary *model;

-(id) initWithModel:(ADMLibrary *)model
              style:(UITableViewStyle) style;

@property (weak,nonatomic) id<ADMLibraryTableViewControllerDelegate> delegate;


@end
