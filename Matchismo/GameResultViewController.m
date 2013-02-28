//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Thijs Hosman on 2/17/13.
//  Copyright (c) 2013 Thijs Hosman. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController

-(void)updateUI
{
    NSString *displayText = @"";
    for (GameResult *result in [GameResult AllGameResults])
    {
        displayText = [displayText stringByAppendingFormat:@"Score: %d(%@, %0g)\n",result.score, result.end, result.duration];
    }
    self.display.text = displayText;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}


-(void)setup
{
    // do anything that cannot wait until viewDidLoad
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        [self setup];

    
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
