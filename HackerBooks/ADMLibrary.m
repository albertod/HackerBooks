//
//  ADMLibrary.m
//  HackerBooks
//
//  Created by Alberto Di Martino on 3/31/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMLibrary.h"

@interface ADMLibrary()
@property (strong,nonatomic) NSMutableDictionary *library; //Represent all the book on the
@property (strong,nonatomic) NSMutableArray *tagsArray; //will hold all the keys (titles)

@end

@implementation ADMLibrary


-(id) init{
    
    
    //Check the local directory to see if the data has been load
    NSUserDefaults *ld = [NSUserDefaults standardUserDefaults];
    
    //If enter this block, it means the app is the first time is open on the device
    if(!([ld objectForKey:@"FIR_TIME"])){
        
        //Dowload everything from the JSON soruce
        [self downloadJSON];
        //Mark the fyle system, so we know it already downloaded the file
        [ld setObject:@"1" forKey:@"FIR_TIME"];
        //Syncronize the Local Directory (ld), so the key is saved
        [ld synchronize];
    }
    
    //Use the file manager to fetch the data
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *localURL = [[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]; //The JSONData was the last we saved on the local directory of the sandBox
    NSError * error;
    
    NSURL * url = [NSURL URLWithString:@"https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json"];
    NSURL *directory = [localURL URLByAppendingPathComponent:[url lastPathComponent]];
    
    
    NSData *data = [NSData dataWithContentsOfURL:directory options:NSDataReadingMappedIfSafe error:&error];
    
    if(data != nil){
        
        //There is no error
        NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                error:&error];
        
        if(JSONObjects != nil){
            
            //Allocate and initialize our Library
            self.library = [[NSMutableDictionary alloc] initWithCapacity:JSONObjects.count];
            self.tagsArray = [NSMutableArray new];
            for(NSDictionary *dict in JSONObjects){
                
                ADMBook *book = [[ADMBook alloc] initWithDictionary:dict];
                
                
                for(NSString *individualTag in book.tags)
                {
                    //Delete whiteSpces
                    NSString * tagOfBook = [individualTag stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    
                    NSMutableArray *booksForKey = [NSMutableArray new];
                    //Check our dictionary of arrays for entries
                    if([self.library objectForKey:tagOfBook] != nil)
                    {
                        //We have alredy books under that
                        //Assign out mutable array to the entry of the dictionary
                        booksForKey = [self.library objectForKey:tagOfBook];
                        //Add the new book to the array
                        [booksForKey addObject:book];
                        //add this back to the entry on the deictionary
                        [self.library setObject:booksForKey forKey:tagOfBook];
                        
                    }else{
                        //first book with this tag
                        //add it to the array
                        [booksForKey addObject:book];
                        //add it to our library
                        [self.library setObject:booksForKey forKey:tagOfBook];
                       if(!([self.tagsArray containsObject:tagOfBook]))
                       {
                           [self.tagsArray addObject:tagOfBook];
                       }
                    }
                }
            }
       
        }else{
            NSLog(@"Error in parsing %@",error.localizedDescription);
        }
    }else{
        NSLog(@"Error fetching the data from server %@",error.localizedDescription);
    }
    
    //Before returining lets sort the array alphabetycally so it looks nicer :)
    self.tagsArray = [NSMutableArray arrayWithArray:[self.tagsArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    
    return self;

}

-(NSUInteger) bookCount{
    return [[self.library allKeys] count];
}

-(NSArray *) tags{

    return [self.library allKeys];
}

-(NSUInteger) bookCountForTag:(NSString*)tag{

    return [[self.library objectForKey:tag] count];
    
}
-(NSArray*) booksForTag: (NSString*)tag{
    

    NSArray *booksWithTag = [self.library objectForKey:tag];
    
    if([booksWithTag count ] == 0){
        return nil; //there are not books with the especified tag
    }
    return booksWithTag;
}

-(ADMBook*) bookForTag:(NSString*)tag atIndex:(NSUInteger) index{
    
    NSArray *askedBook = [self booksForTag:tag];
    
    if(askedBook == nil){
        return nil;
    }
    
    if([askedBook count] <= index){
        return nil; //index is over the capacity of the books with the especified tag
    }
    
    return [askedBook objectAtIndex:index];
}

-(id)firstBook{
    
    return [[self.library objectForKey:[self.tagsArray objectAtIndex:0]] objectAtIndex:0];
}

-(NSUInteger) bookCountForIndex:(NSUInteger) index{
    
    //Check this
    NSString *key = [self.tagsArray objectAtIndex:index];
    
    return [[self.library objectForKey:key] count];
}

-(NSString *) tagByPosition:(NSUInteger)index{
    
    return [self.tagsArray objectAtIndex:index];
}

-(int) downloadJSON{
    
    NSURL *url = [NSURL URLWithString:@"https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = [NSURLResponse new ];
    NSError *error;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if(data){
        
        NSFileManager *fm = [NSFileManager defaultManager];
        NSURL *local_path = [[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSArray *json_array = [NSJSONSerialization JSONObjectWithData:data
                                                              options:kNilOptions
                                                           error:&error];
        
        if(json_array){
            
            NSURL *destination = [local_path URLByAppendingPathComponent:[url lastPathComponent]];
            [data writeToURL:destination options:(NSDataWritingAtomic) error:&error];
           
            
            for(NSDictionary *dict in json_array){
                
                NSURL *image_url = [NSURL URLWithString:[dict objectForKey:@"image_url"]];
                destination = [local_path URLByAppendingPathComponent:[image_url lastPathComponent]];
                
                //write to Local directory
                request = [NSURLRequest requestWithURL:image_url];
                data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
                [data writeToURL:destination options:(NSDataWritingAtomic) error:&error]; // write image
                
                NSURL *pdf_url = [NSURL URLWithString:[dict objectForKey:@"pdf_url"]];
                destination = [local_path URLByAppendingPathComponent:[pdf_url lastPathComponent]];
               
                //write to Local directory
                 request = [NSURLRequest requestWithURL:pdf_url];
                data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
                [data writeToURL:destination options:(NSDataWritingAtomic) error:&error]; // write image
                
            }
            
        }else{
            
            NSLog(@"Problem with json serialization %@",error);
            return 0; //Sorry for the C syntax : )
        }
        
    }else{
        NSLog(@"Problem with URL %@",error);
        return 0;
    }

    return 1;

}



@end
