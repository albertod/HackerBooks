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
@property (copy,nonatomic)   NSString *title;
@property (strong,nonatomic) NSArray  *authors;
@property (strong,nonatomic) NSArray  *tags;
@property (strong,nonatomic) NSURL *imageURL;
@property (strong,nonatomic, readonly) UIImage *photo;
@property (strong,nonatomic) NSURL *pdfURL;
@property (strong,nonatomic,readonly) NSData *pdf;

//Constructores

//designated initializers

-(id) initWithTitle:(NSString *)title
            authors:(NSArray *)authors
               tags:(NSArray *)tags
           imageUrl:(NSURL *)imageURL
             pdfURL:(NSURL *)pdfURL;



//Json initializer
-(id) initWithDictionary:(NSDictionary *) aDict;

@end
