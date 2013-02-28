//
//  PlayingCard.m
//  Matchismo
//
//  Created by Thijs Hosman on 1/31/13.
//  Copyright (c) 2013 Thijs Hosman. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


- (NSString *) contents
{
    //NSArray *rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    //return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
}

@synthesize suit = _suit; // because we implement both the setter and the getter the compiler does not synthesize this for us


+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}


- (void)setSuit:(NSString *)suit
{
    if ([ [PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}



// so that the getter of suit returns ? instead of NIL if the card does not exist
- (NSString *)suit
{
    //return _suit;
    return _suit ? _suit :@"?";
}

+ (NSArray *) rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}


+ (NSUInteger)maxRank {
    return [self rankStrings].count-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
 
    if (otherCards.count==1){
        PlayingCard *othercard = [otherCards lastObject];
        //PlayingCard *othercard = [otherCards objectAtIndex:otherCards.count-1];
        if ([othercard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (othercard.rank == self.rank){
            score = 4;
        }
        
    }
    
    //for (Card *othercard in otherCards){
    //    if ([self.suit isEqualToString:othercard.suit]) {
    //
    //    }
    //}
    return score;
}



@end
