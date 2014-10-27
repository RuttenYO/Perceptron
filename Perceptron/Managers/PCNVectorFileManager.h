//
//  PCNVectorFileManager.h
//  Perceptron
//
//  Created by Artyom Gavryushov on 06.10.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCNVectorFileManager : NSObject

-(void) writeToTextFileVectorOfCharacterString:(NSString *)vectorOfCharacterString;
-(void) saveToTextFileVectorOfCharacterString:(NSString *)vectorOfCharacterString;
- (NSString *)showVectorFileString;
- (void)deleteVectorFile;

@end
