//
//  PCNNeuralNetworkManager.m
//  Perceptron
//
//  Created by Artyom Gavryushov on 20.11.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNNeuralNetworkManager.h"
#import "PCNVectorFileManager.h"
#import "PCNNet.h"

const NSInteger kLayersCount = 3;
const NSInteger kNumberOfLearningVectors = 70;
const NSInteger kMaxEpocheCount = 100;

@interface PCNNeuralNetworkManager()

@property (nonatomic, strong) PCNVectorFileManager *vectorFileManager;

@property (nonatomic, strong) PCNNet *net;
@property (nonatomic, strong) NSMutableArray *learningArrays;
@property (nonatomic, strong) NSMutableArray *testingArrays;

@property (nonatomic, assign) NSInteger currentEpocheNumber;

@end

@implementation PCNNeuralNetworkManager

- (id)init
{
    self = [super init];
    if (self) {
        _vectorFileManager = [[PCNVectorFileManager alloc] init];
        
        _net = [[PCNNet alloc] initWithCountOfLayers:kLayersCount];
        _learningArrays = [[NSMutableArray alloc] init];
        _testingArrays = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setSamplesWithLearningArray:(NSMutableArray *)learningArray {
    if (self.learningArrays && self.testingArrays) {
        [self.learningArrays removeAllObjects];
        [self.testingArrays removeAllObjects];
    }
        double percentOfLearningVectorsDouble = (double)kNumberOfLearningVectors / 100;
        for (int i = 0; i < ([learningArray count] * percentOfLearningVectorsDouble); i++) {
            [self.learningArrays addObject:[learningArray objectAtIndex:i]];
        }
        for (int i = (int)([learningArray count] * percentOfLearningVectorsDouble) + 1; i < [learningArray count]; i++) {
            [self.testingArrays addObject:[learningArray objectAtIndex:i]];
        }
}

- (void)setupOutputsForInputLayerWithVectorArray:(NSMutableArray *)vectorArray {
    int i = 0;
    for (PCNNeuron *neuron in [[[self.net layers] objectAtIndex:0] neuronsAtLayer]) {
        NSNumber *output = [vectorArray objectAtIndex:i];
        neuron.output = output.doubleValue;
        i++;
    }
//    for (int j = 0; j < [[[[self.net layers] objectAtIndex:0] neuronsAtLayer] count]; j++) {
//        NSNumber *output = [vectorArray objectAtIndex:i];
////        [[[[[self.net layers] objectAtIndex:0] neuronsAtLayer] objectAtIndex:j] output] = output.doubleValue;
//        [[[self.net layers] objectAtIndex:0] neuronsAtLayer[j]].output = output.doubleValue;
//
//    }
//    for (int i = 0; i < net.layers[0].neuronsOnLayer.Length; i++)
//        net.layers[0].neuronsOnLayer[i].output = qList.ElementAt(i);
}

- (double)getAnswerFromTeacherForLearningArraysAtIndex:(int)index
{
    NSNumber *answer =  [[self.learningArrays objectAtIndex:index] objectAtIndex:100];
    return answer.doubleValue;
}

#define alpha 1
- (double)activationFunction:(double)x
{
    return tanh(alpha*x);
}

- (double) activationFunctionDerivative:(double)x
{
    double t = tanh(alpha * x);
    return alpha * (1 - t * t);
}

#pragma mark - Algorytms

//- (void)forwardPassWithAnswer:(double)answer ifNeeded:(BOOL)ifNeeded
//{
//    for (int l = 1; l < kLayersCount; l++) {
//        for (int i=0; i<[[self.net.layers[l] neuronsAtLayer] count]; i++) {
//            double summator=0;
//            for (int j = 0; j < [[self.net.layers[l - 1] neuronsAtLayer] count]; j++) {
//                summator += [(NSNumber *)self.net.weights[l][i][j] doubleValue] * [self.net.layers[l-1][j] output];
//            }
//            PCNNeuron *neuron = [[self.net.layers[l] neuronsAtLayer] objectAtIndex:i];
//            neuron.neuronState = summator;
//            net.layers[l].neuronsOnLayer[i].output = activationFunction(summator);
//        }
//    }
//    
//    if (ifNeeded)
//    {
//        currentError = 0;
//        for (int i = 0; i < net.layers[countOfLayersInNet - 1].neuronsOnLayer.Length; i++)
//            currentError += Math.Pow(net.layers[countOfLayersInNet - 1].neuronsOnLayer[i].output - answer, 2);
//        
//        currentError /= 2;
//        errors.Add(currentError);
//    }
//}


@end
