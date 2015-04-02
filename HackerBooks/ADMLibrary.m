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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json"]];
    NSURLResponse *response = [NSURLResponse new ];
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
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
                    if([self.library objectForKey:booksForKey] != nil)
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
    
    if([askedBook count] < index){
        return nil; //index is over the capacity of the books with the especified tag
    }
    
    return [askedBook objectAtIndex:index];
}

-(id)firstBook{
    
    return [self.library objectForKey:@"Parsing Techniques"];
}

-(NSUInteger) bookCountForIndex:(NSUInteger) index{
    
    return [[self.library objectForKey:[self.tags objectAtIndex:index]]count];
}

-(NSString *) tagByPosition:(NSUInteger)index{
    
    return [self.tagsArray objectAtIndex:index];
}


@end
