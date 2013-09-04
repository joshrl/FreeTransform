
#import <UIKit/UIKit.h>

@interface UIView (Quadrilateral)

//Set's frame to bounding box of quad and applies transform
- (void)transformToFitQuadTopLeft:(CGPoint)tl topRight:(CGPoint)tr bottomLeft:(CGPoint)bl bottomRight:(CGPoint)br;

@end
