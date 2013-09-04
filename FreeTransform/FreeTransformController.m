//
//  ViewController.m
//  TransformTest
//
//  Created by Josh Rooke-Ley on 8/30/13.
//  Copyright (c) 2013 Example. All rights reserved.
//

#import "FreeTransformController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Quadrilateral.h"

@interface FreeTransformController ()
@property (strong) UIView *contentView;
@property (strong) UIView *topLeftControl,*topRightControl,*bottomLeftControl,*bottomRightControl;
@end

@implementation FreeTransformController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UILabel *contentView = [[UILabel alloc] init];
    contentView.backgroundColor = [UIColor greenColor];
    
    //IMPORTANT: quad transform only works as expected when anchor point is (0,0)
    contentView.layer.anchorPoint = CGPointZero;
    contentView.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ullamcorper nulla metus, ac ultrices neque ultrices et. Vestibulum cursus vehicula justo ac vestibulum. Pellentesque tortor nisl, malesuada quis commodo vel, blandit ac velit. Fusce venenatis quam ut lacus dapibus pellentesque vel ut nibh. In ac ipsum et lorem sodales sollicitudin. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis posuere turpis vitae dui vehicula rhoncus";
    contentView.numberOfLines=0;
    contentView.font = [UIFont systemFontOfSize:10];
    contentView.textAlignment = NSTextAlignmentCenter;
    
    self.contentView = contentView;
    
    [self.view addSubview:contentView];
    
    
    //set some arbitrary control points (NOTE: doesn't work well with convex shapes)
    CGPoint tl = CGPointMake(60,129);
    CGPoint tr = CGPointMake(262,75);
    CGPoint bl = CGPointMake(57,292);
    CGPoint br = CGPointMake(265,278);
    
    
    self.topLeftControl = [self addControl:tl];
    self.topRightControl = [self addControl:tr];
    self.bottomLeftControl = [self addControl:bl];
    self.bottomRightControl = [self addControl:br];
    
    [self updateTranform];
    
    
}


- (UIView *)addControl:(CGPoint)p
{
    CGRect r = CGRectZero;
    r.origin = p;
    r.size = CGSizeMake(20, 20);
    
    UIView *control = [[UIView alloc] initWithFrame:r];
    control.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.5];
    [self.view addSubview:control];
    
    UIPanGestureRecognizer *rec=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragMarker:)];
    [control addGestureRecognizer:rec];
    return control;
}

- (void)dragMarker:(UIPanGestureRecognizer *)recognizer
{
    UIImageView *view = (UIImageView *)[recognizer view];
    
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint newCenter = view.center;
    newCenter.x += translation.x;
    newCenter.y += translation.y;
    view.center = newCenter;
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    [self updateTranform];
}

- (void)updateTranform
{
    
    //This is where the magic happens...
    [self.contentView transformToFitQuadTopLeft:self.topLeftControl.center
                                       topRight:self.topRightControl.center
                                     bottomLeft:self.bottomLeftControl.center
                                    bottomRight:self.bottomRightControl.center];

}


@end
