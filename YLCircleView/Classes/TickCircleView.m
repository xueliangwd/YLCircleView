//
//  TickCircleView.m
//  DigitalGym
//
//  Created by Leon on 16/9/9.
//  Copyright © 2016年 hiko. All rights reserved.
//

#import "TickCircleView.h"

@implementation TickCircleView
+(TickCircleView*)tickViewWithProColor:(UIColor*)proColor trackColor:(UIColor*)trackColor{
    TickCircleView* tickView = [[TickCircleView alloc]init];
    tickView.trackColor = trackColor;
    tickView.progressColor = proColor;
    tickView.circleStyle = TickCircleTypeOpenBottom;
    return tickView;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        _trackView = [[UIView alloc]init];
//        _trackView.backgroundColor = [UIColor clearColor];
//        _trackView.alpha = 0.3;
//        [self addSubview:_trackView];
//        
//        __progressView = [[UIView alloc]init];
//        __progressView.backgroundColor = [UIColor clearColor];
//        [self addSubview:__progressView];
        
        [self initSubLayer];
    }
    return self;
}
-(void)layoutSubviews{
//    _trackView.frame = self.bounds;
//    __progressView.frame = self.bounds;
    _circleCenter =CGPointMake(self.frame.size.width/2.0, self.frame.size.width/2.0);
    _circleRadius = self.frame.size.width/2.0;
    [self refreshLayer];
}

-(void)initSubLayer{
    _backLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_backLayer];
    _backLayer.fillColor = [UIColor clearColor].CGColor;
    _backLayer.lineWidth = 0.5;
    
    _triangleLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_triangleLayer];
    
    NSArray *arr =@[@(1),@(2.5)];
    
    _trackLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_trackLayer];
    _trackLayer.lineDashPhase = 1.0;
    _trackLayer.lineDashPattern = arr;
    _trackLayer.fillColor = [UIColor clearColor].CGColor;
    
    _progressLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.lineDashPhase = 1;
    _progressLayer.lineDashPattern = arr;
        
    self.trackColor = [UIColor grayColor];
    self.progressColor = [UIColor redColor];
    self.progressWidth = 10.0f;//默认是10
   
}
-(void)refreshLayer{
    [self setBackCicle];
    [self setTriangle];
    [self setAngle];
    [self setBes];
    [self setProg];
}
-(void)setAngle{
    switch (_circleStyle) {
        case TickCircleTypeCircle:
            _circleStartAngle = -M_PI_2;
            _circleEndAngle = 3/2.0f*M_PI;
            break;
        case TickCircleTypeOpenBottom:
            _circleStartAngle = 0.75* M_PI;
            _circleEndAngle = 2.25*M_PI;
            break;
        default:
            break;
    }
}

-(void)setTrackColor:(UIColor *)trackColor{
    _backLayer.strokeColor = trackColor.CGColor;
     _triangleLayer.strokeColor = trackColor.CGColor;
     _triangleLayer.fillColor = trackColor.CGColor;
     _trackLayer.strokeColor = trackColor.CGColor;
}
-(void)setProgressColor:(UIColor *)progressColor{
   _progressLayer.strokeColor = progressColor.CGColor;
}

-(void)setProgress:(float)progress{
    if (progress>1) {
        progress = 1.0f;
    }
    _progress = progress;
    [self setProg];
}
-(void)setProgress:(float)progress animated:(BOOL)animated{
    [self setProgress:progress];
    if (animated) {
        CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnima.duration = 2.0f;
        pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnima.fillMode = kCAFillModeForwards;
        pathAnima.removedOnCompletion = NO;
        [_progressLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    }
}
-(void)setProgressWidth:(float)progressWidth{
    _progressWidth = progressWidth;
    _trackLayer.lineWidth = _progressWidth;
    _progressLayer.lineWidth = _progressWidth;
}

-(void)setBackCicle{
    _backPath = [UIBezierPath bezierPathWithArcCenter:_circleCenter radius:_circleRadius startAngle:_circleStartAngle+0.01*M_PI endAngle:_circleEndAngle-0.01*M_PI clockwise:YES];
    
    _backLayer.path = _backPath.CGPath;
}

-(void)setTriangle{
    _trianglePath = [UIBezierPath bezierPath];
    [_trianglePath moveToPoint:CGPointMake(_circleCenter.x -1.5, _circleCenter.y - _circleRadius +1)];
    [_trianglePath addLineToPoint:CGPointMake(_circleCenter.x,_circleCenter.y - _circleRadius +6)];
    [_trianglePath addLineToPoint:CGPointMake(_circleCenter.x +1.5, _circleCenter.y - _circleRadius +1)];
    [_trianglePath closePath];
    _triangleLayer.path = _trianglePath.CGPath;
}
-(void)setBes{
    _trackPath = [UIBezierPath bezierPathWithArcCenter:_circleCenter radius:_circleRadius-20 startAngle:_circleStartAngle endAngle:_circleEndAngle clockwise:YES];
    _trackLayer.path = _trackPath.CGPath;
}

-(void)setProg{
    
    CGFloat endAngle =(_circleEndAngle - _circleStartAngle)*_progress+_circleStartAngle;
    _progressPath = [UIBezierPath bezierPathWithArcCenter:_circleCenter radius:_circleRadius-20 startAngle:_circleStartAngle endAngle:endAngle clockwise:YES];
    _progressLayer.path = _progressPath.CGPath;
}


@end
