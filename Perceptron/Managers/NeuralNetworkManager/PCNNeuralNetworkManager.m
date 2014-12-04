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
#import "MBProgressHUD.h"

const NSInteger kLayersCount = 3;
const NSInteger kNumberOfLearningVectors = 70;
const NSInteger kMaxEpocheCount = 100;
const double kLearningRate = 0.5;

@interface PCNNeuralNetworkManager()

@property (nonatomic, strong) PCNVectorFileManager *vectorFileManager;

@property (nonatomic, strong) PCNNet *net;
@property (nonatomic, strong) NSMutableArray *learningArrays;
@property (nonatomic, strong) NSMutableArray *testingArrays;
@property (nonatomic, strong) NSMutableArray *netErrors;


@property (nonatomic, assign) NSInteger currentEpocheNumber;
@property (nonatomic, assign) double answerFromTeacher;
@property (nonatomic, assign) double currentError;

@end

@implementation PCNNeuralNetworkManager

- (id)init {
    self = [super init];
    if (self) {
        _vectorFileManager = [[PCNVectorFileManager alloc] init];
        
        _net = [[PCNNet alloc] initWithCountOfLayers:kLayersCount];
        _learningArrays = [[NSMutableArray alloc] init];
        _testingArrays = [[NSMutableArray alloc] init];
        _netErrors = [NSMutableArray new];
    }
    return self;
}

