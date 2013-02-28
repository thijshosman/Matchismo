//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Thijs Hosman on 1/31/13.
//  Copyright (c) 2013 Thijs Hosman. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statuslabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;
@property (nonatomic) int gameMode;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) UIImage *cardBackImage;
@property (nonatomic) GameResult *gameResult;
//@property (nonatomic) NSAttributedString *aString;

@end

@implementation CardGameViewController

-(GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
        return _gameResult;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
 //   UIImage *blank = [[UIImage alloc] init];
//    [self cardBackImage:blank forState:UIControlStateSelected];
//    [self.cardButtonsetImage:blank
//                    forState:UIControlStateSelected|UIControlStateDisabled];
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}


- (IBAction)Deal:(UIButton *)sender {
    self.game = Nil;
    self.gameResult = Nil;
    self.flipCount = 0;
    [self updateUI];
}


-(int)gameMode{
    if (!_gameMode) {
      _gameMode = 2;  
    }
    return _gameMode;
}



-(CardMatchingGame *)game //lazy instantiation again, but now init with our designated initliazier
{
    //if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.myDeck]; //important line, initialize
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                          usingDeck:[[PlayingCardDeck alloc] init]
                                                           gameType:2
                         ]; //important line, initialize
    //NSLog(@"count %@",[card contents]);
    return _game;
}




//make the setter of mydeck initialize it, lazy instantiation
//- (Deck *)myDeck
//{
//    if (!_myDeck) _myDeck = [[PlayingCardDeck alloc] init];
//    return _myDeck;
//}


//old code, this just randomizes it, but we will let the model do that. 
//- (void) setCardButtons: (NSArray *)cardButtons {
//    _cardButtons = cardButtons;
//    for (UIButton *cardButton in cardButtons) {
//        Card *card = [self.myDeck drawRandomCard];
//        [cardButton setTitle:card.contents forState:UIControlStateSelected];
//    }
//}

- (void) setCardButtons: (NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
    
    
}

-(void) updateUI
{
    static UIImage *cardBack = nil;
    cardBack = [UIImage imageNamed:@"Tux.png"];
    
    for (UIButton *button in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:button]];
        //NSLog(@"card flip index %d",[self.cardButtons indexOfObject:button]);
        [button setTitle:card.contents forState:UIControlStateSelected];
        [button setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        //if (!cardBack) cardBack = [UIImage imageNamed:@"Tux.png"];
            //button.selected = !button.isSelected;
        //if (!card.isFaceUp) {
        //    [button setImage:cardBack forState:UIControlStateNormal];
        //} else {
        //    [button setImage:nil forState:UIControlStateNormal];
        //}
        
        button.selected = card.isFaceUp;
        [button setImage:button.isSelected ? nil : cardBack forState:UIControlStateNormal];
        //button.selected = YES;
        button.enabled = !card.isUnplayable;
        button.alpha = card.isUnplayable ? 0.3 : 1.0;
        self.ScoreLabel.text = [NSString stringWithFormat:@"Score: %d",[self.game score] ];
        [self updateStatus];
    }
    
}

-(void) updateStatus
{
    self.statuslabel.text = [NSString stringWithFormat:@"this is the labelstring"];
}


- (IBAction)flipCard:(UIButton *)sender {

    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    //NSLog(@"card flip index %d",[self.cardButtons indexOfObject:sender]);
    //Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:sender]];
    //NSLog(@"contents %@",[card contents]);
    //sender.selected = !sender.isSelected;
    self.flipCount++;
    [self updateUI];
    self.gameResult.score = self.game.score;
    
}

//- (IBAction)flipCard:(UIButton *)sender {
////f (!sender.isSelected) {
////      sender.selected = YES;
////  } else {
////      sender.selected = NO;
////  }
//    
//    // create deck if there isn't one yet
//    //if (!self.myDeck) {
//    //    self.myDeck = [[PlayingCardDeck alloc]init];
//    //}
//    
//    // flip card of front is shown
//    if (sender.selected) {
//        sender.selected = !sender.isSelected;
//        self.flipCount++;
//    
//    } else { //when back is shown and card is flipped:
//            
//            //  Otherwise get a new card from the deck and show it
//            //PlayingCard *myCard = (PlayingCard *)[self.myDeck drawRandomCard];
//            Card *myCard = [self.myDeck drawRandomCard];
//        
//            NSLog(@"new card drawn is %@", [myCard contents]);
//  //          NSLog(@"new card rank is %@", [myCard suit]);
//  //          NSLog(@"new card suit is %lu", (unsigned long)[myCard rank]);
//
//        
//            if (myCard) {
//                [sender setTitle:[myCard contents] forState:UIControlStateSelected];
//                sender.selected = !sender.isSelected;
//                self.flipCount++;
//                
//            } else {
//                
//                //  Oh noes! Out of cards!
//                UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"All out of cards!"
//                                                                  message:nil
//                                                                 delegate:nil
//                                                        cancelButtonTitle:nil
//                                                        otherButtonTitles:@"Deal again!", nil];
//                
//                [myAlert show];
//                
//                //  nil the deck and set the flipCount to 0
//                self.myDeck = nil;
//                [self setFlipCount:0];
//    
//            }
//    }
//    //sender.selected = !sender.isSelected;
//        //self.flipCount++;
//    
//    
//    
//    
//    
//    
//}
//



- (IBAction)gameTypeControl:(UISegmentedControl *)sender {
    NSLog(@"card flip index %d",sender.selectedSegmentIndex);
    if (sender.selectedSegmentIndex ==1) {
        sender.enabled = NO;
    }
}

@end
