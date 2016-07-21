//
//  GraphScaleView.m
//  Graph
//
//  Created by Marcus Osobase on 2016-06-21.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "GraphScaleView.h"
#import "NSColor+Theme.h"
#import "NSBezierPath+utilities.h"

@interface GraphScaleView()
@property (nonatomic) NSMutableArray *labels;
@property (nonatomic) CGFloat maxY;
@end


@implementation GraphScaleView

- (instancetype)initWithFrame:(NSRect)frame
{
  if (!(self = [super initWithFrame:frame])) return nil;
  
  [self setup];
  [self setDefaults];
  
  return self;
}

-(CAShapeLayer *)makeBackingLayer
{
  return [CAShapeLayer layer];
}

-(BOOL)wantsLayer
{
  return YES;
}

- (void)setup
{
  [self setWantsLayer:YES];
  self.layer.backgroundColor = NSColorFromRGB(0xf2f1f0).CGColor;
  self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawDuringViewResize |
                                   NSViewLayerContentsRedrawOnSetNeedsDisplay;
  
  [self.layer setNeedsDisplay];
  
  self.labels = [NSMutableArray new];
}

- (void)setDefaults
{
  self.numberOfScaleLines = 5;
}

-(void)setNumberOfScaleLines:(int)numberOfScaleLines
{
  _numberOfScaleLines = numberOfScaleLines;
  [self createVerticalLabels];
}

//-(void)drawRect:(NSRect)dirtyRect
//{
//  [super drawRect:dirtyRect];
//}
//
//-(void)updateLayer
//{
//  NSBezierPath *path = [NSBezierPath bezierPath];
//  
//  for (int i = 0; i <= self.frame.size.height;
//       i += self.frame.size.height / self.numberOfScaleLines)
//  {
//    NSPoint startPoint = NSMakePoint(0, i);
//    NSPoint endPoint   = NSMakePoint(self.frame.size.width, i);
//    
//    [self addStraigtLineSegmentFrom:startPoint to:endPoint inPath:path];
//  }
//  
//  ((CAShapeLayer *)self.layer).path = path.quartzPath;
//  ((CAShapeLayer *)self.layer).strokeColor = NSColorFromRGB(0xDCDBD8).CGColor;
//  ((CAShapeLayer *)self.layer).lineWidth = 1.5;
//
//}


-(void)drawLayer:(CAShapeLayer *)layer inContext:(CGContextRef)ctx
{
  NSBezierPath *path = [NSBezierPath bezierPath];
  
  for (int i = 0; i <= self.frame.size.height;
       i += self.frame.size.height / self.numberOfScaleLines)
  {
    NSPoint startPoint = NSMakePoint(0, i);
    NSPoint endPoint   = NSMakePoint(self.frame.size.width, i);
    
    [self addStraigtLineSegmentFrom:startPoint to:endPoint inPath:path];
  }
  
  CGPathRef quartzPath = [path newQuartzPath];
  layer.path = quartzPath;
  CGPathRelease(quartzPath);
    
  layer.strokeColor = NSColorFromRGB(0xDCDBD8).CGColor;
  layer.lineWidth = 1.5;
}

- (void)addStraigtLineSegmentFrom: (NSPoint)startPoint
                               to: (NSPoint)endPoint inPath: (NSBezierPath *)path
{
  [path moveToPoint:startPoint];
  [path lineToPoint:endPoint];
}

- (void)updateVeriticalLabelsWithMaxY: (int)maxY
{
  if (maxY == self.maxY) return;
  self.maxY = maxY;
  
  for (int i = 0; i < self.labels.count; i++)
  {
    NSTextField *label = self.labels[i];
    label.stringValue = [NSString stringWithFormat:@"%d",
                         (int)(maxY / self.numberOfScaleLines) * i];
    
  }
}

- (void)createVerticalLabels
{
  for (NSTextField *label in self.labels)
  {
    [label removeFromSuperview];
  }
  
  self.labels = [NSMutableArray new];
  
  for (int i = 0; i < self.numberOfScaleLines; i ++)
  {
    CGFloat y = i * (self.frame.size.height / self.numberOfScaleLines);
    
    NSRect frame = NSMakeRect(10, y, 50, 20);
    NSTextField *label = [[NSTextField alloc] initWithFrame:frame];
    [label setBordered:NO];
    [label setBezeled:NO];
    [label setDrawsBackground:NO];
    [label setTextColor:NSColorFromRGB(0x746f65)];
    
    label.stringValue = [NSString stringWithFormat:@"%d", i];
    
    [self addSubview:label];
    [self.labels addObject:label];
  }
  
  [self updateVeriticalLabelsWithMaxY:10];
}

@end
