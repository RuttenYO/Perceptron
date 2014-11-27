//
//  PCNNeuron.h
//  Perceptron
//
//  Created by Artyom Gavryushov on 30.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCNNeuron : NSObject

@property (nonatomic, readwrite) double neuronState;
@property (nonatomic, readwrite) double outputValue;

@end
