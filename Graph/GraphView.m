//
//  GraphView.m
//  Graph
//
//  Created by Marcus Osobase on 2016-06-17.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import "GraphView.h"
#import "NSBezierPath+utilities.h"
#import "NSColor+Theme.h"
#import <QuartzCore/QuartzCore.h>


@interface GraphView()

@property (nonatomic) NSBezierPath *path;
@property (nonatomic) CAShapeLayer *graphLayer;
@property (nonatomic) CAGradientLayer *gradientLayer;
@property (nonatomic) NSMutableArray *graphPoints;
@property (nonatomic) NSArray *activeGraphPoints;

@end

@implementation GraphView

#pragma mark - Overriden

-(instancetype)initWithCoder:(NSCoder *)coder
{
  if (!(self = [super initWithCoder:coder])) return nil;
  [self setDefaults];
  return self;
}

-(void)awakeFromNib
{
  [super awakeFromNib];
  [self setup];
}

-(BOOL)wantsUpdateLayer
{
  return YES;
}

#pragma mark - Drawing

- (void)setup
{
  self.graphLayer = [CAShapeLayer layer];
  [self.layer addSublayer:self.graphLayer];
  
  self.gradientLayer = [CAGradientLayer layer];
  [self.gradientLayer setMask:self.graphLayer];
  [self.layer addSublayer:self.gradientLayer];
  
  self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
  
  self.layer.backgroundColor = [NSColor blackColor].CGColor;
  [self.layer setNeedsDisplay];
}

- (void)setDefaults
{
  self.lineCurveValue = 0.5;
  self.dataSpacing = 30;
}

//- (void)drawRect:(NSRect)dirtyRect {
//  [super drawRect:dirtyRect];
//
//
//  NSGraphicsContext *context = [NSGraphicsContext currentContext];
//  [context setShouldAntialias:YES];
//
//  CGContextBeginTransparencyLayerWithRect([context CGContext], self.bounds, nil);
//  [[NSColor blueColor] setStroke];
//  [self.path stroke];
//
//  CGContextSetBlendMode([context CGContext], kCGBlendModeSourceIn);
//
//  CGFloat colorLocations[] = {0.0, 1.0};
//  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//  NSArray *colors = @[(__bridge id)NSColorFromRGB(0x6fbb3d).CGColor,
//                      (__bridge id)NSColorFromRGB(0x01b0bd).CGColor];
//
//  CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
//                                                      (__bridge CFArrayRef)colors,
//                                                      colorLocations);
//
//  CGPoint gradientStart = CGPointZero;
//  CGPoint gradientEnd = CGPointMake(0, self.bounds.size.height);
//
//  CGContextDrawLinearGradient([context CGContext], gradient, gradientStart,
//                              gradientEnd, kCGGradientDrawsBeforeStartLocation);
//  CGContextEndTransparencyLayer([context CGContext]);
//
//  CGColorSpaceRelease(colorSpace);
//  CGGradientRelease(gradient);
//
//}

-(void)updateLayer
{
  if (self.data.count == 0) return;
  
  void (^segmentAdder)(NSPoint, NSPoint, NSBezierPath *) =
  ^(NSPoint startPoint, NSPoint endPoint, NSBezierPath *path) {
    self.lineStyle == LineStyleSmooth ?
    [self addCurvedLineSegmentFrom:startPoint to:endPoint inPath:path] :
    [self addStraigtLineSegmentFrom:startPoint to:endPoint inPath:path];
  };
  
  self.path = [NSBezierPath bezierPath];
  [self.path moveToPoint:NSZeroPoint];
  
  for (int i = 0; i < self.activeGraphPoints.count; i++)
  {
    NSPoint nextPoint = [self.activeGraphPoints[i] pointValue];
    segmentAdder(self.path.currentPoint, nextPoint, self.path);
  }
  
  NSPoint endPoint = NSMakePoint((self.data.count+1) * self.dataSpacing, 0);
  [self.path moveToPoint:endPoint];
  
  
  self.graphLayer.path = self.path.quartzPath;
  self.graphLayer.fillColor = nil;
  self.graphLayer.lineWidth = 2;
  self.graphLayer.strokeColor = NSColor.whiteColor.CGColor;
  
  
  self.gradientLayer.startPoint = CGPointMake(0.5,1.0);
  self.gradientLayer.endPoint = CGPointMake(0.5,0.0);
  self.gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
  
  
  NSMutableArray *colors = [NSMutableArray array];
  for (int i = 0; i < 10; i++) {
    [colors addObject:(id)[[NSColor colorWithHue:(0.1 * i) saturation:1 brightness:.8 alpha:1] CGColor]];
  }
  self.gradientLayer.colors = colors;
  
}

- (void)updateFrame
{
  NSRect frame = [self frame];
  frame.size.width = (self.data.count * self.dataSpacing) + self.dataSpacing;
  self.frame = frame;
  
}


- (void)addStraigtLineSegmentFrom: (NSPoint)startPoint
                               to: (NSPoint)endPoint inPath: (NSBezierPath *)path
{
  [path lineToPoint:endPoint];
}


- (void)addCurvedLineSegmentFrom: (NSPoint)startPoint
                              to: (NSPoint)endPoint inPath: (NSBezierPath *)path
{
  float deltaX = endPoint.x - startPoint.x;
  
  float x = startPoint.x + (deltaX * self.lineCurveValue);
  float y = startPoint.y;
  NSPoint controlPointOne = NSMakePoint(x, y);
  
  x = endPoint.x - (deltaX * self.lineCurveValue);
  y = endPoint.y;
  NSPoint controlPointTwo = NSMakePoint(x, y);
  
  [path curveToPoint:endPoint controlPoint1:controlPointOne
       controlPoint2:controlPointTwo];
}

#pragma mark Model

-(void)setData:(NSArray *)data
{
  _data = data;
  [self updateGraphPoints];
  [self updateFrame];
}

- (void)updateGraphPoints
{
  self.graphPoints = [NSMutableArray new];
  
  for (int i = 0; i < self.data.count; i++) {
    
    NSPoint nextPoint = NSMakePoint((i+1) * self.dataSpacing,
                                    [self.data[i] floatValue]);
    
    [self.graphPoints addObject:[NSValue valueWithPoint:nextPoint]];
    
  }
}

-(NSArray *)activeGraphPoints
{
  return [self.graphPoints subarrayWithRange:[self rangeForAcivePoints]];
}

#pragma mark Private Methods


- (NSRange)rangeForAcivePoints
{
  
  NSRect visibleRect = self.enclosingScrollView.documentVisibleRect;
  float contentXOffset = visibleRect.origin.x;
  
  int relativeMinPoint = floor(contentXOffset / self.dataSpacing);
  int relativeMaxPoint = ceil((contentXOffset + visibleRect.size.width)
                              / self.dataSpacing);
  
  int absoluteMinPoint = 0;
  int absoluteMaxPoint = (int)self.data.count - 1;
  
  int numberOfOffscreenPoints = 1;
  
  int minPoint = [self limitValue:relativeMinPoint - numberOfOffscreenPoints
                          between:absoluteMinPoint and:absoluteMaxPoint];
  int maxPoint = [self limitValue:relativeMaxPoint + numberOfOffscreenPoints
                          between:absoluteMinPoint and:absoluteMaxPoint];
  
  return NSMakeRange(minPoint, (maxPoint - minPoint));
}

- (int)limitValue: (int)value between: (int)min and: (int)max
{
  if (value > max)
  {
    return max;
  }
  else if (value < min)
  {
    return min;
  }
  
  return value;
}

@end
