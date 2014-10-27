//
//  PCNShowVectorFileViewController.m
//  Perceptron
//
//  Created by Artyom Gavryushov on 27.10.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNShowVectorFileViewController.h"
#import "PCNVectorFileManager.h"

@interface PCNShowVectorFileViewController ()

@property (strong, nonatomic) IBOutlet UITextView *vectorFileTextView;

@end

@implementation PCNShowVectorFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PCNVectorFileManager *fileManager = [[PCNVectorFileManager alloc] init];
    NSString *vectorFileText = [fileManager showVectorFileString];
    [self.vectorFileTextView setText:vectorFileText];
}

- (IBAction)backButtonDidPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveVectorToFile:(id)sender {
    [self.vectorFileTextView resignFirstResponder];
    PCNVectorFileManager *fileManager = [[PCNVectorFileManager alloc] init];
    [fileManager saveToTextFileVectorOfCharacterString:[self.vectorFileTextView text]];
}


@end
