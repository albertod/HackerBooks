//
//  ADMLibraryTableViewController.m
//  HackerBooks
//
//  Created by Alberto Di Martino on 4/1/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMLibraryTableViewController.h"
#import "ADMBook.h"
#import "ADMBookViewController.h"

@interface ADMLibraryTableViewController ()

@end

@implementation ADMLibraryTableViewController


-(id) initWithModel:(ADMLibrary *)model
              style:(UITableViewStyle) style{
    
    if(self = [super initWithNibName:nil
                              bundle:nil]){
        
        _model = model;
        self.title = @"Alberto's Library";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return [[self.model tags] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.model bookCountForIndex:section];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.model tagByPosition:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BookCell";
    
    //Lets find out which book it is
    ADMBook *book = [self.model bookForTag:[self.model tagByPosition:indexPath.section] atIndex:indexPath.row ];
    
    
    // Creamos una celda
    UITableViewCell *bookCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (bookCell == nil) {
        // La creamos de cero
        bookCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:CellIdentifier];
    }
    
    // Sincronizamos modelo con vista (celda)
    bookCell.imageView.image = book.photo;
    bookCell.textLabel.text  = book.title;
    bookCell.detailTextLabel.text = [book.authors componentsJoinedByString:@","];
    
    return bookCell;
}


#pragma mark -Delegate

-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //find out which model the user tap
    ADMBook *book = [self.model bookForTag:[self.model tagByPosition:indexPath.section] atIndex:indexPath.row];
    
    //let know delegate (Jsut if it undestandt the message)
    if([self.delegate respondsToSelector:@selector(libraryTableViewController:didSelectBook:)]){
        
        [self.delegate libraryTableViewController:self
                                    didSelectBook:book];
    }
    
    //Send the notifications
}

@end
