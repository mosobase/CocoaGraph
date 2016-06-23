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

static const CGFloat PaddingBottom = 0.001;

@interface GraphView()

//@property (nonatomic) NSBezierPath *path;
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
  self.layer.backgroundColor = [NSColor clearColor].CGColor;
  [self.layer setNeedsDisplay];
}

- (void)setDefaults
{
  self.dataSpacing    = 30;
  self.lineCurveValue = 0.5;
  self.lineWidth = 2;
  self.rollingUpdateFrequency = 1 * Second;
  self.rollingMaxHistoryInterval = 1 * Minute;
  
  self.paddingTop = 5;
  [self refresh];
  
}

- (void)refresh
{
  self.data = [self populateEmptyData];
  [self updateFrame];
}

- (NSArray *)populateEmptyData
{
  int maxNumberOfGraphPoints = self.rollingUpdateFrequency *
  self.rollingMaxHistoryInterval;
  NSMutableArray *defaultArray = [NSMutableArray new];
  
  for (int i= 0 ; i < maxNumberOfGraphPoints; i++)
  {
    [defaultArray addObject:@(0)];
  }
  
  return defaultArray;
}

-(void)updateLayer
{
  if (self.data.count == 0) return;
  
  void (^segmentAdder)(NSPoint, NSPoint, NSBezierPath *) =
  ^(NSPoint startPoint, NSPoint endPoint, NSBezierPath *path) {
    self.lineStyle == LineStyleSmooth ?
    [self addCurvedLineSegmentFrom:startPoint to:endPoint inPath:path] :
    [self addStraigtLineSegmentFrom:startPoint to:endPoint inPath:path];
  };
  
  NSBezierPath *path = [NSBezierPath bezierPath];
  [path moveToPoint:NSZeroPoint];
  
  NSArray *activeGraphPoints = self.activeGraphPoints;
  double maxActiveYPoint = [self maxYCoordinateInArray:activeGraphPoints];
  double ratio = (self.bounds.size.height - self.paddingTop) / maxActiveYPoint;
  
  [self.scaleView updateVeriticalLabelsWithMaxY:maxActiveYPoint];
  
  if (self.graphDataInputType == GraphDataInputRolling)
  {
    NSPoint startPoint = [activeGraphPoints[0] pointValue];
    startPoint.y *= ratio;
    [path moveToPoint:startPoint];
  }
  
  
  for (int i = 0; i < activeGraphPoints.count; i++)
  {
    NSPoint nextPoint = [activeGraphPoints[i] pointValue];
    nextPoint.y *= ratio;
    nextPoint.y += PaddingBottom;
    segmentAdder(path.currentPoint, nextPoint, path);
  }
  
  NSPoint endPoint = NSMakePoint((self.data.count+1) * self.dataSpacing, 0);
  if (self.graphDataInputType == GraphDataInputConstant)
  { segmentAdder(path.currentPoint, endPoint, path); }
  [path moveToPoint:endPoint];
  
  // NSBezierPaths draw the stroke around the path itself, we need to translate
  // the path to avoid the stroke being cut-off by the view
  NSAffineTransform *trans = [NSAffineTransform transform];
  [trans translateXBy:0 yBy: self.lineWidth/2];
  [path transformUsingAffineTransform: trans];
  
  
  self.graphLayer.path = path.quartzPath;
  self.graphLayer.lineWidth = self.lineWidth;
  self.graphLayer.fillColor = nil;
  self.graphLayer.strokeColor = NSColor.whiteColor.CGColor;
  
  
  self.gradientLayer.startPoint = CGPointMake(0.5,0.0);
  self.gradientLayer.endPoint = CGPointMake(0.5,1.0);
  self.gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width,
                                        self.bounds.size.height);
  
  self.gradientLayer.colors = self.strokeGradientColors ?: [self stockGradient];
  
}

- (void)updateFrame
{
  NSRect frame = [self frame];
  frame.size.width = MAX(((self.data.count-1) * self.dataSpacing),
                         100);
  if (self.graphDataInputType == GraphDataInputConstant)
  {
    frame.size.width += self.dataSpacing;
  }
  
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
  
  switch (self.graphDataInputType) {
    case GraphDataInputConstant:
      [self updateFrame];
      break;
    case GraphDataInputRolling:
      [self truncateData];
      break;
      
    default:
      break;
  }
  
  [self updateGraphPoints];
  [self.layer setNeedsDisplay];
}

