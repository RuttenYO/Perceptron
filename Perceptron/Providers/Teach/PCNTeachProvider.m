//
//  PCNTeachProvider.m
//  Perceptron
//
//  Created by Artyom Gavryushov on 14.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNTeachProvider.h"
#import "PCNDrawAreaView.h"
#import "PCNVectorFileManager.h"
#import "PCNNet.h"


@interface PCNTeachProvider()

@property (nonatomic, strong) UIImageView *characterImageView;
@property (nonatomic, strong) PCNVectorFileManager *fileManager;

@property (weak, nonatomic) id<PCNColorOfPointProtocol> colorOfPointDelegate;

@end

@implementation PCNTeachProvider

- (id)initWithImageView:(UIImageView *)imageView delegate:(id<PCNColorOfPointProtocol>)delegate{
    
    self = [super init];
    if (self) {
        _characterImageView = imageView;
        _characterVectorArray = [[NSMutableArray alloc] init];
        _colorOfPointDelegate = delegate;
        _fileManager = [[PCNVectorFileManager alloc] init];
    }
    return self;
}

- (void)vectorOfCharacter
{
    int countOfSections = 10;
    int dx = round(self.characterImageView.frame.size.width / countOfSections);
    int dy = round(self.characterImageView.frame.size.height/ countOfSections);
    UIColor *myBlackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    UIGraphicsBeginImageContext(self.characterImageView.frame.size);
    [self.characterImageView.image drawInRect:CGRectMake(0, 0, self.characterImageView.frame.size.width, self.characterImageView.frame.size.height)];
    
    for (int i=0; i<countOfSections; i++){
        for (int j = 0; j < countOfSections; j++){
            BOOL isBlackPixel = NO;
            for (int y = i * dy; y < (i+1) * dy; y++)
            {
                for (int x = j*dx; x < (j+1) * dx; x++)
                {
                    if ([[self.colorOfPointDelegate colorOfPoint:CGPointMake(x, y) inView:self.characterImageView] isEqual:myBlackColor]){
                        isBlackPixel = YES;
                    }
                }
                if (isBlackPixel) break;
            }
            if (isBlackPixel){
                [self.characterVectorArray addObject:@1];
            }else{
                [self.characterVectorArray addObject:@0];
            }
        }
    }
}

- (void)saveToFileVectorOfCharacter:(NSInteger)characterType
{    
    [self vectorOfCharacter];
    if (characterType == 0) {
        [self.characterVectorArray addObject:@1];
    } else {
        [self.characterVectorArray addObject:@(-1)];
    }
    NSLog(@"%@",[self.characterVectorArray componentsJoinedByString:@" "]);
    [self.fileManager writeToTextFileCharacterVectorArray:self.characterVectorArray];
//    PCNNet *net = [[PCNNet alloc] initWithCountOfLayers:3];
    
}

@end
