//
//  PCNViewController.m
//  Perceptron
//
//  Created by Artyom Gavryushov on 14.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNMainViewController.h"
#import "PCNDrawAreaView.h"
#import "PCNTeachProvider.h"
#import "PCNVectorFileManager.h"

@interface PCNMainViewController ()

@property (strong, nonatomic) IBOutlet UIView *drawAreaViewContainerView;
@property (strong, nonatomic) PCNDrawAreaView *drawAreaView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *teachingCharacterSegmentedControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;
@property (strong, nonatomic) IBOutlet UIButton *teachButton;
@property (strong, nonatomic) IBOutlet UILabel *recognizeAnswerLabel;
@property (strong, nonatomic) IBOutlet UIButton *recognizeButton;

@property (strong, nonatomic) PCNTeachProvider* teacher;
@property (strong, nonatomic) UIImageView *characterImageView;

@end

@implementation PCNMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _drawAreaView = [[PCNDrawAreaView alloc] init];
    [_drawAreaViewContainerView addSubview:self.drawAreaView];
    self.recognizeAnswerLabel.hidden = YES;
    self.recognizeButton.hidden = YES;
}

- (IBAction)clearDrawAreaDidPressed:(id)sender {
    [self.drawAreaView clearDrawAreaImage];
}

- (IBAction)modeValueChanged:(id)sender {
    if (self.modeSegmentedControl.selectedSegmentIndex == 0) {
            self.teachingCharacterSegmentedControl.hidden = NO;
        self.teachButton.hidden = NO;
        self.recognizeAnswerLabel.hidden = YES;
        self.recognizeButton.hidden = YES;
    } else {
            self.teachingCharacterSegmentedControl.hidden = YES;
        self.teachButton.hidden = YES;
        self.recognizeAnswerLabel.hidden = NO;
        self.recognizeButton.hidden = NO;
    }
}

- (IBAction)cleareVectorFileDidPressed:(id)sender {
    PCNVectorFileManager *fileManager = [[PCNVectorFileManager alloc] init];
    [fileManager deleteVectorFile];
}

- (IBAction)teachButtonDidPressed:(id)sender
{
    self.characterImageView = [self.drawAreaView trimmedCharacterImage];
    self.teacher = [[PCNTeachProvider alloc] initWithImageView:self.characterImageView delegate:self.drawAreaView];
    [self.teacher saveToFileVectorOfCharacter:self.teachingCharacterSegmentedControl.selectedSegmentIndex];
    
}

- (IBAction)recognizeButtonDidPressed:(id)sender {
    //trololo
    
}

-(BOOL)shouldAutorotate {
    return NO;
}

@end
