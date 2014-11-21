//
//  PCNLayer.h
//  Perceptron
//
//  Created by Artem  on 09/10/14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNNeuron.h"

@interface PCNLayer : PCNNeuron

@property (nonatomic, strong) NSMutableArray *neuronsAtLayer;
@property (nonatomic, strong) PCNNeuron *neuron;

- (id)initWithCountOfNeurons:(NSInteger)countOfNeurons;

@end
