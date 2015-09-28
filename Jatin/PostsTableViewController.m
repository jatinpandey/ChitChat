//
//  PostsTableViewController.m
//  Jatin
//
//  Created by Jatin Pandey on 9/24/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import "PostsTableViewController.h"
#import "Post.h"
#import "PostTableViewCell.h"
#import "PostDetailViewController.h"
#import <Parse/Parse.h>

@interface PostsTableViewController ()

@property NSString *groupName;

@end

@implementation PostsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:99.0/255.0 green:73.0/255.0 blue:1 alpha:1.0]}];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:141.0/255.0 green:1 blue:185.0/255.0 alpha:1.0];
    self.tableView.separatorColor = [UIColor whiteColor];

//    [self getAllMessagesForGroup:self.groupName];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshPosts) forControlEvents:UIControlEventValueChanged];
    
    if (self.groupName == nil) {
        self.groupName = @"Global";
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self getAllMessagesForGroup:self.groupName];
    // Do I need this? Maybe extra network request
}

/*
- (void) getAllMessages {
    PFQuery *getRecordsForClass = [PFQuery queryWithClassName:@"Message"];
    [getRecordsForClass orderByDescending:@"createdAt"];
    [getRecordsForClass findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {

        self.postsArray = [[NSMutableArray alloc] init];
        for (PFObject *postObj in objects) {
            [self.postsArray addObject:[Post postWithObject:postObj]];
        }
        [self.tableView reloadData];
    }];
}
*/

- (void) getAllMessagesForGroup:(NSString *)groupName {
    PFQuery *getRecordsForClass = [PFQuery queryWithClassName:@"Message"];
    [getRecordsForClass orderByDescending:@"createdAt"];
    if (groupName != nil) {
        [getRecordsForClass whereKey:@"toGroupName" equalTo:groupName];
    }
    [getRecordsForClass findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {

        self.postsArray = [[NSMutableArray alloc] init];
        for (PFObject *postObj in objects) {
            [self.postsArray addObject:[Post postWithObject:postObj]];
        }
        [self.tableView reloadData];
    }];
}


- (void) refreshPosts {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getAllMessagesForGroup:self.groupName];
        [self.refreshControl endRefreshing];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%ld", [self.postsArray count]); This is called many times, why?
    return [self.postsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];

    Post *postForCell = ((Post *)self.postsArray[indexPath.row]);
    cell.bodyContent.text = postForCell.bodyContent;
    cell.voteCountLabel.text = [NSString stringWithFormat:@"%@", postForCell.voteCount];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = (PostTableViewCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"detailSegue" sender:cell];
}

- (NSIndexPath *) getIndexPathForButton:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    return indexPath;
}

- (IBAction)onUpvote:(id)sender {
    NSLog(@"Thanks for upvote!");

    PFQuery *voteUpdateQuery = [PFQuery queryWithClassName:@"Message"];
    NSIndexPath *indexPath = [self getIndexPathForButton:sender];
    NSInteger row = indexPath.row;
    Post *postForRow = ((Post *)self.postsArray[row]);
    NSString *objectId = postForRow.objectId;

    [voteUpdateQuery getObjectInBackgroundWithId:objectId block:^(PFObject * _Nullable post, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error storing upvote, sorry OP: %@", error.description);
        } else {
            [post incrementKey:@"voteCount"];
            [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    Post *currentPost = self.postsArray[row] = [Post postWithObject:post];
                    PostTableViewCell *cell = (PostTableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
                    cell.voteCountLabel.text = [NSString stringWithFormat:@"%d", [currentPost.voteCount intValue]];
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }
            }];
        }
    }];
}

- (IBAction)onDownvote:(id)sender {
    NSLog(@"Come on dude");

    PFQuery *voteUpdateQuery = [PFQuery queryWithClassName:@"Message"];
    NSIndexPath *indexPath = [self getIndexPathForButton:sender];
    NSInteger row = indexPath.row;
    Post *postForRow = ((Post *)self.postsArray[row]);
    NSString *objectId = postForRow.objectId;

    [voteUpdateQuery getObjectInBackgroundWithId:objectId block:^(PFObject * _Nullable post, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error storing upvote, lucky you OP: %@", error.description);
        } else {
            [post incrementKey:@"voteCount" byAmount:@-1];
            [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    Post *currentPost = self.postsArray[row] = [Post postWithObject:post];
                    PostTableViewCell *cell = (PostTableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
                    cell.voteCountLabel.text = [NSString stringWithFormat:@"%d", [currentPost.voteCount intValue]];
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }
            }];
        }
    }];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual: @"detailSegue"]) {
        PostDetailViewController *detailVC = [segue destinationViewController];
        PostTableViewCell *cell = (PostTableViewCell *)sender;
        detailVC.messageText = cell.bodyContent.text;
    }
}

@end
