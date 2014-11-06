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
@property (nonatomic, strong) PCNLayer *layer;

@end

@implementation PCNNet

- (id)initWithCountOfLayers:(NSInteger) countOfLayers;
{
    self = [super init];
    if (self) {
        _countOfLayersAtNet = countOfLayers;
        _layers = [[NSMutableArray alloc] init];
        _weights = [[NSMutableArray alloc] init];
        _neuronErrors = [[NSMutableArray alloc] init];
        
        [self.layers addObject:[self.layer initWithCountOfNeurons:100]];
        [self.layers addObject:[self.layer initWithCountOfNeurons:20]];
        [self.layers addObject:[self.layer initWithCountOfNeurons:1]];
    }
    return self;
}

- (void)assignWeights {
    
    for (int i = 1; i < self.countOfLayersAtNet; i++)
        for (int j = 0; j < [[self.layers[i] neuronsAtLayer] count]; j++)
            for (int k = 0; k < [[self.layers[i - 1] neuronsAtLayer] count]; k++) {
                srand48(time(0));
                double r = drand48();
                [self.weights[i][j][k] addObject:[NSNumber numberWithDouble:r]];
            }
    NSLog(@"%@", self.weights);
}



@end
