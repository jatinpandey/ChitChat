//
//  PostDetailViewController.h
//  Jatin
//
//  Created by Jatin Pandey on 9/26/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *bodyContent;
@property (strong, nonatomic) NSString *messageText;

@end
