//
//  HomeViewController.h
//  Jatin
//
//  Created by Jatin Pandey on 9/23/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AVFoundation/AVAudioPlayer.h>

@interface HomeViewController : UIViewController <AVAudioPlayerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *jatinImage;
@property (strong, nonatomic) NSMutableArray *soundclipArray;

@end
