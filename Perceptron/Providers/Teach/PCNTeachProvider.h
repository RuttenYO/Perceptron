//
//  PCNTeachProvider.h
//  Perceptron
//
//  Created by Artyom Gavryushov on 14.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCNTeachProvider : NSObject

-(id)initWithImageView:(UIImageView *)imageView;
- (void)saveToFileVectorOfCharacter:(NSInteger)characterType;

@end
