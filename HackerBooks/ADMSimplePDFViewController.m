//
//  ADMSimplePDFViewController.m
//  HackerBooks
//
//  Created by Alberto Di Martino on 4/3/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMSimplePDFViewController.h"
#import "ADMLibraryTableViewController.h"

@interface ADMSimplePDFViewController ()

@end

@implementation ADMSimplePDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(id)initWithModel:(ADMBook *)model{
    
    if(self =[super init]){
        
        _model = model;
    }
    return  self;
}

#pragma mark -NotificationUtil
-(void) bookDidChange:(NSNotification *) notification{
    
    NSDictionary *dict = [notification userInfo];
    ADMBook *book = [dict objectForKey:BOOK_KEY];
    
    self.model = book;
    [self.pdfViewer loadData:self.model.pdf MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];
}

-(void) viewWillAppear:(BOOL)animated{
    
    //Sycronize model with the View
    //Make sure dont use the all screen, so we are able to return
    [super viewWillAppear:animated];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.pdfViewer.delegate = self;
    self.title = self.model.title;
 
    [self.pdfViewer loadData:self.model.pdf MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];

    //Stay alert for notifications
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(bookDidChange:)
                   name:NEW_BOOK_NOTIFICATION_NAME
                 object:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    //Ignore new notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
