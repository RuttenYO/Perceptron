//
//  PCNVectorFileManager.h
//  Perceptron
//
//  Created by Artyom Gavryushov on 06.10.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCNVectorFileManager : NSObject

- (void)writeToTextFileCharacterVectorArray:(NSMutableArray *)characterVectorArray;
- (void)saveToTextFileCharacterVectorArray:(NSMutableArray *)characterVectorArray;
- (NSMutableArray *)vectorsArray;
- (void)deleteVectorFile;

@end
