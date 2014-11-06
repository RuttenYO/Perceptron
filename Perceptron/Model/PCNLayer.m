//
//  PCNLayer.m
//  Perceptron
//
//  Created by Artem  on 09/10/14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNLayer.h"

@interface PCNLayer()

@property (nonatomic, assign) NSInteger countOfNeuronsAtLayer;
@property (nonatomic, strong) PCNNeuron *neuron;

@end

@implementation PCNLayer

- (id)initWithCountOfNeurons:(NSInteger) countOfNeurons
{
    self = [super init];
    if (self) {
        _countOfNeuronsAtLayer = countOfNeurons;
        _neuron = [[PCNNeuron alloc] init];
        _neuronsAtLayer = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < self.countOfNeuronsAtLayer; i++) {
            [self.neuronsAtLayer addObject:self.neuron];
        }
    }
    return self;
}

@end
