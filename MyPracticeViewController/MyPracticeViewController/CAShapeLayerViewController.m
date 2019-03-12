//
//  CAShapeLayerViewController.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 16/11/10.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController (){
    UIView *_dynamicView;
    CAShapeLayer *_indicateLayer;
}

@end

@implementation CAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self huaTong];
}
- (void)juXing{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 100, 80, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    CAShapeLayer *layer = [self createMaskLayerWithView:view];
    view.layer.mask = layer;
}
- (CAShapeLayer *)createMaskLayerWithView : (UIView *)view {
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    CGFloat rightSpace = 10.;
    CGFloat topSpace = 15.;
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(viewWidth, topSpace);
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
    CGPoint point7 = CGPointMake(0, viewHeight);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    return layer;
}
- (void)huaTong {
    _dynamicView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 100)];
    _dynamicView.backgroundColor = [UIColor lightGrayColor];
    _dynamicView.layer.cornerRadius = 25;
    _dynamicView.clipsToBounds = YES;
    [self.view addSubview:_dynamicView];
    
    [self refreshUIWithVoicePower:0.5];
}
static int TOTAL_NUM = 5;

-(void)refreshUIWithVoicePower : (NSInteger)voicePower{
    CGFloat height = (voicePower)*(CGRectGetHeight(_dynamicView.frame)/TOTAL_NUM);
    [_indicateLayer removeFromSuperlayer];
    _indicateLayer = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetHeight(_dynamicView.frame)-height, CGRectGetWidth(_dynamicView.frame), height) cornerRadius:0];
    _indicateLayer = [CAShapeLayer layer];
    _indicateLayer.path = path.CGPath;
    _indicateLayer.fillColor = [UIColor whiteColor].CGColor;
    [_dynamicView.layer addSublayer:_indicateLayer];
}
-(void)yuanxing{
    _dynamicView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _dynamicView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_dynamicView];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _dynamicView.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_dynamicView.bounds];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [_dynamicView.layer addSublayer:shapeLayer];
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 3.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
