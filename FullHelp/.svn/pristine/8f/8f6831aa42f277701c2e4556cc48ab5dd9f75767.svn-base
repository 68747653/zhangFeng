//
//  CirclePorgressView.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "CirclePorgressView.h"

@implementation CirclePorgressView
- (instancetype) init {
    if (self = [super init]) {
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取上下文
    
    CGPoint center1 = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);  //设置圆心位置
    CGFloat radius1 = self.frame.size.width/2-10;  //设置半径
    CGFloat startA1 = - M_PI_2;  //圆起点位置
    CGFloat endA1 = -M_PI_2 + M_PI * 2;  //圆终点位置
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center1 radius:radius1 startAngle:startA1 endAngle:endA1 clockwise:YES];
    CGContextSetLineWidth(ctx, 5);
    [[UIColor colorWithWhite:0.7 alpha:0.5] setStroke];
    CGContextAddPath(ctx, path1.CGPath);
    CGContextStrokePath(ctx);
    
    CGPoint center = center1;  //设置圆心位置
    CGFloat radius = radius1;  //设置半径
    CGFloat startA = startA1;  //圆起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;  //圆终点位置
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    CGContextSetLineWidth(ctx, 5); //设置线条宽度
    [[UIColor whiteColor] setStroke]; //设置描边颜色
    CGContextAddPath(ctx, path.CGPath); //把路径添加到上下
    CGContextStrokePath(ctx);  //渲染
    
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetRGBFillColor (ctx, 0.5, 0.5, 0.5, 0.5);
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    UIFont  *font = [UIFont boldSystemFontOfSize:14.0];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,style,NSParagraphStyleAttributeName, nil];
    NSString *progressStr = [NSString stringWithFormat:@"已抢\n%.0f%%",_progress*100];
    [progressStr drawInRect:CGRectMake(0, (self.frame.size.height-35)/2, self.frame.size.width, 35) withAttributes:dic];
}
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}
@end
