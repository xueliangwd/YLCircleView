//
//  TickCircleShapeLayer.m
//  HUDDemon
//
//  Created by Leon on 16/9/6.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "TickCircleShapeLayer.h"
@interface TickCircleShapeLayer(){
    TickCircleType _circleStyle; //样式
    CGPoint _circleCenter; //圆心
    CGFloat _circleRadius; //半径
    CGFloat _circleStartAngle; //起点（0-2PI）
    CGFloat _circleEndAngle; //终点（0-4PI）
}
@end
@implementation TickCircleShapeLayer

+(instancetype)TickCircleLayerWithArcCenter:(CGPoint)center radius:(CGFloat)radius style:(TickCircleType)style{
    TickCircleShapeLayer * tickLayer ;
    
    return tickLayer;
}
-(instancetype)initLayerWithArcCenter:(CGPoint)center radius:(CGFloat)radius style:(TickCircleType)style{
    self = [super init];
    if (self) {
        _circleCenter = center;
        _circleRadius = radius;
        _circleStyle = style;
        
        NSArray *arr =@[@(1),@(2.5)];
        
        self.lineDashPhase = 1.0;
        self.lineDashPattern = arr;
        self.fillColor = [UIColor clearColor].CGColor;
        
        _progressLayer = [CAShapeLayer layer];
        [self addSublayer:_progressLayer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineDashPhase = 1;
        _progressLayer.lineDashPattern = arr;
        
        self.trackColor = [UIColor grayColor];
        self.progressColor = [UIColor redColor];
        self.progressWidth = 10.0f;//默认是10
        [self refreshLayer];
    }
    return self;
}
-(void)refreshLayer{
    [self setAngle];
    [self setDashPattern];
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
        case TickCircleTypeCustom:
            if ([self.dataSource respondsToSelector:@selector(circleAngle)]) {
                TKArcAngle angle = [self.dataSource circleAngle];
                _circleStartAngle = angle.startAngle;
                _circleEndAngle = angle.endAngle;
            }
            break;
        default:
            break;
    }
}
-(void)setTrackColor:(UIColor *)trackColor{
    self.strokeColor = trackColor.CGColor;
}
-(void)setProgressColor:(UIColor *)progressColor{
    _progressLayer.strokeColor = progressColor.CGColor;
}
-(void)setDataSource:(id<TickCircleDatasource>)dataSource{
    _dataSource = dataSource;
    [self refreshLayer];
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
    self.lineWidth = _progressWidth;
    _progressLayer.lineWidth = _progressWidth;
}
-(void)setDashPattern{
    NSArray *arr = nil;
    if ([self.dataSource respondsToSelector:@selector(lineDashPatternArray)]) {
        arr = [self.dataSource lineDashPatternArray];
        self.lineDashPattern = arr;
        _progressLayer.lineDashPattern = arr;
    }
}
-(void)setBes{
    _trackPath = [UIBezierPath bezierPathWithArcCenter:_circleCenter radius:_circleRadius startAngle:_circleStartAngle endAngle:_circleEndAngle clockwise:YES];
    self.path = _trackPath.CGPath;
}

-(void)setProg{

    CGFloat endAngle =(_circleEndAngle - _circleStartAngle)*_progress+_circleStartAngle;
    _progressPath = [UIBezierPath bezierPathWithArcCenter:_circleCenter radius:_circleRadius startAngle:_circleStartAngle endAngle:endAngle clockwise:YES];
    _progressLayer.path = _progressPath.CGPath;
}
@end
