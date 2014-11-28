//
//  PCNNet.m
//  Perceptron
//
//  Created by Artyom Gavryushov on 28.10.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNNet.h"
#import "PCNTeachProvider.h"

@interface PCNNet()

@property (nonatomic, assign) NSInteger countOfLayersAtNet;

@end

@implementation PCNNet

- (id)initWithCountOfLayers:(NSInteger)countOfLayers {
    self = [super init];
    if (self) {
        self.countOfLayersAtNet = countOfLayers;
        _layers = [[NSMutableArray alloc] init];
        _weights = [[NSMutableArray alloc] init];
//        _neuronErrors = [[NSMutableArray alloc] init];
        
        PCNLayer *firstLayer = [[PCNLayer alloc] initWithCountOfNeurons:100];
        PCNLayer *secondLayer = [[PCNLayer alloc] initWithCountOfNeurons:20];
        PCNLayer *thirdLayer = [[PCNLayer alloc] initWithCountOfNeurons:1];
        [self.layers addObject:firstLayer];
        [self.layers addObject:secondLayer];
        [self.layers addObject:thirdLayer];
        
        [self assignWeights];
        
    }
    return self;
}


#pragma mark - Setting Neuroal Network
- (void)assignWeights {
    for (int l = 1; l < self.countOfLayersAtNet; l++) { //ploskosti (2)
        NSMutableArray *tempLayersArray = [NSMutableArray array];
        
        for (int i = 0; i < [[[self.layers objectAtIndex:l] neuronsAtLayer] count]; i++) { //kolonki (20)
            NSMutableArray *tempNeuronsAtCurrentLayerArray = [NSMutableArray array];
            
            for (int j = 0; j < [[[self.layers objectAtIndex:l - 1] neuronsAtLayer] count]; j++) { //stroki (100)
                [tempNeuronsAtCurrentLayerArray addObject:@(floorf([self getRandom]*100)/100)];
            }
            [tempLayersArray addObject:tempNeuronsAtCurrentLayerArray];
        }
        [self.weights addObject:tempLayersArray];
    }
//    NSLog(@"WEIGHTS %@", self.weights);
}

- (float)getRandom {
    float number = (((float) rand() / RAND_MAX) * 1) -0.5;
    if (number == 0.00 ) {
        number = 0.2;
    }
    return number;
}

@end
