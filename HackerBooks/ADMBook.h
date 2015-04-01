//
//  ADMBook.h
//  HackerBooks
//
//  Created by Alberto Di Martino on 3/31/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface ADMBook : NSObject


//Properties
@property (copy,nonatomic) NSString *title;
@property (strong,nonatomic) NSArray  *authors;
@property (strong,nonatomic) NSArray  *tags;
@property (strong,nonatomic) NSURL    *imageURL;
@property (strong,nonatomic) NSURL    *pdfURL;

//designated initializers

-(id) initWithTitle:(NSString *)title
            authors:(NSArray *)authors
               tags:(NSArray *)tags
           imageUrl:(NSURL *)imageURL
             pdfURL:(NSURL *)pdfURL;


@end
