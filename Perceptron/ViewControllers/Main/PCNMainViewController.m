//
//  PCNViewController.m
//  Perceptron
//
//  Created by Artyom Gavryushov on 14.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNMainViewController.h"
#import "PCNDrawAreaView.h"

@interface PCNMainViewController ()

@property (strong, nonatomic) IBOutlet UIView *drawAreaViewContainerView;
@property (strong, nonatomic) PCNDrawAreaView *drawAreaView;

@end

@implementation PCNMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _drawAreaView = [[PCNDrawAreaView alloc] init];
    [_drawAreaViewContainerView addSubview:self.drawAreaView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
