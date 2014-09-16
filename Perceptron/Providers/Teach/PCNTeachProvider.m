//
//  PCNTeachProvider.m
//  Perceptron
//
//  Created by Artyom Gavryushov on 14.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNTeachProvider.h"
#import "PCNDrawAreaView.h"


@interface PCNTeachProvider()

@property (nonatomic, strong) UIImageView *characterImageView;
@property (nonatomic, strong) NSString *vectorOfCharacterString;
@property (nonatomic, strong) NSArray *paths;
@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *fileName;

@property (weak, nonatomic) id<PCNColorOfPointProtocol> colorOfPointDelegate;

@end

@implementation PCNTeachProvider

- (id)initWithImageView:(UIImageView *)imageView delegate:(id<PCNColorOfPointProtocol>)delegate{
    
    self = [super init];
    if (self) {
        _characterImageView = imageView;
        _vectorOfCharacterString = [[NSString alloc] initWithFormat:@""];
        _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentsDirectory = [self.paths objectAtIndex:0];
        _fileName = [NSString stringWithFormat:@"%@/vectorA.txt",
                              self.documentsDirectory];
        _colorOfPointDelegate = delegate;
    }
    return self;
}

- (void)vectorOfCharacter{
    
    int countOfSections = 10;
    int dx = round(self.characterImageView.frame.size.width / countOfSections);
    int dy = round(self.characterImageView.frame.size.height/ countOfSections);
    UIColor *myBlackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    UIGraphicsBeginImageContext(self.characterImageView.frame.size);
    [self.characterImageView.image drawInRect:CGRectMake(0, 0, self.characterImageView.frame.size.width, self.characterImageView.frame.size.height)];
    
    for (int i=0; i<countOfSections; i++){
        for (int j = 0; j < countOfSections; j++){
            BOOL isBlackPixel = NO;
            for (int x = i * dx; x < (i+1) * dx; x++)
            {
                for (int y = j*dy; y < (j+1) * dy; y++)
                {
                    if ([[self.colorOfPointDelegate colorOfPoint:CGPointMake(x, y) inView:self.characterImageView] isEqual:myBlackColor]){
                        isBlackPixel = YES;
                    }
                }
                if (isBlackPixel) break;
            }
            if (isBlackPixel){
                self.vectorOfCharacterString = [self.vectorOfCharacterString stringByAppendingString:@"1"];
            }else{
                self.vectorOfCharacterString = [self.vectorOfCharacterString stringByAppendingString:@"0"];
            }
        }
    }
    NSLog(@"%@", self.vectorOfCharacterString);
}

-(void) writeToTextFile{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.fileName]) {
        NSString *contentOfFile = [[NSString alloc] initWithContentsOfFile:self.fileName
                                                              usedEncoding:nil
                                                                     error:nil];
        contentOfFile = [contentOfFile stringByAppendingString:@"\n"];
        NSLog(@"%@", contentOfFile);
        contentOfFile = [contentOfFile stringByAppendingString:self.vectorOfCharacterString];
        [contentOfFile writeToFile:self.fileName
                        atomically:NO
                          encoding:NSStringEncodingConversionAllowLossy
                             error:nil];
        
    }else{
        [self.vectorOfCharacterString writeToFile:self.fileName
                                       atomically:NO
                                         encoding:NSStringEncodingConversionAllowLossy
                                            error:nil];
    }
    
}

- (void)saveToFileVectorOfCharacter:(NSInteger)characterType{
    
    [self vectorOfCharacter];
    if (characterType == 0) {
         self.vectorOfCharacterString = [self.vectorOfCharacterString stringByAppendingString:@"1"];
    } else {
         self.vectorOfCharacterString = [self.vectorOfCharacterString stringByAppendingString:@"-1"];
    }
    [self writeToTextFile];
    
}

- (void)tempMethodForDeletingFile{
    
    [[NSFileManager defaultManager] createFileAtPath:self.fileName contents:[NSData data] attributes:nil];
    
}


@end
