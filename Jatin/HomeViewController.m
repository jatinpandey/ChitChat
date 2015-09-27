//
//  HomeViewController.m
//  Jatin
//
//  Created by Jatin Pandey on 9/23/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import "HomeViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface HomeViewController ()

@property (strong, nonatomic) AVAudioPlayer *avPlayer;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.jatinImage.image = [UIImage imageNamed:@"glass"];
    self.soundclipArray = [[NSMutableArray alloc] initWithObjects:@"science", @"ddlj", @"batman", @"waddup", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onJatinImageClick:(id)sender {
    NSLog(@"Trying to play 'Science, bitch'");
    NSInteger randomIndex = arc4random() % [self.soundclipArray count];
    NSString *randomFile = [self.soundclipArray objectAtIndex:randomIndex];
    NSString *audio=[[NSBundle mainBundle] pathForResource:randomFile ofType:@"mp3"];
    NSURL *url = [[NSURL alloc]initFileURLWithPath:audio];
    self.avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [self.avPlayer prepareToPlay];
    [self.avPlayer play];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"Thanks for shaking yo thang ;)");
    }
}


@end
