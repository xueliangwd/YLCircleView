//
//  TickCircleShapeLayer.h
//  刻度圆环 使用例子如下:
/****************example*****************/
/*
TickCircleShapeLayer * tkLayer = [[TickCircleShapeLayer alloc]initLayerWithArcCenter:CGPointMake(200, 400) radius:80 style:TickCircleTypeCustom]; //TickCircleTypeCircle TickCircleTypeOpenBottom
tkLayer.dataSource = self;
tkLayer.trackColor = [UIColor grayColor];//设置圆环底色
tkLayer.progressColor = [UIColor redColor];//设置圆环进度颜色
tkLayer.progressWidth = 10.0;//设置圆环刻度宽
tkLayer.progress = 0.7; //设置进度
[tkLayer setProgress:0.7 animated:YES]; //设置进度带动画
[self.view.layer addSublayer:tkLayer];
 
//dataSource
-(NSArray*)lineDashPatternArray{
return @[@(5),@(10)];
}
-(TKArcAngle)circleAngle{

return  (TKArcAngle){M_PI,2*M_PI};
}
*/
/*********************************/
//  Created by Leon on 16/9/6.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
typedef struct _TKArcAngle {
    CGFloat startAngle;
    CGFloat endAngle;
} TKArcAngle;

typedef  NS_ENUM(NSInteger,TickCircleType){
    TickCircleTypeCustom,
    TickCircleTypeCircle,//整圆
    TickCircleTypeOpenBottom, //下开口圆
};

@protocol TickCircleDatasource <NSObject>
@optional
-(TKArcAngle)circleAngle;// 画圆弧的起止位置，传弧度 ***在 TickCircleTypeCustom下时必须实现该方法
-(NSArray*)lineDashPatternArray; //刻度宽度和 刻度间隔宽度 如@[@(1),@(2)] 1表示刻度宽， 2表示间隔
@end
@interface TickCircleShapeLayer : CAShapeLayer{
    UIBezierPath *_trackPath; //底色圆环path
    CAShapeLayer *_progressLayer; //进度图层
    UIBezierPath *_progressPath; //进度圆弧path
}
@property(nonatomic,strong)UIColor *trackColor;//底色
@property(nonatomic,strong)UIColor *progressColor;//进度颜色
@property(nonatomic,assign)float progress;//0-1之间的数字
@property(nonatomic,assign)float progressWidth;
@property(nonatomic,assign) id<TickCircleDatasource> dataSource;//自定义type时选择实现

-(void)setProgress:(float)progress animated:(BOOL)animated;

-(instancetype)initLayerWithArcCenter:(CGPoint)center radius:(CGFloat)radius style:(TickCircleType)style;

+(instancetype)TickCircleLayerWithArcCenter:(CGPoint)center radius:(CGFloat)radius style:(TickCircleType)style;

@end
