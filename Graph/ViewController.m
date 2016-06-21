//
//  ViewController.m
//  Graph
//
//  Created by Marcus Osobase on 2016-06-17.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import "ViewController.h"
#import "GraphView.h"
#import "Network.h"
#import "GraphScrollView.h"
#import "NSColor+Theme.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController()

@property (nonatomic) IBOutlet GraphView *graphView;
@property (nonatomic) IBOutlet GraphScrollView *graphScrollView;

@end


@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.graphView.strokeGradientColors =
  @[(__bridge id)NSColorFromRGB(0x6fbb3d).CGColor,
    (__bridge id)NSColorFromRGB(0x01b0bd).CGColor];
  
  self.graphView.graphDataInputType = GraphDataInputRolling;
//  
//  self.graphView.data = [self generateRandomDataWithNumberOfItems:100
//                                                         maxValue:250];
  
  
  
//
//  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//    NSMutableArray *update = [NSMutableArray arrayWithArray:self.graphView.data];
//    [update addObjectsFromArray:[self generateRandomDataWithNumberOfItems:10 maxValue:250]];
//    
//    self.graphView.data = update;
//    
//  });
  
  [self populateWithNetworkActivity];
  
}


- (void)viewWillAppear
{
  [super viewWillAppear];
  [self.graphView.layer setNeedsDisplay];
}

- (void)populateWithNetworkActivity
{
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    
    NSDictionary *vals = [Network.instance usage];
    float newVal = [[vals objectForKey:@"WiFiReceived"] floatValue];
   
    NSMutableArray *update = [NSMutableArray arrayWithArray:self.graphView.data];
    [update addObject:[NSNumber numberWithFloat:newVal]];
    
    self.graphView.data = update;
    
    [self populateWithNetworkActivity];
    
  });
}

- (void)setRepresentedObject:(id)representedObject {
  [super setRepresentedObject:representedObject];
  
  // Update the view, if already loaded.
}


- (NSArray *)generateRandomDataWithNumberOfItems: (int)numberOfItems
                                        maxValue: (int)maxValue
{
  NSMutableArray *data = [NSMutableArray new];
  
  for (int i = 0; i < numberOfItems; i++)
  {
    int value = (arc4random() % maxValue);
    [data insertObject:@(value) atIndex:i];
  }
  
  NSLog(@"%@", data);
  
  return data;
  
}

@end
