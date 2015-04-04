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
@synthesize pdf   = _pdf;


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
        _pdf    = [self getPDF:pdfURL];
    }
    
    return self;
}

#pragma mark - Propiedades
-(UIImage *)getCover:(NSURL *)imageURL{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *documentDirectory = [[fm URLsForDirectory:NSDocumentDirectory
                                                    inDomains:NSUserDomainMask] lastObject];

    NSURL *URLPath = [documentDirectory URLByAppendingPathComponent:[imageURL lastPathComponent]];
    
    
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:URLPath];
    
    UIImage *image;

    if(data != nil){
        image = [UIImage imageWithData:data];
    }else{
        NSLog(@"Error Image is not in local directory");
    }
 
    return image;
    
}

-(NSData *)getPDF:(NSURL *) pdfURL{
    
    //Check the local directory for the PDF
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *documentDirectory = [[fm URLsForDirectory:NSDocumentDirectory
                                           inDomains:NSUserDomainMask] lastObject];
    
    NSURL *URLPath = [documentDirectory URLByAppendingPathComponent:[pdfURL lastPathComponent]];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:URLPath];
    
    if(data == nil){
         NSLog(@"Error, PDF is not in local directory");
       
        
    }
    
    return data;
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
