//
//  PostDetailViewController.m
//  Jatin
//
//  Created by Jatin Pandey on 9/26/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import "PostDetailViewController.h"

@interface PostDetailViewController ()

@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bodyContent.text = self.messageText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onTweetTap:(id)sender {
    NSLog(@"Wait till I implement Twitter auth :)");
}



@end
