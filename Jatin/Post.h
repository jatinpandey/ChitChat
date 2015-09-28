//
//  Post.h
//  Jatin
//
//  Created by Jatin Pandey on 9/25/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Post : NSObject

@property NSString *objectId;
@property NSString *bodyContent;
@property NSNumber *voteCount;
@property NSInteger groupId;
@property NSString *groupName;
@property NSDate *createdAt;
@property NSDate *updatedAt;

- (instancetype) initPostFromObject:(PFObject *)postObject;
+ (instancetype) postWithObject:(PFObject *)postObject;

@end
