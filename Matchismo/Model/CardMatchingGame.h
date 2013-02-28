//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Thijs Hosman on 2/3/13.
//  Copyright (c) 2013 Thijs Hosman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck
                gameType:(int)number;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) int score;

@end
