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
    
}

- (IBAction)onCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
