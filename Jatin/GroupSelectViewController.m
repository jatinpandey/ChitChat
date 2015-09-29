//
//  GroupSelectViewController.m
//  Jatin
//
//  Created by Jatin Pandey on 9/27/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import "GroupSelectViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GroupSelectViewController ()


@property (strong, nonatomic) IBOutlet UITextField *groupNameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *enterButton;

@end

@implementation GroupSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.enterButton.layer.borderWidth=2.0f;
    self.enterButton.layer.borderColor=[[UIColor colorWithRed:141.0/255.0 green:1 blue:185.0/255.0 alpha:1.0] CGColor];
    self.enterButton.layer.cornerRadius=8.0f;

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:99.0/255.0 green:73.0/255.0 blue:1 alpha:1.0]}];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:141.0/255.0 green:1 blue:185.0/255.0 alpha:1.0];

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:99.0/255.0 green:73.0/255.0 blue:1 alpha:1.0]}];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onEnterButton:(id)sender {
    id<GroupSelectDelegate> delegate = self.delegate;
    NSString *groupName = self.groupNameField.text;
    NSString *password = self.passwordField.text;

    [delegate didDismissWithGroup:(NSString *)groupName withPassword:(NSString *)password];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
