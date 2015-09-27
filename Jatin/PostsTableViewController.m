//
//  PostsTableViewController.m
//  Jatin
//
//  Created by Jatin Pandey on 9/24/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import "PostsTableViewController.h"
#import "PostTableViewCell.h"
#import "PostDetailViewController.h"
#import <Parse/Parse.h>
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface PostsTableViewController ()

@property (strong, nonatomic) NSArray *postsArray;

@end

@implementation PostsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:141.0/255.0 green:1 blue:185.0/255.0 alpha:1.0];
    self.tableView.separatorColor = [UIColor whiteColor];
    [self getAllMessages];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshPosts) forControlEvents:UIControlEventValueChanged];
}

- (void) getAllMessages {
    PFQuery *getRecordsForClass = [PFQuery queryWithClassName:@"Message"];
    [getRecordsForClass orderByDescending:@"createdAt"];
    [getRecordsForClass findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSMutableArray *messages = [[NSMutableArray alloc] init];
        for (PFObject *messageObj in objects) {
            [messages addObject:(messageObj[@"bodyContent"])];
        }
        self.postsArray = [NSArray arrayWithArray:messages];
        [self.tableView reloadData];
    }];
}

- (void) refreshPosts {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getAllMessages];
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

    cell.bodyContent.text = self.postsArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    [cell.upvoteButton addTarget:self action:@selector(getRowForButton:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.upvoteButton addTarget:self action:@selector(getRowForButton:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = (PostTableViewCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"detailSegue" sender:cell];
}

- (void) getRowForButton:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    NSLog(@"%ld", indexPath.row);
}

- (IBAction)onUpvote:(id)sender {
    
}

- (IBAction)onDownvote:(id)sender {
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
