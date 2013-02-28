//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Thijs Hosman on 1/31/13.
//  Copyright (c) 2013 Thijs Hosman. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init
{
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                NSLog(@"suit is: %@", suit);
                [self addCard:card atTop:YES];
                
                
            }
        }
    }
    return self;
}
@end
