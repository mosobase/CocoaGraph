//
//  NSBezierPath+utilities.h
//  TunnelBear
//
//  Created by Marcus Osobase on 2016-01-05.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSBezierPath (BezierPathQuartzUtilities)
- (CGPathRef)newQuartzPath;
- (void)addQuadCurveToPoint:(CGPoint)QP2 controlPoint:(CGPoint)QP1;
@end
