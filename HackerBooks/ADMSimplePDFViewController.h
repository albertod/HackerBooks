//
//  ADMSimplePDFViewController.h
//  HackerBooks
//
//  Created by Alberto Di Martino on 4/3/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

@import UIKit;
#import "ADMBook.h"

@interface ADMSimplePDFViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,weak) IBOutlet UIWebView *pdfViewer;
@property(nonatomic,strong) ADMBook* model;
-(id)initWithModel:(ADMBook *)model;

@end
