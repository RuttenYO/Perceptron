//
//  PCNDrawAreaView.h
//  Perceptron
//
//  Created by Artyom Gavryushov on 14.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCNColorOfPointProtocol.h"

@interface PCNDrawAreaView : UIView<PCNColorOfPointProtocol>

- (UIImageView *)trimmedCharacterImage;
- (void)clearDrawAreaImage;

@end
