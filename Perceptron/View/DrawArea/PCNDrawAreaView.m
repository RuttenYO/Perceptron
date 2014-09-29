//
//  PCNDrawAreaView.m
//  Perceptron
//
//  Created by Artyom Gavryushov on 14.09.14.
//  Copyright (c) 2014 Gavr corp. All rights reserved.
//

#import "PCNDrawAreaView.h"

@interface PCNDrawAreaView()

@property (nonatomic, assign) BOOL mouseSwiped;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) CGFloat brush;
@property (strong, nonatomic) IBOutlet UIImageView *drawImageView;

@end

@implementation PCNDrawAreaView

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    _brush = 5.0;
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    UIGraphicsBeginImageContext(self.frame.size);
    [self.drawImageView.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor blackColor].CGColor);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.drawImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!self.mouseSwiped) {
        UIGraphicsBeginImageContext(self.frame.size);
        [self.drawImageView.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor blackColor].CGColor);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.drawImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

- (UIImageView *)trimmedCharacterImage{
    
    CGPoint characterUpperLeftCornerPoint;
    CGPoint characterLowerRightCornerPoint;
    UIImageView *trimmedImageView;
    CGRect trimmedRect;
    UIColor *myBlackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];

    
    characterUpperLeftCornerPoint = CGPointMake(-1, self.frame.size.height);
    characterLowerRightCornerPoint = CGPointMake(-1, 0);
    
    UIGraphicsBeginImageContext(self.frame.size);
    [self.drawImageView.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    for (int i=0; i < self.frame.size.width; i++) {
        for (int j=0; j < self.frame.size.height; j++) {
            
            if ([[self colorOfPoint:CGPointMake(i, j) inView:self] isEqual:myBlackColor]) {
                if (characterUpperLeftCornerPoint.x == -1) {
                    characterUpperLeftCornerPoint.x = i;
                }
                characterUpperLeftCornerPoint.y = MIN(j, characterUpperLeftCornerPoint.y);
                characterLowerRightCornerPoint = CGPointMake(i, MAX(characterLowerRightCornerPoint.y, j));
            }
        }
    }
    trimmedRect = CGRectMake(characterUpperLeftCornerPoint.x, characterUpperLeftCornerPoint.y, characterLowerRightCornerPoint.x - characterUpperLeftCornerPoint.x, characterLowerRightCornerPoint.y - characterUpperLeftCornerPoint.y);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self.drawImageView.image CGImage], trimmedRect);
    UIImage *tempImage;
    tempImage = [UIImage imageWithCGImage:imageRef];
    trimmedImageView = [[UIImageView alloc] initWithFrame:trimmedRect];
    trimmedImageView.image = tempImage;
    
    CGContextAddRect(UIGraphicsGetCurrentContext(), trimmedRect);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.drawImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return trimmedImageView;
}

- (void)clearDrawAreaImage{
    self.drawImageView.image = nil;
}

#pragma mark - PCNColorOfPointProtocol methods

- (UIColor *)colorOfPoint:(CGPoint)point inView:(UIView *)view
{
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [view.layer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}

@end
