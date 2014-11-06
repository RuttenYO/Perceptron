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
    [self showFileContent];
}

- (IBAction)backButtonDidPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showFileContent {
    PCNVectorFileManager *fileManager = [[PCNVectorFileManager alloc] init];
    NSString *vectorFileText;
    NSMutableArray *vectorsArray = [fileManager vectorsArray];
    for (NSMutableArray *vector in vectorsArray) {
        if (vectorFileText == nil) {
            vectorFileText = [vector componentsJoinedByString:@" "];
        }
        else {
        vectorFileText = [vectorFileText stringByAppendingString:[vector componentsJoinedByString:@" "]];
        }
        vectorFileText = [vectorFileText stringByAppendingString:@"\n"];
    }
    NSLog(@"%@", vectorFileText);
    [self.vectorFileTextView setText:vectorFileText];
}


@end
