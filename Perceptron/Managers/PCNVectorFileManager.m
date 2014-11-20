//
//  PCNVectorFileManager.m
//  Perceptron
//
//  Created by Artyom Gavryushov on 06.10.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNVectorFileManager.h"

@interface PCNVectorFileManager()

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSArray *paths;

@property (nonatomic, strong) NSMutableArray *vectorsInFile;

@end

@implementation PCNVectorFileManager

- (id)init
{
    _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory = [self.paths objectAtIndex:0];
    _fileName = [NSString stringWithFormat:@"%@/vectorFile.txt", self.documentsDirectory];
    return self;
}

- (void)saveToTextFileCharacterVectorArray:(NSMutableArray *)characterVectorArray {
    [characterVectorArray writeToFile:self.fileName atomically:NO];
//    NSLog(@"%@",[self.vectorsInFile componentsJoinedByString:@"\n"]);
}

- (void)writeToTextFileCharacterVectorArray:(NSMutableArray *)characterVectorArray
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.fileName]) {
        self.vectorsInFile = [[NSMutableArray alloc] initWithContentsOfFile:self.fileName];
        [self.vectorsInFile addObject:characterVectorArray];
        [self saveToTextFileCharacterVectorArray:self.vectorsInFile];
    }
    else {
        self.vectorsInFile = [[NSMutableArray alloc] init];
        [self.vectorsInFile addObject:characterVectorArray];
        [self saveToTextFileCharacterVectorArray:self.vectorsInFile];
    }
}

- (NSMutableArray *)vectorsArray {
    return  [[NSMutableArray alloc] initWithContentsOfFile:self.fileName];
}

- (void)deleteVectorFile
{
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:self.fileName error:&error];
    if (error)
    {
        NSLog(@"%@", error);
    }
}


@end
