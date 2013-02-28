//
//  PlayingCard.h
//  Matchismo
//
//  Created by Thijs Hosman on 1/31/13.
//  Copyright (c) 2013 Thijs Hosman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

- (int)match:(NSArray *)otherCards;

@end
