//
//  PCNColorOfPointProtocol.h
//  Perceptron
//
//  Created by Artyom Gavryushov on 16.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PCNColorOfPointProtocol <NSObject>

- (UIColor *)colorOfPoint:(CGPoint)point inView:(UIView *)view;

@end
