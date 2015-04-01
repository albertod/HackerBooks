//
//  ADMLibrary.h
//  HackerBooks
//
//  Created by Alberto Di Martino on 3/31/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

@import Foundation;
#import "ADMBook.h"

@interface ADMLibrary : NSObject

-(NSUInteger) bookCount;
-(NSArray *)  tags;
-(NSUInteger) bookCountForTag:(NSString*)tag;
-(NSArray*)   booksForTag: (NSString*)tag;
-(ADMBook*)   bookForTag:(NSString*)tag atIndex:(NSUInteger) index;

@end
