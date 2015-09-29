//
//  PostsTableViewController.h
//  Jatin
//
//  Created by Jatin Pandey on 9/24/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupSelectViewController.h"

@interface PostsTableViewController : UITableViewController <GroupSelectDelegate>

@property (strong, nonatomic) NSMutableArray *postsArray;

@end
