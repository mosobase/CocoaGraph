//
//  NSBezierPath+utilities.m
//  TunnelBear
//
//  Created by Marcus Osobase on 2016-01-05.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import "NSBezierPath+utilities.h"

@implementation NSBezierPath (BezierPathQuartzUtilities)
- (CGPathRef)newQuartzPath
{
  int i, numElements;
  
  // Need to begin a path here.
  CGPathRef           immutablePath = NULL;
  
  // Then draw the path elements.
  numElements = (int)[self elementCount];
  if (numElements > 0)
  {
    CGMutablePathRef    path = CGPathCreateMutable();
    NSPoint             points[3];
    BOOL                didClosePath = YES;
    
    for (i = 0; i < numElements; i++)
    {
      switch ([self elementAtIndex:i associatedPoints:points])
      {
        case NSMoveToBezierPathElement:
          CGPathMoveToPoint(path, NULL, points[0].x, points[0].y);
          break;
          
        case NSLineToBezierPathElement:
          CGPathAddLineToPoint(path, NULL, points[0].x, points[0].y);
          didClosePath = NO;
          break;
          
        case NSCurveToBezierPathElement:
          CGPathAddCurveToPoint(path, NULL, points[0].x, points[0].y,
                                points[1].x, points[1].y,
                                points[2].x, points[2].y);
          didClosePath = NO;
          break;
          
        case NSClosePathBezierPathElement:
          CGPathCloseSubpath(path);
          didClosePath = YES;
          break;
      }
    }
    
    // Be sure the path is closed or Quartz may not do valid hit detection.
    if (!didClosePath)
      CGPathCloseSubpath(path);
    
    immutablePath = CGPathCreateCopy(path);
    CGPathRelease(path);
  }
  
  return immutablePath;
}

- (void)addQuadCurveToPoint:(CGPoint)QP2 controlPoint:(CGPoint)QP1
{
  CGPoint QP0 = [self currentPoint];
  CGPoint CP3 = QP2;
  
  CGPoint CP1 = CGPointMake(
                            //  QP0   +   2   / 3    * (QP1   - QP0  )
                            QP0.x + ((2.0 / 3.0) * (QP1.x - QP0.x)),
                            QP0.y + ((2.0 / 3.0) * (QP1.y - QP0.y))
                            );
  
  CGPoint CP2 = CGPointMake(
                            //  QP2   +  2   / 3    * (QP1   - QP2)
                            QP2.x + (2.0 / 3.0) * (QP1.x - QP2.x),
                            QP2.y + (2.0 / 3.0) * (QP1.y - QP2.y)
                            );
  
  [self curveToPoint:CP3 controlPoint1:CP1 controlPoint2:CP2];
}

@end