- (void)truncateData
{
  int maxNumberOfGraphPoints = (self.bounds.size.width / self.dataSpacing) + 1;
  
  if (self.data.count <= maxNumberOfGraphPoints) return;
  
  NSRange truncRange =
  NSMakeRange(self.data.count - maxNumberOfGraphPoints, maxNumberOfGraphPoints);
  NSArray *truncData = [self.data subarrayWithRange:truncRange];
  
  _data = truncData;
}

- (void)updateGraphPoints
{
  self.graphPoints = [NSMutableArray new];
  
  switch (self.graphDataInputType) {
    case GraphDataInputConstant:
    {
      for (int i = 0; i < self.data.count; i++) {
        
        NSPoint nextPoint = NSMakePoint((i+1) * self.dataSpacing,
                                        [self.data[i] floatValue]);
        
        [self.graphPoints addObject:[NSValue valueWithPoint:nextPoint]];
      }
    }
      break;
    case GraphDataInputRolling:
    {
//      NSPoint lastPoint = NSMakePoint(self.bounds.size.width, 0);
      
      for (long i = self.data.count-1; i >= 0; i--) {
        NSPoint nextPoint = NSMakePoint(i * self.dataSpacing ,
                                        [self.data[i] floatValue]);
        
//        lastPoint.x -= self.dataSpacing;
        
        [self.graphPoints insertObject:[NSValue valueWithPoint:nextPoint]
                               atIndex:0];
      }
    }
      break;
      
    default:
      break;
      
  }
}

-(NSArray *)activeGraphPoints
{
  return [self.graphPoints subarrayWithRange:[self rangeForAcivePoints]];
}

- (double)maxYCoordinateInArray: (NSArray *)array
{
  double max = 1;
  
  for (NSValue *value in array)
  {
    NSPoint pointValue = [value pointValue];
    if (pointValue.y >= max) max = pointValue.y;
  }
  
  return max;
}

-(void)setRollingUpdateFrequency:(NSTimeInterval)rollingUpdateFrequency
{
  _rollingUpdateFrequency = rollingUpdateFrequency;
  [self refresh];
}

-(void)setRollingMaxHistoryInterval:(NSTimeInterval)rollingMaxHistoryInterval
{
  _rollingMaxHistoryInterval = rollingMaxHistoryInterval;
  [self refresh];
}

-(void)setDataSpacing:(CGFloat)dataSpacing
{
  _dataSpacing = dataSpacing;
  [self refresh];
}

-(void)setGraphDataInputType:(GraphDataInputType)graphDataInputType
{
  _graphDataInputType = graphDataInputType;
  [self refresh];
  
  if (graphDataInputType == GraphDataInputRolling) {
    
    NSClipView *contentView = [self.enclosingScrollView contentView];
    [contentView setBoundsOrigin:
     NSMakePoint(self.enclosingScrollView.documentView.frame.size.width
                 - self.enclosingScrollView.documentVisibleRect.size.width, 0)];
  }
  
}

- (NSArray *)stockGradient
{
  NSMutableArray *colors = [NSMutableArray array];
  for (int i = 0; i < 10; i++) {
    [colors addObject:(id)[[NSColor colorWithHue:(0.1 * i) saturation:1
                                      brightness:.8 alpha:1] CGColor]];
  }
  
  return colors;
}

#pragma mark Private Methods

- (NSRange)rangeForAcivePoints
{
  float contentXOffset = self.enclosingScrollView.documentVisibleRect.origin.x;
  
  int relativeMinPoint = floor(contentXOffset / self.dataSpacing);
  int relativeMaxPoint =
  ceil((contentXOffset + self.enclosingScrollView.documentVisibleRect.size.width)
                              / self.dataSpacing);
  
  int absoluteMinPoint = 0;
  int absoluteMaxPoint = (int)self.data.count;
  
  int numberOfOffscreenPoints = 2;
  
  int minPoint = [self limitValue:relativeMinPoint - numberOfOffscreenPoints
                          between:absoluteMinPoint and:absoluteMaxPoint];
  int maxPoint = [self limitValue:relativeMaxPoint + numberOfOffscreenPoints
                          between:absoluteMinPoint and:absoluteMaxPoint];
  
  NSRange activeRange = NSMakeRange(minPoint, (maxPoint - minPoint));
  return activeRange;
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
