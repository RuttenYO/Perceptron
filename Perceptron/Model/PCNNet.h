//
//  PCNNet.h
//  Perceptron
//
//  Created by Artyom Gavryushov on 28.10.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNLayer.h"

@interface PCNNet : PCNLayer

@property (nonatomic, strong) NSMutableArray *layers;
@property (nonatomic, strong) NSMutableArray *weights;
@property (nonatomic, strong) NSMutableArray *neuronErrors;

- (id)initWithCountOfLayers:(NSInteger)countOfLayers;
- (void)assignWeights;

@end
