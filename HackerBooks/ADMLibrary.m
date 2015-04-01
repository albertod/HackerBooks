//
//  ADMLibrary.m
//  HackerBooks
//
//  Created by Alberto Di Martino on 3/31/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMLibrary.h"

@interface ADMLibrary()
@property (strong,nonatomic) NSArray* library; //Represent all the book on the
@end

@implementation ADMLibrary

-(NSUInteger) bookCount{
    return [self.library count];
}

-(NSArray *) tags{
    
    NSDictionary *booksWithTag = [[NSMutableDictionary alloc ] init];
    for(ADMBook *book in [self.library reverseObjectEnumerator]){
        
        for(int i =0; i < book.tags.count ; i++){
            
            if([booksWithTag valueForKey:[book.tags objectAtIndex:i]] == nil){
                //Object is not in the dictionary, add it
                
                [booksWithTag setValue:@1 forKey:[book.tags objectAtIndex:i]];
            }
        }
    }
    
    return [booksWithTag allValues];
    
}
-(NSUInteger) bookCountForTag:(NSString*)tag{
    
    NSMutableArray *booksWithTag = [[NSMutableArray alloc ] init];
    
    for(ADMBook *book in [self.library reverseObjectEnumerator]){
        
        for(int i =0; i < book.tags.count; i++){
            
            if([[book.tags objectAtIndex:i] isEqualToString:tag]){
                
                [booksWithTag addObject:book];
            }
        }
    }
    
    if([booksWithTag count ] == 0){
        return 0; //there are not books with the especified tag
    }
    return [booksWithTag count]; //CHECK this
    
}
-(NSArray*) booksForTag: (NSString*)tag{
    
    NSMutableArray *booksWithTag = [[NSMutableArray alloc ] init];
    
    for(ADMBook *book in [self.library reverseObjectEnumerator]){
        
        for(int i =0; i < book.tags.count; i++){
            
            if([[book.tags objectAtIndex:i] isEqualToString:tag]){
                
                [booksWithTag addObject:book];
            }
        }
    }
    
    if([booksWithTag count ] == 0){
        return nil; //there are not books with the especified tag
    }
    return [booksWithTag copy]; //CHECK this
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

@end
