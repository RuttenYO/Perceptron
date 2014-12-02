//
//  PCNNeuralNetworkManager.h
//  Perceptron
//
//  Created by Artyom Gavryushov on 20.11.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCNNeuralNetworkManager : NSObject

- (void)setSamplesWithLearningArray:(NSMutableArray *)learningArray;
- (void)teachNetwork;
- (double)recognizeWithVectorArray:(NSMutableArray *)vectorArray;



@end
