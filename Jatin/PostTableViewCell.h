//
//  PostTableViewCell.h
//  Jatin
//
//  Created by Jatin Pandey on 9/24/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *bodyContent;
@property (strong, nonatomic) IBOutlet UILabel *voteCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *upvoteButton;
@property (strong, nonatomic) IBOutlet UIButton *downvoteButton;
@property (strong, nonatomic) NSString *objectId;

@end
