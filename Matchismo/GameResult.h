//
//  GameResult.h
//  Matchismo
//
//  Created by Thijs Hosman on 2/17/13.
//  Copyright (c) 2013 Thijs Hosman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+(NSArray *)AllGameResults;

@property (nonatomic, readonly) NSDate *start;
@property (nonatomic, readonly) NSDate *end;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

@end
