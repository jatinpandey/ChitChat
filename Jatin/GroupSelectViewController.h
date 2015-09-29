//
//  GroupSelectViewController.h
//  Jatin
//
//  Created by Jatin Pandey on 9/27/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GroupSelectDelegate <NSObject>

- (void) didDismissWithGroup:(NSString *)groupName withPassword:(NSString *)password;

@end

@interface GroupSelectViewController : UIViewController

@property (nonatomic, weak) id<GroupSelectDelegate> delegate;

@end