- (void)setSamplesWithLearningArray:(NSMutableArray *)learningArray {
    //shake all learning data
    NSLog(@"%@", learningArray);
    NSUInteger count = [learningArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [learningArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    if (self.learningArrays && self.testingArrays) {
        [self.learningArrays removeAllObjects];
        [self.testingArrays removeAllObjects];
    }
        double percentOfLearningVectorsDouble = (double)kNumberOfLearningVectors / 100;
        for (int i = 0; i < (count * percentOfLearningVectorsDouble); i++) {
            [self.learningArrays addObject:[learningArray objectAtIndex:i]];
        }
        for (int i = (int)(count * percentOfLearningVectorsDouble) + 1; i < [learningArray count]; i++) {
            [self.testingArrays addObject:[learningArray objectAtIndex:i]];
        }
}

- (void)setupOutputsForInputLayerWithVectorArray:(NSMutableArray *)vectorArray {
    int i = 0;
    for (PCNNeuron *neuron in [[[self.net layers] objectAtIndex:0] neuronsAtLayer]) {
        NSNumber *output = [vectorArray objectAtIndex:i];
        neuron.outputValue = output.doubleValue;
        i++;
    }
}

- (void)setAnswerFromTeacherForLearningArrayAtIndex:(int)index {
    self.answerFromTeacher = [(NSNumber *)[[self.learningArrays objectAtIndex:index] lastObject] doubleValue];
}

#define alpha 1
- (double)activationFunction:(double)x {
    return tanh(alpha*x);
}

- (double) activationFunctionDerivative:(double)x {
    double t = tanh(alpha * x);
    return alpha * (1 - t * t);
}

#pragma mark - Algorytms

- (void)forwardPass {
    for (int l = 1; l < kLayersCount; l++) {
        for (int i=0; i<[[self.net.layers[l] neuronsAtLayer] count]; i++) {
            double summator=0;
            for (int j = 0; j < [[self.net.layers[l - 1] neuronsAtLayer] count]; j++) {
                summator = summator + [(NSNumber *)self.net.weights[l-1][i][j] doubleValue] * [[self.net.layers[l-1] neuronsAtLayer][j] outputValue];
            }
            [[self.net.layers[l] neuronsAtLayer][i] setNeuronState:summator];
            [[self.net.layers[l] neuronsAtLayer][i] setOutputValue: [self activationFunction:summator]];
        }
    }
}

- (void)calculateNetworkError {
    self.currentError = 0;
    for (int i = 0; i < [[self.net.layers[kLayersCount - 1] neuronsAtLayer] count]; i++) {
        self.currentError += 0.5*pow([[self.net.layers[kLayersCount - 1] neuronsAtLayer][i] outputValue] - self.answerFromTeacher, 2);
    }
    [self.netErrors addObject:@(self.currentError)];
}

- (void)backwardPass {
    [self assignNeuronErrors];
    [self assignNewWeights];
}

- (void) assignNeuronErrors {
    for (int l = kLayersCount - 1; l > 0; l--) {
        for (int i = 0; i < [[self.net.layers[l] neuronsAtLayer] count]; i++) {
            double neuronError=0;
            if (l == (kLayersCount - 1)) {
                [[self.net.layers[l] neuronsAtLayer][i] setNeuronError:[[self.net.layers[l] neuronsAtLayer][i] outputValue] - self.answerFromTeacher];
            }
            else {
                for (int j = 0; j < [[self.net.layers[l+1] neuronsAtLayer] count]; j++)
                    neuronError += [[self.net.layers[l+1] neuronsAtLayer][j] neuronError]  * [self.net.weights[l][j][i] doubleValue];
                neuronError *= [self activationFunctionDerivative:[[self.net.layers[l] neuronsAtLayer][i] neuronState]];
                [[self.net.layers[l] neuronsAtLayer][i] setNeuronError:neuronError];
            }
        }
    }
}

- (void)assignNewWeights {
    for (int l = 1; l < kLayersCount; l++) {
        for (int i = 0; i < [[[self.net.layers objectAtIndex:l] neuronsAtLayer] count]; i++) {
            for (int j = 0; j < [[[self.net.layers objectAtIndex:l - 1] neuronsAtLayer] count]; j++) {
                self.net.weights[l-1][i][j] = @([self.net.weights[l-1][i][j] doubleValue] - kLearningRate * [[self.net.layers[l] neuronsAtLayer][i] neuronError] * [[self.net.layers[l-1] neuronsAtLayer][j] outputValue]);
            }
        }
    }
}

- (void)teachNetwork {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD showHUDAddedTo:window
                         animated:YES];
    
    NSNumber *learningError = @(-1);
    NSNumber *testingError = @(1);
    NSInteger epocheCount=0;
    
    while (fabs(learningError.doubleValue - testingError.doubleValue) > 0.0001 && epocheCount<kMaxEpocheCount) {
        learningError = @0;
        for (int i = 0; i < [self.learningArrays count]; i++) {
            [self setupOutputsForInputLayerWithVectorArray:self.learningArrays[i]];
            [self forwardPass];
            [self setAnswerFromTeacherForLearningArrayAtIndex:i];
            [self calculateNetworkError];
            [self backwardPass];
        }
        for (int i = 0; i < [self.netErrors count]; i++)
            learningError = @(learningError.doubleValue + [self.netErrors[i] doubleValue]);
        learningError = @(learningError.doubleValue/[self.netErrors count]);
        [self.netErrors removeAllObjects];
        
        testingError = @0;
        for (int i = 0; i < [self.testingArrays count]; i++) {
            [self setupOutputsForInputLayerWithVectorArray:self.learningArrays[i]];
            [self forwardPass];
            [self setAnswerFromTeacherForLearningArrayAtIndex:i];
            [self calculateNetworkError];
        }
        for (int i = 0; i < [self.netErrors count]; i++)
            testingError = @(testingError.doubleValue + [self.netErrors[i] doubleValue]);
        testingError = @(testingError.doubleValue/[self.netErrors count]);
        [self.netErrors removeAllObjects];
        
        epocheCount++;
    }
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
}

- (double)recognizeWithVectorArray:(NSMutableArray *)vectorArray {
    
    [self setupOutputsForInputLayerWithVectorArray:vectorArray];
    [self forwardPass];
    
    return [[self.net.layers[kLayersCount - 1] neuronsAtLayer][[[self.net.layers[kLayersCount-1] neuronsAtLayer] count] -1] outputValue];
}



@end
