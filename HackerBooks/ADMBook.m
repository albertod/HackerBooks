//
//  ADMBook.m
//  HackerBooks
//
//  Created by Alberto Di Martino on 3/31/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMBook.h"

@implementation ADMBook


-(id) initWithTitle:(NSString *)title
            authors:(NSArray *)authors
               tags:(NSArray *)tags
           imageUrl:(NSURL *)imageURL
             pdfURL:(NSURL *)pdfURL{
    
    if(self = [super init]){
        
        _title = title;
        _authors = authors;
        _tags = tags;
        _imageURL = imageURL;
        _pdfURL = pdfURL;
    }
    
    return self;
}

@end
