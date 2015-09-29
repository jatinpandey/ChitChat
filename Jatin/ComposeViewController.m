//
//  ComposeViewController.m
//  Jatin
//
//  Created by Jatin Pandey on 9/24/15.
//  Copyright © 2015 Jatin Pandey. All rights reserved.
//

#import "ComposeViewController.h"
#import <Parse/Parse.h>

@interface ComposeViewController ()

@property (strong, nonatomic) NSArray *groupsArray;
@property (strong, nonatomic) IBOutlet UITextField *toGroupField;
@property (strong, nonatomic) IBOutlet UILabel *characterCountLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sendButton;

@end

NSInteger MAX_MESSAGE_LENGTH = 140;
NSString *placeHolderText = @"What's on your mind?";

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupPicker.dataSource = self;
    self.groupPicker.delegate = self;
    self.messageTextView.delegate = self;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:141.0/255.0 green:1 blue:185.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:99.0/255.0 green:73.0/255.0 blue:1 alpha:1.0]}];
    
    [self.messageTextView setTintColor:[UIColor blackColor]];
    self.messageTextView.text = placeHolderText;
    self.messageTextView.textColor = [UIColor lightGrayColor];

    if (self.groupPicker) self.groupPicker.hidden = !(self.groupPicker.hidden);
    
    PFQuery *getAllGroups = [PFQuery queryWithClassName:@"Group"];
    [getAllGroups findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Fuckk this errored out! Error: %@", error.description);
        }
        else {
            NSMutableArray *allGroups = [[NSMutableArray alloc] init];
            for (PFObject *groupObject in objects) {
                [allGroups addObject:groupObject[@"groupName"]];
            }
            self.groupsArray = [NSArray arrayWithArray:allGroups];
            [self.groupPicker reloadAllComponents];
        }
    }];
    
    self.characterCountLabel.text = [NSString stringWithFormat:@"%ld", MAX_MESSAGE_LENGTH];
    self.sendButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSendTap:(id)sender {
    if ([self.messageTextView.text length] == 0 || self.messageTextView.textColor == [UIColor lightGrayColor]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Invalid message" message:@"Do not leave message body empty" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:^{
        }];
    } else {
        PFObject *newMessage = [PFObject objectWithClassName:@"Message"];
        newMessage[@"bodyContent"] = self.messageTextView.text;
        newMessage[@"toGroupName"] = self.toGroupField.text;
        newMessage[@"voteCount"] = @1;

        [newMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {

        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)onCancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.groupsArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.groupsArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return [[UIScreen mainScreen] bounds].size.width;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        self.characterCountLabel.text = [NSString stringWithFormat:@"%ld", MAX_MESSAGE_LENGTH];
        self.sendButton.enabled = NO;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text length] == 0) {
        self.messageTextView.text = placeHolderText;
        self.messageTextView.textColor = [UIColor lightGrayColor];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.textColor == [UIColor lightGrayColor] || [textView.text length] == 0) {
        self.characterCountLabel.text = [NSString stringWithFormat:@"%ld", MAX_MESSAGE_LENGTH];
        self.sendButton.enabled = NO;
    } else {
        NSInteger currentLength = [self.messageTextView.text length];
        self.characterCountLabel.text = [NSString stringWithFormat:@"%ld", (MAX_MESSAGE_LENGTH - currentLength)];
        if (currentLength > MAX_MESSAGE_LENGTH) {
            self.characterCountLabel.textColor = [UIColor redColor];
            self.sendButton.enabled = NO;
        } else {
            self.characterCountLabel.textColor = [UIColor colorWithRed:99.0/255.0 green:73.0/255.0 blue:1.0 alpha:1.0];
            self.sendButton.enabled = YES;
        }
    }
}

@end
