//
//  Post.m
//  Jatin
//
//  Created by Jatin Pandey on 9/25/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import "Post.h"

@implementation Post

- (instancetype) initPostFromObject:(PFObject *)postObject {
    self = [super init];
    if (self) {
        self.objectId = [postObject objectId];
        self.bodyContent = postObject[@"bodyContent"];
        self.voteCount = postObject[@"voteCount"];
        self.groupName = postObject[@"groupName"];
        self.createdAt = [postObject createdAt];
        self.updatedAt = [postObject updatedAt];
    }
    return self;
}

+ (instancetype) postWithObject:(PFObject *)postObject {
    return [[Post alloc] initPostFromObject:postObject];
}


@end
