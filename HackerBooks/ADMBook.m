//
//  ADMBook.m
//  HackerBooks
//
//  Created by Alberto Di Martino on 3/31/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMBook.h"

@implementation ADMBook

@synthesize photo = _photo;


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
        _photo  = [self getCover:imageURL];
    }
    
    return self;
}

#pragma mark - Propiedades
-(UIImage *)getCover:(NSURL *)imageURL{
    
//    NSError *error = nil;
//    
//    NSFileManager *filemanager = [NSFileManager defaultManager];
//    NSURL *documentDirectory = [[filemanager URLsForDirectory:NSDocumentDirectory
//                                                    inDomains:NSUserDomainMask] lastObject];
//    
//    NSURL *patch = [documentDirectory URLByAppendingPathComponent:[imageURL lastPathComponent]];
    
    
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:imageURL];
    
    UIImage *image;

    if(data != nil){
        image = [UIImage imageWithData:data];
    }
 
    return image;
    
}


#pragma mark JSON initialization
-(id) initWithDictionary:(NSDictionary *)aDict{
    
    return [self initWithTitle:[aDict valueForKey:@"title"]
                       authors:[[aDict valueForKey:@"authors"] componentsSeparatedByString:@","]
                          tags:[[aDict valueForKey:@"tags"] componentsSeparatedByString:@","]
                      imageUrl:[NSURL URLWithString:[aDict valueForKey:@"image_url"]]
                        pdfURL:[NSURL URLWithString:[aDict valueForKey:@"pdf_url"]]];
}


@end
