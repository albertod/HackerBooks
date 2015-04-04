//
//  ADMBookViewController.m
//  HackerBooks
//
//  Created by Alberto Di Martino on 4/1/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMBookViewController.h"


@implementation ADMBookViewController

#pragma mark - Init
-(id) initWithModel:(ADMBook *)model{
    
    if(self = [super init]){
        _model = model;
        self.title = [model title];
//        self.authorLabel = [[model authors] componentsJoinedByString:@","];
//        self.tagsLabel = [[model tags] componentsJoinedByString:@","];
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //this it to make sure to not use all the screen if there is an imageview
    //makes space for toolbar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.toolbarHidden = NO;
    [self syncviewWithModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) syncviewWithModel{
    
    self.title = self.model.title;
    self.titleLabel.text = self.model.title;
    self.authorLabel.text= [self.model.authors componentsJoinedByString:@","];
    self.tagsLabel.text= [self.model.tags componentsJoinedByString:@","];
    self.coverView.image = self.model.photo;
}

#pragma mark UISplitViewDelegate
-(void) splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    
    //Find out if the left table is visible
    if(displayMode == UISplitViewControllerDisplayModeAllVisible){
        
        //We are in vertical mode (all visible,not UITable)
        self.navigationItem.leftBarButtonItem = nil;
        
    }else{
        //we are in landscape, so hide the button
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
    }
}

#pragma mark ADMLibraryDelegate
-(void) libraryTableViewController:(ADMLibraryTableViewController *)lVC
                     didSelectBook:(ADMBook *) book{
    
    //the user selected a new character
    self.model = book;
    //sysncronize view with model
    [self syncviewWithModel];
}


@end
