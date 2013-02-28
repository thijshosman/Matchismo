//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Thijs Hosman on 2/3/13.
//  Copyright (c) 2013 Thijs Hosman. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards; //private
@property (nonatomic) int score;
@property (nonatomic) int numberOfCards;
@end


@implementation CardMatchingGame

- (NSMutableArray *) cards //lazy instantiation
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck gameType:(int)number
{
    self = [super init];
    self.numberOfCards = number;
    if (self) {
        for (int i = 0; i< count; i++){
            Card *card = [deck drawRandomCard];
            
            if (!card) {
                self = nil;
            } else {
                self.cards[i]=card;
                //NSLog(@"contents while creating %@",self.cards[i]);
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if(!card.faceUp){
            for (Card *othercard in self.cards){
                if (othercard.isFaceUp && !othercard.isUnplayable){
                    int matchScore = [card match:@[othercard]];
                    if (matchScore) {
                        othercard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        othercard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
            break;
                }
            }
            self.score -= FLIP_COST;
        }
    
        card.faceUp = !card.isFaceUp;
    }
}



@end
