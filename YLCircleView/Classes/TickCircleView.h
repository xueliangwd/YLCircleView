//
//  TickCircleView.h
//  DigitalGym
//  刻度盘view
//  Created by Leon on 16/9/9.
//  Copyright © 2016年 hiko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger,TickCircleType){
    
    TickCircleTypeOpenBottom, //下开口圆
    TickCircleTypeCircle,//整圆
};


@interface TickCircleView : UIView{
    
//    TickCircleType _circleStyle; //样式
    CGPoint _circleCenter; //圆心
    CGFloat _circleRadius; //半径
    CGFloat _circleStartAngle; //起点（0-2PI）
    CGFloat _circleEndAngle; //终点（0-4PI）
    
    CAShapeLayer *_backLayer; //外环图层
    UIBezierPath *_backPath; //外环圆环path
    
    CAShapeLayer *_triangleLayer;//三角图层
    UIBezierPath *_trianglePath; //进度圆弧path
    
    CAShapeLayer *_trackLayer;//底色图层
    UIBezierPath *_trackPath; //底色圆环path
    
    CAShapeLayer *_progressLayer; //进度图层
    UIBezierPath *_progressPath; //进度圆弧path
//    UIView *_trackView;
//    UIView *__progressView;
}

@property(nonatomic,strong)UIColor *trackColor;//底色
@property(nonatomic,strong)UIColor *progressColor;//进度颜色
@property(nonatomic,assign)float progress;//0-1之间的数字
@property(nonatomic,assign)float progressWidth;
@property(nonatomic,assign)TickCircleType circleStyle; //样式
+(TickCircleView*)tickViewWithProColor:(UIColor*)proColor trackColor:(UIColor*)trackColor;
@end
