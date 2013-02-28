//
//  GameResult.m
//  Matchismo
//
//  Created by Thijs Hosman on 2/17/13.
//  Copyright (c) 2013 Thijs Hosman. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (nonatomic, readwrite) NSDate *start;
@property (nonatomic, readwrite) NSDate *end;
@end

#define ALL_RESULT_KEY @"GameResult_ALL"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"


@implementation GameResult

+ (NSArray *)AllGameResults
{
    //initialize empty array for existing game results
    NSMutableArray *AllGameResults = [[NSMutableArray alloc] init];
    NSLog(@"allgameresults called");
    //get game results from standarduserdefaults
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULT_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [AllGameResults addObject:result];
        NSLog(@"result %@",[result description]);
    }
    
    return AllGameResults;
    
}

//convenience initializer, initializes the values from a propertylist that is specified
-(id)initFromPropertyList:(id)plist
{
    self = [self init];
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]] ){
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] integerValue];
            if(!_start || !_end) self = nil;
        }
    }
    return self;
}


- (void) synchronise //get userdefaults, move data from there, copy it in there, move back
{
    NSMutableDictionary *mutableGameResultsFromDictionary = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULT_KEY] mutableCopy]; //get a mutable copy from userdefaults
    if (!mutableGameResultsFromDictionary) mutableGameResultsFromDictionary = [[NSMutableDictionary alloc] init]; //initialize it if it doesn't exist yet
    mutableGameResultsFromDictionary[[self description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromDictionary forKey:ALL_RESULT_KEY ]; //set the current game data in userdefaults with a key that is equal to this class' description
    [[NSUserDefaults standardUserDefaults] synchronize]; //synchronize userdefaults
    
}

-(id)asPropertyList
{
    return @{START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score)};
}




//designated initializer
//do not call setters and getters in (designated) initializers!
- (id)init
{
    self = [super init];
    if (self){
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

-(void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronise];
}

@end
