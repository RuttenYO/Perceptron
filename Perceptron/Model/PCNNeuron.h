//
//  PCNNeuron.h
//  Perceptron
//
//  Created by Artyom Gavryushov on 30.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCNNeuron : NSObject

@property (nonatomic, assign) double neuronState;
@property (nonatomic, assign) double outputValue;
@property (nonatomic, assign) double neuronError;

@end
