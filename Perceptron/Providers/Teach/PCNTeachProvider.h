//
//  PCNTeachProvider.h
//  Perceptron
//
//  Created by Artyom Gavryushov on 14.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCNColorOfPointProtocol.h"

@interface PCNTeachProvider : NSObject

@property (nonatomic, strong) NSMutableArray *characterVectorArray;

- (id)initWithImageView:(UIImageView *)imageView delegate:(id<PCNColorOfPointProtocol>)delegate;
- (void)saveToFileVectorOfCharacter:(NSInteger)characterType;
- (void)vectorOfCharacter;

@end
