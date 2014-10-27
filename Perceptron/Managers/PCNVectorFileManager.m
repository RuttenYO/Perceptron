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

@end

@implementation PCNVectorFileManager

- (id)init
{
    _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory = [self.paths objectAtIndex:0];
    _fileName = [NSString stringWithFormat:@"%@/vectorFile.txt",
                 self.documentsDirectory];
    return self;
}

-(void) saveToTextFileVectorOfCharacterString:(NSString *)vectorOfCharacterString {
    [vectorOfCharacterString writeToFile:self.fileName
                              atomically:NO
                                encoding:NSStringEncodingConversionAllowLossy
                                   error:nil];
}

-(void) writeToTextFileVectorOfCharacterString:(NSString *)vectorOfCharacterString
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.fileName]) {
        NSString *contentOfFile = [[NSString alloc] initWithContentsOfFile:self.fileName
                                                              usedEncoding:nil
                                                                     error:nil];
        contentOfFile = [contentOfFile stringByAppendingString:@"\n"];
        NSLog(@"%@", contentOfFile);
        contentOfFile = [contentOfFile stringByAppendingString:vectorOfCharacterString];
        [self saveToTextFileVectorOfCharacterString:contentOfFile];
//        [contentOfFile writeToFile:self.fileName
//                        atomically:NO
//                          encoding:NSStringEncodingConversionAllowLossy
//                             error:nil];
    }else{
        [self saveToTextFileVectorOfCharacterString:vectorOfCharacterString];
//        [vectorOfCharacterString writeToFile:self.fileName
//                                       atomically:NO
//                                         encoding:NSStringEncodingConversionAllowLossy
//                                            error:nil];
    }
}

- (NSString *)showVectorFileString {
    return  [[NSString alloc] initWithContentsOfFile:self.fileName
                                        usedEncoding:nil
                                               error:nil];
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
